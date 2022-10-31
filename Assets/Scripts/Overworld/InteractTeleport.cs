using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.InputSystem;

public class InteractTeleport : MonoBehaviour
{
    public Transform destination;
    public GameObject interactUI;
    GameObject _player;
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
        StartCoroutine(Teleport());
    }

    void Start()
    {
        interact.Disable();
    }

    private void OnTriggerEnter(Collider other)
    {
        if (other.tag == "Player")
        {
            _player = other.transform.parent.gameObject;
            interact.Enable();
            Debug.Log("Triggered");
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

    IEnumerator Teleport()
    {
        // fade out and disable control
        SceneLoader.Instance.transition.Play("Fade Game Out");
        _player.GetComponent<Rigidbody>().isKinematic = true;
        yield return new WaitForSeconds(1);
        _player.GetComponent<RBController>().enabled = false;

        // teleport
        _player.transform.position = destination.position;
        yield return new WaitForSeconds(0.5f);

        //fade in and enable control
        SceneLoader.Instance.transition.Play("Fade Game In");
        _player.GetComponent<RBController>().enabled = true;
        _player.GetComponent<Rigidbody>().isKinematic = false;
        yield return new WaitForSeconds(1);
    }
}