using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.InputSystem;
using UnityEngine.Animations;

public class WinterGate : MonoBehaviour
{
    public InputAction interact;
    ConstraintSource _constraintSource;
    public GameObject interactCanvas;
    bool gateOpen;

    void OnEnable()
    {
        interact.Enable();
        interact.performed += Interact;
    }

    void OnDisable()
    {
        interact.Disable();
    }


    // Start is called before the first frame update
    void Start()
    {
        if (GameManager.Instance.unlockedCemeteryGate)
        {
            StartCoroutine(OpenGate());
        }

        interact.Disable();
        _constraintSource.sourceTransform = Camera.main.transform;
        _constraintSource.weight = 1;
        GetComponentInChildren<LookAtConstraint>().AddSource(_constraintSource);
    }

    //entering trigger radius
    public void OnTriggerEnter(Collider other)
    {
        if (other.tag == "Player" && !gateOpen)
        {
            interact.Enable();
            interactCanvas.GetComponent<Animator>().Play("Fade In");
        }
    }

    public void OnTriggerExit(Collider other)
    {
        if (other.tag == "Player" && !gateOpen)
        {
            interact.Disable();
            interactCanvas.GetComponent<Animator>().Play("Fade Out");
        }
    }

    void Interact(InputAction.CallbackContext context)
    {

        if (GameManager.Instance.hasFrozenKey)
            StartCoroutine(OpenGate());
        // INFORM THE PLAYER THAT THEY NEED THE KEY!
        else
            Debug.Log("YOU DON'T HAVE THE KEY!");
    }

    IEnumerator OpenGate()
    {
        gateOpen = true;
        interact.Disable();
        interactCanvas.GetComponent<Animator>().Play("Fade Out");
        // PLAY OPENNING ANIMATION.
        yield return new WaitForSeconds(0);

        // PLACEHOLDER
        gameObject.SetActive(false);
    }
}