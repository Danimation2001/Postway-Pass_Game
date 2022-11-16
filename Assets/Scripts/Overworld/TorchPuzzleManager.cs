using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

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
    IceBlock _iceBlock;
    float _timer;
    bool[] _litStatus;
    CaveTorch[] _torches;

    //for timer UI
    public GameObject timerUI;
    public Image timer_radial;


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

        _key = GameObject.FindGameObjectWithTag("Frozen Key").GetComponent<FrozenKey>();
        _iceBlock = GameObject.FindGameObjectWithTag("Frozen Block").GetComponent<IceBlock>();
    }

    // Start is called before the first frame update
    void Start()
    {
        if(GameManager.Instance.hasFrozenKey)
        {
            gameObject.SetActive(false);
        }

        _timer = puzzleTimer;
        
        // Get all the torch objects and assign their caveTorch components to the public array
        GameObject[] torchObs = GameObject.FindGameObjectsWithTag("Torch");
        _torches = new CaveTorch[torchObs.Length];
        for (int i = 0; i < torchObs.Length; i++)
        {
            _torches[i] = torchObs[i].GetComponent<CaveTorch>();
        }
    }

    // Update is called once per frame
    void Update()
    {
        // count down the timer
        if (puzzleHasStarted && !puzzleFinished)
        {
            timerUI.SetActive(true);
            _timer -= Time.deltaTime;
            timer_radial.fillAmount = _timer / puzzleTimer;

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
        timerUI.SetActive(false);
        _timer = puzzleTimer;
    }

    void CompletePuzzle()
    {
        Debug.Log("FINISHED");
        puzzleFinished = true;
        timerUI.SetActive(false);
        _key.canBeCollected = true;
        _iceBlock.iceMelting = true;

        // KEY MELT ANIMATION?

        // turn on all the torches
        foreach (CaveTorch torch in _torches)
        {
            torch.LightTorch();
        }
    }
}
