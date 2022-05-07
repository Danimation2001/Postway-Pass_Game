using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.InputSystem;
using TMPro;

public class PauseMenu : MonoBehaviour
{
    public InputAction pause;
    public GameObject pauseScreen;
    CanvasGroup _pauseGroup;
    bool _isPaused;

    public TMP_Text potionText;
    public TMP_Text mailText;
    public TMP_Text goldMailText;

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
        _pauseGroup.alpha = 1;
        _pauseGroup.blocksRaycasts = true;
        _pauseGroup.interactable = true;
        mailText.text = GameManager.Instance.mailCount.ToString();
        potionText.text = GameManager.Instance.potionCount.ToString();
        goldMailText.text = GameManager.Instance.goldMailCount.ToString();
        Time.timeScale = 0;
        _isPaused = true;
    }

    public void Unpause()
    {
        Cursor.lockState = CursorLockMode.Locked;
        _pauseGroup.alpha = 0;
        _pauseGroup.blocksRaycasts = false;
        _pauseGroup.interactable = false;
        Time.timeScale = 1;
        _isPaused = false;
    }

    // Start is called before the first frame update
    void Start()
    {
        _pauseGroup = pauseScreen.GetComponent<CanvasGroup>();
    }

    // Update is called once per frame
    void Update()
    {

    }
}