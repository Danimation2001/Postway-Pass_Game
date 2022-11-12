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
    public GameObject noticePanel;
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
        {
            Time.timeScale = 0;
            Cursor.lockState = CursorLockMode.None;
            noticePanel.SetActive(true);
        }
    }

    public void CloseNotice()
    {
        Time.timeScale = 1;
        Cursor.lockState = CursorLockMode.Locked;
        noticePanel.SetActive(false);
    }

    public GameObject barrier;
    public Animator gateAnim;
    IEnumerator OpenGate()
    {
        gateOpen = true;
        interact.Disable();
        interactCanvas.GetComponent<Animator>().Play("Fade Out");
        // PLAY OPENNING ANIMATION.
        gateAnim.Play("Gate_Open");
        yield return new WaitForSeconds(1.5f);
        barrier.SetActive(false);
        GameManager.Instance.unlockedCemeteryGate = true;
    }
}