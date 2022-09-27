using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.InputSystem;
using UnityEngine.Animations;
using TMPro;
using Ink.Runtime;

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
        if (Input.GetKeyDown(KeyCode.Return))
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

    private void ExitDialogueMode() 
    {
        dialogueIsPlaying = false;
        dialogueUI.SetActive(false);
        dialogueText.text = "";

    }

    private void ContinueStory()
    {
          if (currentStory.canContinue)
        {
            dialogueText.text = currentStory.Continue();
        }
        else
        {
            ExitDialogueMode();
        }
    }

    

}
