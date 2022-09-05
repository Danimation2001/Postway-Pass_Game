using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.InputSystem;
using UnityEngine.Animations;
using TMPro;

public class HiddenMail : MonoBehaviour
{
    //[SerializeField] private bool triggerActive = false;

    //set up sphere collider to be the trigger collider
    // public Collider triggerCollider;

    public InputAction interact;
    ConstraintSource _constraintSource;
    public GameObject interactCanvas;

    //holds mail object to be revealed
    public Mail hiddenMail;
    public GameObject facadeObject;

    void OnEnable()
    {
        interact.Enable();
        interact.performed += Interact;
    }

    void OnDisable()
    {
        interact.Disable();
    }

    void OnAwake()
    {
        foreach (int id in GameManager.Instance.collectedMail) // check if this mail is marked as been collected
        {
            if (id == hiddenMail.mailID)
            {
                gameObject.SetActive(false);
            }
        }
    }

    //starts with the mail object not visible
    void Start()
    {
        interact.Disable();
        _constraintSource.sourceTransform = Camera.main.transform;
        _constraintSource.weight = 1;

        GetComponentInChildren<LookAtConstraint>().AddSource(_constraintSource);
    }

    //entering trigger radius
    public void OnTriggerEnter(Collider other)
    {
        if (other.tag == "Player")
        {
            //triggerActive = true;
            interact.Enable();
            interactCanvas.GetComponent<Animator>().Play("Fade In");
            Debug.Log("ENTERED trigger radius");
        }
    }

    public void OnTriggerExit(Collider other)
    {
        if (other.tag == "Player")
        {
            //triggerActive = false;
            interact.Disable();
            interactCanvas.GetComponent<Animator>().Play("Fade Out");
            Debug.Log("LEFT trigger radius");

            foreach (int id in GameManager.Instance.collectedMail) // check if this mail is marked as been collected
            {
                if (id == hiddenMail.mailID)
                {
                    gameObject.SetActive(false);
                }
            }
        }
    }

    void Interact(InputAction.CallbackContext context)
    {
        facadeObject.SetActive(false);
        hiddenMail.gameObject.SetActive(true);
        interact.Disable();
        interactCanvas.GetComponent<Animator>().Play("Fade Out");
        GetComponentInChildren<ParticleSystem>().Stop();
        Debug.Log("mail appeared");
    }
}



