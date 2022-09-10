using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class TorchPuzzleManager : MonoBehaviour
{
    private static TorchPuzzleManager _instance;

    public static TorchPuzzleManager Instance
    {
        get
        {
            return _instance;
        }
    }


    public bool puzzleHasStarted;
    public bool puzzleFinished;
    public float puzzleTimer;
    FrozenKey _key;
    float _timer;
    bool[] _litStatus;
    CaveTorch[] _torches;

    void Awake()
    {
        if (_instance != null && _instance != this)
        {
            Destroy(gameObject);
        }
        else
        {
            _instance = this;
        }
    }

    // Start is called before the first frame update
    void Start()
    {
        _timer = puzzleTimer;

        _key = GameObject.FindGameObjectWithTag("Frozen Key").GetComponent<FrozenKey>();

        // Get all the torch objects and assign their caveTorch components to the public array
        GameObject[] torchObs = GameObject.FindGameObjectsWithTag("Torch");
        _torches = new CaveTorch[torchObs.Length];
        for (int i = 0; i < torchObs.Length; i++)
        {
            _torches[i] = torchObs[i].GetComponent<CaveTorch>();
        }

        if (GameManager.Instance.hasFrozenKey)
        {
            CompletePuzzle();
        }
    }

    // Update is called once per frame
    void Update()
    {
        // count down the timer
        if (puzzleHasStarted && !puzzleFinished)
        {
            _timer -= Time.deltaTime;

            if (CheckIfAllLit())
                CompletePuzzle();

            // ran out of time if the timer hits 0
            if (_timer <= 0)
                OutOfTime();
        }
    }

    // check if all the torches have been lit.
    bool CheckIfAllLit()
    {
        bool allLit = true;

        foreach (CaveTorch torch in _torches)
        {
            // if this torch isn't lit then not all torches are lit. if this torch is lit then this if will be ignored
            if (!torch.lit)
                allLit = false;
        }
        return allLit;
    }

    // reset the puzzle
    void OutOfTime()
    {
        Debug.Log("OUT OF TIME");

        // extinguish all the torches
        foreach (CaveTorch torch in _torches)
        {
            torch.Extinguish();
        }

        puzzleHasStarted = false;
        _timer = puzzleTimer;
    }

    void CompletePuzzle()
    {
        Debug.Log("FINISHED");
        puzzleFinished = true;
        _key.canBeCollected = true;

        // KEY MELT ANIMATION?

        // turn on all the torches
        foreach (CaveTorch torch in _torches)
        {
            torch.LightTorch();
        }
    }
}
