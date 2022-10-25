using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.InputSystem;

public class LevelDoor : MonoBehaviour
{
    public GameObject interactUI;
    public GameObject popupUI;
    public InputAction interact;

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
        Cursor.lockState = CursorLockMode.None;
    }

    // Start is called before the first frame update
    void Start()
    {
        interact.Disable();
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
    }

    public void UnlockMouse()
    {
        Cursor.lockState = CursorLockMode.None;
    }
}