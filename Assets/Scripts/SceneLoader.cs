using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

public class SceneLoader : MonoBehaviour
{
    private static SceneLoader _instance;

    public static SceneLoader Instance
    {
        get
        {
            if (_instance is null)
            {
                Debug.LogError("Scene Manager is NULL");
            }

            return _instance;
        }
    }

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

    public Animator transition;
    public float transitionTime;
    Scene _overworldScene;

    void Start()
    {
        StartCoroutine(InitialFade());
    }

    public float initialDelay;

    IEnumerator InitialFade()
    {
        yield return new WaitForSeconds(initialDelay);
        transition.Play("Fade Game In");
    }

    public void Retry()
    {
        GameManager.Instance.gameOver = false;
        // Scene current = SceneManager.GetActiveScene();
        // StartCoroutine(LoadLevel(current.buildIndex));
        LoadWinterScene();
    }

    public void LoadCombatScene()
    {
        Cursor.lockState = CursorLockMode.None;
        _overworldScene = SceneManager.GetActiveScene();
        GameManager.Instance.overworldSceneID = _overworldScene.buildIndex;
        StartCoroutine(LoadLevel(2));
    }

    public void LoadWinterScene()
    {
        Cursor.lockState = CursorLockMode.Locked;
        GameManager.Instance.goldMailCount = 0;
        StartCoroutine(LoadLevel(2));
    }

     public void LoadOfficeScene()
    {
        Cursor.lockState = CursorLockMode.Locked;
        StartCoroutine(LoadLevel(1));
    }

    public void LoadEnding()
    {
        Cursor.lockState = CursorLockMode.None;
        GameManager.Instance.ResetAll();
        StartCoroutine(LoadLevel(4));
    }


    public void LoadMainMenu()
    {
        Cursor.lockState = CursorLockMode.None;
        GameManager.Instance.ResetAll();
        GameManager.Instance.overworldSceneID = 0;
        StartCoroutine(LoadLevel(0));
    }

    public void LoadWinterBattleScene()
    {
        Cursor.lockState = CursorLockMode.Locked;
        StartCoroutine(LoadLevel(3));
    }

    public void LoadTutorial()
    {
        StartCoroutine(LoadLevel(5));
    }

    public void Quit()
    {
        Application.Quit();
    }

    IEnumerator LoadLevel(int _levelIndex)
    {
        Time.timeScale = 0f;

        //play animation
        transition.Play("Fade Game Out");

        //wait for animation
        yield return new WaitForSecondsRealtime(transitionTime);

        //load scene
        SceneManager.LoadScene(_levelIndex);

        Time.timeScale = 1f;
    }
}