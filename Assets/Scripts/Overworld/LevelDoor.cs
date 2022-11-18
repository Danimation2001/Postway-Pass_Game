using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.InputSystem;

public class LevelDoor : MonoBehaviour
{
    public GameObject interactUI;
    public GameObject popupUI;
    public InputAction interact;

    bool activePopup;

    void OnEnable()
    {
        interact.Enable();
        interact.performed += Interact;
    }

    void OnDisable()
    {
        interact.Disable();
    }

    void Interact(InputAction.CallbackContext context)
    {
        interact.Disable();
        interactUI.GetComponent<Animator>().Play("Fade Out");
        popupUI.SetActive(true);
        activePopup = true;
        Cursor.lockState = CursorLockMode.None;
    }

    // Start is called before the first frame update
    void Start()
    {
        interact.Disable();
    }

    void Update()
    {
        if(activePopup)
        {
            Cursor.lockState = CursorLockMode.None;
        }
    }

    private void OnTriggerEnter(Collider other)
    {
        if (other.tag == "Player")
        {
            interact.Enable();
            interactUI.GetComponent<Animator>().Play("Fade In");
        }
    }

    private void OnTriggerExit(Collider other)
    {
        if (other.tag == "Player")
        {
            interact.Disable();
            interactUI.GetComponent<Animator>().Play("Fade Out");
        }
    }

    public void LockMouse()
    {
        Cursor.lockState = CursorLockMode.Locked;
        popupUI.SetActive(false);
        activePopup = false;
    }

    public void UnlockMouse()
    {
        Cursor.lockState = CursorLockMode.None;
    }
}