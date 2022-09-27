using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.InputSystem;
using UnityEngine.Animations;
using TMPro;
using Ink.Runtime;
using UnityEngine.EventSystems;

public class NPC : MonoBehaviour
{
    private static NPC instance;
    
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


     private void Awake()
    {
        if (instance != null)
        {
            Debug.Log("Found more than Dialogue Manager in the scene");
        }

        instance = this;
    }

    void Start()
    {
        interact.Disable();
        dialogueIsPlaying = false;
        dialogueUI.SetActive(false);

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
    public static NPC GetInstance() 
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
         //return if dialogue isn't playing
        if(!dialogueIsPlaying)
        {
            return;
        }   
        //continue to next line in the dialogue when next is pressed
        if (currentStory.currentChoices.Count == 0 && Input.GetKeyDown(KeyCode.Return))
        {
            ContinueStory();
        }
    }

    
    void Interact(InputAction.CallbackContext context) //set the dialogue UI 
    {
        if(!dialogueUI.activeSelf)
        {
            dialogueUI.SetActive(true);
            Cursor.lockState = CursorLockMode.None;
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
        yield return new WaitForSeconds(0.2f);

        dialogueIsPlaying = false;
        dialogueUI.SetActive(false);
        dialogueText.text = "";

    }

    private void ContinueStory()
    {
          if (currentStory.canContinue)
        {
            dialogueText.text = currentStory.Continue();
            //display choices if there are any
            DisplayChoices();
        }
        else
        {
            StartCoroutine(ExitDialogueMode());
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
