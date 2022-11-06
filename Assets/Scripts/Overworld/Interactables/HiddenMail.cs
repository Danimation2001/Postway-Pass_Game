using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.InputSystem;
using UnityEngine.Animations;
using TMPro;

public class HiddenMail : MonoBehaviour
{
    public GameObject smokePoof;

    Animator _anim;
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
        _anim = GetComponent<Animator>();
    }

    //entering trigger radius
    public void OnTriggerEnter(Collider other)
    {
        if (other.tag == "Player")
        {
            //triggerActive = true;
            interact.Enable();
            interactCanvas.GetComponent<Animator>().Play("Fade In");
            //Debug.Log("ENTERED trigger radius");
        }
    }

    public void OnTriggerExit(Collider other)
    {
        if (other.tag == "Player")
        {
            //triggerActive = false;
            interact.Disable();
            interactCanvas.GetComponent<Animator>().Play("Fade Out");
            //Debug.Log("LEFT trigger radius");

            foreach (int id in GameManager.Instance.collectedMail) // check if this mail is marked as been collected
            {
                if (id == hiddenMail.mailID)
                {
                    gameObject.SetActive(false);
                }
            }
        }
    }

    IEnumerator ObjectDisappear()
    {
        interact.Disable();
        //transition animation and poof for facade object to disappear
        _anim.Play("PoofDisappear");
        yield return new WaitForSeconds(1.5f);
        smokePoof.GetComponent<ParticleSystem>().Play();
        yield return new WaitForSeconds(1f);
        facadeObject.SetActive(false);

        //hidden mail appears
        hiddenMail.gameObject.SetActive(true);
        interactCanvas.GetComponent<Animator>().Play("Fade Out");
        //yield return new WaitForSeconds(2.5f);
        GetComponentInChildren<ParticleSystem>().Stop();
        Debug.Log("mail appeared");
    }

    void Interact(InputAction.CallbackContext context)
    {
        StartCoroutine(ObjectDisappear());
    }
}

