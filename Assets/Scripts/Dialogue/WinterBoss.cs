using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.InputSystem;
using UnityEngine.Animations;
using TMPro;
using Ink.Runtime;
using UnityEngine.EventSystems;
using Cinemachine;

public class WinterBoss : MonoBehaviour
{
    private static WinterBoss instance;
    public SceneLoader sceneloader;

    [SerializeField] public GameObject player;
    [SerializeField] public Animator playerAnimation;
    public Animator npcAnimator;
    
    [SerializeField] public GameObject interactDialogue; //Interact button for dialogue (e)
    [SerializeField] public GameObject dialogueUI; //UI Canvas for dialogue
    public bool dialogueIsPlaying { get; private set; }//when dialogue is playing
    [SerializeField] public InputAction interact; //interact button to trigger the dialogue canvas as true
    [SerializeField] private TextMeshProUGUI dialogueText; //text that handles the dialogue

    [Header ("Ink JSON")]
    [SerializeField] private TextAsset inkJSON;
    private Story currentStory;

    [Header ("Ink Choices")]
    [SerializeField] private GameObject[] choices;
    private TextMeshProUGUI[] choicesText;

    [Header("Typing")]
    [SerializeField] private float typingSpeed = 0.05f;
    //[SerializeField] private float typingSpeedFast = 0.001f;
    private Coroutine displayLineCoroutine;
    private bool canContinueToNextLine = false;
    private bool returnButtonPressedThisFrame = false;

    public CinemachineTargetGroup targetGroup;
    public GameObject dialoguecam;
    public GameObject playercam;

    [SerializeField] private GameObject continueIcon;

     private void Awake()
    {
        if (instance != null)
        {
            Debug.Log("Found more than Dialogue Manager in the scene");
        }

        instance = this;
    }

    private void FixedUpdate() {
        
    }

    void Start()
    {
        interact.Disable();
        dialogueIsPlaying = false;
        dialogueUI.SetActive(false);
        dialoguecam.SetActive(false);

        //get all of the choices text
        choicesText = new TextMeshProUGUI[choices.Length];
        int index = 0;
        foreach(GameObject choice in choices)
        {
            choicesText[index] = choice.GetComponentInChildren<TextMeshProUGUI>();
            index++;
        }
    }

    void OnEnable()
    {
        interact.Enable();
        interact.performed += Interact;
    }

    void OnDisable()
    {
        interact.Disable();
    }
    public static WinterBoss GetInstance() 
    {
        return instance;
    }


    private void OnTriggerEnter(Collider other)
    {
        if (other.tag == "Player")
        {
            interact.Enable();
            interactDialogue.GetComponent<Animator>().Play("Fade In");
            
        }
    }

    private void OnTriggerExit(Collider other)
    {
        if (other.tag == "Player")
        {
            interact.Disable();
            interactDialogue.GetComponent<Animator>().Play("Fade Out");
        }
    }

    // Update is called once per frame
    void Update()
    {

        if(Input.GetKeyDown(KeyCode.Return) || Input.GetKeyDown(KeyCode.E) || Input.GetButtonDown("Fire1"))
        {
            returnButtonPressedThisFrame = true;
        }
         //return if dialogue isn't playing
        if(!dialogueIsPlaying)
        {
            return;
        }   
        //continue to next line in the dialogue when next is pressed
        if (canContinueToNextLine && returnButtonPressedThisFrame && currentStory.currentChoices.Count == 0)
        {
            returnButtonPressedThisFrame = false;
            ContinueStory();
        }
    }

    
    void Interact(InputAction.CallbackContext context) //set the dialogue UI 
    {
        if(!dialogueUI.activeSelf)
        {
            interact.Disable();
            interactDialogue.GetComponent<Animator>().Play("Fade Out");
            dialogueUI.SetActive(true);
            Cursor.lockState = CursorLockMode.None;
            targetGroup.m_Targets[1].target = gameObject.transform;
            dialoguecam.SetActive(true);
            playercam.SetActive(false);
           EnterDialogueMode(inkJSON);
        }
          
    }

    private void EnterDialogueMode(TextAsset inkJSON)
    {
        currentStory = new Story(inkJSON.text);
        dialogueIsPlaying = true;
        dialogueUI.SetActive(true);

        ContinueStory();
    }

    private IEnumerator ExitDialogueMode() 
    {
        Cursor.lockState = CursorLockMode.Locked;
        yield return new WaitForSeconds(0.5f);
        dialogueIsPlaying = false;
        dialogueUI.SetActive(false);
        dialogueText.text = "";
        dialoguecam.SetActive(false);
        playercam.SetActive(true);
        sceneloader.LoadWinterBattleScene();
    }

    private void ContinueStory()
    {
          if (currentStory.canContinue)
        {
            //npcAnimator.SetBool("isTalking", true);
            // dialogueText.text = currentStory.Continue();
            if (displayLineCoroutine != null )
            {
                StopCoroutine(displayLineCoroutine);
            }
            displayLineCoroutine = StartCoroutine(DisplayLine(currentStory.Continue()));
            //display choices if there are any
           
        }
        else
        {
            StartCoroutine(ExitDialogueMode());
        }
    }


    private IEnumerator DisplayLine(string line)
    {
        //empty dialogue text so previous line no longer shows
        dialogueText.text = "";
        

        //hide items when text is typing
        continueIcon.SetActive(false);
        HideChoices();

        canContinueToNextLine = false;
        //display each letter one at a time
        foreach (char letter in line.ToCharArray())
        {
            if(returnButtonPressedThisFrame)
            {
            returnButtonPressedThisFrame = false;
            dialogueText.text = line;
            break;
            //dialogueText.text += letter;
            //yield return new WaitForSeconds(typingSpeedFast);
          }
          else{
            dialogueText.text += letter;
            yield return new WaitForSeconds(typingSpeed);
          }
        }

        //actions to to take after the entire line has finished displaying
        continueIcon.SetActive(true);
        DisplayChoices();
        //npcAnimator.SetBool("isTalking", false);
        canContinueToNextLine = true;

    }

    private void HideChoices()
    {
        foreach (GameObject choiceButton in choices)
        {
            choiceButton.SetActive(false);
        }
    }

    private void DisplayChoices() 
    {
        List<Choice> currentChoices = currentStory.currentChoices;

        // defensive check to make sure our UI can support the number of choices coming in
        if (currentChoices.Count > choices.Length)
        {
            Debug.LogError("More choices were given than the UI can support. Number of choices given: " 
                + currentChoices.Count);
        }

        int index = 0;
        // enable and initialize the choices up to the amount of choices for this line of dialogue
        foreach(Choice choice in currentChoices) 
        {
            choices[index].gameObject.SetActive(true);
            choicesText[index].text = choice.text;
            index++;
        }
        // go through the remaining choices the UI supports and make sure they're hidden
        for (int i = index; i < choices.Length; i++) 
        {
            choices[i].gameObject.SetActive(false);
        }

        StartCoroutine(SelectFirstChoice());
    }

    private IEnumerator SelectFirstChoice()
    {
        // Event system requires we clear it first and then wait for atleast one frame before we set the current selected object
        EventSystem.current.SetSelectedGameObject(null);
        yield return new WaitForEndOfFrame();
        EventSystem.current.SetSelectedGameObject(choices[0].gameObject);

    }

    public void MakeChoice(int choiceIndex)
    {
    
            currentStory.ChooseChoiceIndex(choiceIndex);
            ContinueStory();
        
        
    }

    

}
