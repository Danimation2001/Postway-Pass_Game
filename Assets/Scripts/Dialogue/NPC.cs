using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.InputSystem;
using UnityEngine.Animations;
using TMPro;

public class NPC : MonoBehaviour
{
    [SerializeField] public GameObject dialogueCanvas;
    [SerializeField] public GameObject dialogueUI;
    [SerializeField] public InputAction interact;
    // Start is called before the first frame update

    void OnEnable()
    {
        interact.Enable();
        interact.performed += Interact;
    }

    void OnDisable()
    {
        interact.Disable();
    }


    private void OnTriggerEnter(Collider other)
    {
        if (other.tag == "Player")
        {
            interact.Enable();
            dialogueCanvas.GetComponent<Animator>().Play("Fade In");
        }
    }
    private void OnTriggerExit(Collider other)
    {
        if (other.tag == "Player")
        {
            interact.Disable();
            dialogueCanvas.GetComponent<Animator>().Play("Fade Out");
        }
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    
    void Interact(InputAction.CallbackContext context)
    {
        if(!dialogueUI.activeSelf)
        {
            dialogueUI.SetActive(true);
            Cursor.lockState = CursorLockMode.None;
        }
    }

    
    void Start()
    {
        interact.Disable();
        dialogueUI.SetActive(false);
    }

}
