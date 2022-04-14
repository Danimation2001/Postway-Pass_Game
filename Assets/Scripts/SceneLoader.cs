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

    // Update is called once per frame
    void Update()
    {

    }

    public void LoadCombatScene()
    {
        Cursor.lockState = CursorLockMode.None;
        _overworldScene = SceneManager.GetActiveScene();
        GameManager.Instance.sceneID = _overworldScene.buildIndex;
        StartCoroutine(LoadLevel(0));
    }

    public void LoadOverworldScene(int _index)
    {
        Cursor.lockState = CursorLockMode.Locked;
        StartCoroutine(LoadLevel(_index));
    }

    IEnumerator LoadLevel(int _levelIndex)
    {
        Time.timeScale = 0f;

        //play animation
        transition.SetTrigger("Start");

        //wait for animation
        yield return new WaitForSecondsRealtime(transitionTime);

        Time.timeScale = 1f;

        //load scene
        SceneManager.LoadScene(_levelIndex);
    }
}