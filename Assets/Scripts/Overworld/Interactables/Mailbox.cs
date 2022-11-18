using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.InputSystem;
using UnityEngine.Animations;
using TMPro;

public class Mailbox : MonoBehaviour
{
    public string levelName;
    public int minMail;
    bool _canWin;

    public GameObject interactCanvas;
    public GameObject popupUI;
    public InputAction interact;
    public TMP_Text mailCountText;
    public TMP_Text goldMailCountText;
    public TMP_Text canWinText;
    public GameObject happyWilbur;
    public GameObject angryWilbur;
    // public TMP_Text minimumText;
    bool activePopup;


    void OnEnable()
    {
        interact.Enable();
        interact.performed += Interact;
    }

    void OnDisable()
    {
        interact.Disable();
    }

    private void OnTriggerEnter(Collider other)
    {
        if (other.tag == "Player")
        {
            interact.Enable();
            interactCanvas.GetComponent<Animator>().Play("Fade In");
        }
    }

    private void OnTriggerExit(Collider other)
    {
        if (other.tag == "Player")
        {
            interact.Disable();
            interactCanvas.GetComponent<Animator>().Play("Fade Out");
        }
    }

    public UnityEngine.UI.Button endLevelButton;

    void Interact(InputAction.CallbackContext context)
    {
        if (!popupUI.activeSelf)
        {
            if (GameManager.Instance.mailCount >= minMail)
            {
                switch(levelName)
                {
                    case "Winter":
                        if(GameManager.Instance.defeatedWinterBoss)
                        {
                            _canWin = true; 
                        }
                    break;
                }
            }

            if (_canWin == true)
            {
                endLevelButton.interactable = true;
            }

            UpdateText();
            popupUI.SetActive(true);
            activePopup = true;
            Cursor.lockState = CursorLockMode.None;
            Time.timeScale = 0f;
        }
    }

    public void EndLevel()
    {
        SceneLoader.Instance.LoadEnding();
    }

    public void ClosePopup()
    {
        Cursor.lockState = CursorLockMode.Locked;
        Time.timeScale = 1f;
        popupUI.SetActive(false);
        activePopup = false;
    }

    ConstraintSource _constraintSource;

    // Start is called before the first frame update
    void Start()
    {
        interact.Disable();
        if (!GameManager.Instance.maxCounted)
        {
            GameManager.Instance.CollectMaxMails();
        }

        _constraintSource.sourceTransform = Camera.main.transform;
        _constraintSource.weight = 1;

        GetComponentInChildren<LookAtConstraint>().AddSource(_constraintSource);
    }

    void Update()
    {
        if(activePopup)
        {
            Cursor.lockState = CursorLockMode.None;
        }
    }

    // Update is called once per frame
    void UpdateText()
    {
        if (_canWin)
        {
            canWinText.text = "great work! you've collected enough mail for the day!";
            happyWilbur.SetActive(true);
            angryWilbur.SetActive(false);
        }
        else
        {
            canWinText.text = "Wilbur's words echo in your head: \"You need at least " + minMail + " pieces of mail to finish work for the day\"";
            angryWilbur.SetActive(true);
            happyWilbur.SetActive(false);
        }

        mailCountText.text =  GameManager.Instance.mailCount.ToString() + "/" + GameManager.Instance.maxMail.ToString();
        goldMailCountText.text = GameManager.Instance.goldMailCount.ToString() + "/" + GameManager.Instance.maxGoldMail.ToString();

        // minimumText.text = "You need " + minMail + " pieces of mail to continue!";
    }
}
