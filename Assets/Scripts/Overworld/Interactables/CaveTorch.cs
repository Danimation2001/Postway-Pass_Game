using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.InputSystem;
using UnityEngine.Animations;

public class CaveTorch : MonoBehaviour
{
    public bool startTorch;
    public bool lit;

    public InputAction interact;
    ConstraintSource _constraintSource;
    public GameObject interactCanvas;

    [Header("PLACEHOLDER. REMOVE WHEN FINAL ASSET IS READY")]
    public Material offMat, onMat;

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
        interact.Disable();
        _constraintSource.sourceTransform = Camera.main.transform;
        _constraintSource.weight = 1;

        GetComponentInChildren<LookAtConstraint>().AddSource(_constraintSource);
    }

    //entering trigger radius
    public void OnTriggerEnter(Collider other)
    {
        if (other.tag == "Player" && !lit)
        {
            // if the puzzle hasn't started yet, light the torch and start the puzzle
            if (!TorchPuzzleManager.Instance.puzzleHasStarted && startTorch)
            {
                interact.Enable();
                interactCanvas.GetComponent<Animator>().Play("Fade In");
            }
            else if (TorchPuzzleManager.Instance.puzzleHasStarted)// just light the torch
                LightTorch();
        }
    }

    public void OnTriggerExit(Collider other)
    {
        if (other.tag == "Player" && startTorch && !TorchPuzzleManager.Instance.puzzleHasStarted)
        {
            interact.Disable();
            interactCanvas.GetComponent<Animator>().Play("Fade Out");
        }
    }

    void Interact(InputAction.CallbackContext context)
    {
        StartTorch();
    }

    void StartTorch()
    {
        interact.Disable();
        interactCanvas.GetComponent<Animator>().Play("Fade Out");
        LightTorch();
        TorchPuzzleManager.Instance.puzzleHasStarted = true;
        Debug.Log("STARTED THE CHALLENGE!");
    }

    public void Extinguish()
    {
        GetComponentInChildren<MeshRenderer>().material = offMat;
        lit = false;
    }

    public void LightTorch()
    {
        GetComponentInChildren<MeshRenderer>().material = onMat;
        lit = true;
    }
}