using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.InputSystem;
using TMPro;

public class PauseMenu : MonoBehaviour
{
    public InputAction pause;
    public GameObject pauseScreen;
    public GameObject overworldCounters;
    CanvasGroup _pauseGroup;
    bool _isPaused;

    //public TMP_Text potionText;
    public TMP_Text mailText;
    public TMP_Text goldMailText;

    public AudioSource bookOpenSound;
    public AudioSource bookCloseSound;

    void OnEnable()
    {
        pause.Enable();
        pause.performed += PauseButton;
    }

    void OnDisable()
    {
        pause.Disable();
    }

    void PauseButton(InputAction.CallbackContext context)
    {
        if (_isPaused)
        {
            Unpause();
        }
        else
        {
            Pause();
        }
    }

    public void Pause()
    {
        Cursor.lockState = CursorLockMode.None;
        overworldCounters.SetActive(false);
        //pauseScreen.SetActive(true);
        _pauseGroup.alpha = 1;
        _pauseGroup.blocksRaycasts = true;
        _pauseGroup.interactable = true;
        mailText.text = GameManager.Instance.mailCount.ToString();
        //spotionText.text = GameManager.Instance.potionCount.ToString();
        goldMailText.text = GameManager.Instance.goldMailCount.ToString();
        Time.timeScale = 0;
        _isPaused = true;
        bookOpenSound.Play();
        bookCloseSound.Stop();
    }

    public void Unpause()
    {
        bookCloseSound.Play();
        bookOpenSound.Stop();
        Cursor.lockState = CursorLockMode.Locked;
        overworldCounters.SetActive(false);
        //pauseScreen.SetActive(false);
        _pauseGroup.alpha = 0;
        _pauseGroup.blocksRaycasts = false;
        _pauseGroup.interactable = false;
        Time.timeScale = 1;
        _isPaused = false;
    }

    public void BackToMenu()
    {
        SceneLoader.Instance.LoadMainMenu();
    }

    // Start is called before the first frame update
    void Start()
    {
        _pauseGroup = pauseScreen.GetComponent<CanvasGroup>();
        bookCloseSound.Stop();
        bookOpenSound.Stop();
    }
}