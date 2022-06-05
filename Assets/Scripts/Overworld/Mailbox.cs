using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.InputSystem;
using UnityEngine.Animations;
using TMPro;

public class Mailbox : MonoBehaviour
{
    public int minMail;
    bool _canWin;

    public GameObject interactCanvas;
    public GameObject popupUI;
    public InputAction interact;
    public TMP_Text mailCountText;
    public TMP_Text goldMailCountText;
    public TMP_Text canWinText;
    // public TMP_Text minimumText;


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
                _canWin = true;
            }

            if (_canWin == true)
            {
                endLevelButton.interactable = true;
            }

            UpdateText();
            popupUI.SetActive(true);
            Cursor.lockState = CursorLockMode.None;
            Time.timeScale = 0f;
        }
    }

    public void EndLevel()
    {
        SceneLoader.Instance.LoadMainMenu();
    }

    public void ClosePopup()
    {
        Cursor.lockState = CursorLockMode.Locked;
        Time.timeScale = 1f;
        popupUI.SetActive(false);
    }

    ConstraintSource _constraintSource;

    // Start is called before the first frame update
    void Start()
    {
        interact.Disable();
        GameManager.Instance.CollectMaxMails();

        _constraintSource.sourceTransform = Camera.main.transform;
        _constraintSource.weight = 1;

        GetComponentInChildren<LookAtConstraint>().AddSource(_constraintSource);
    }

    // Update is called once per frame
    void UpdateText()
    {
        if (_canWin)
        {
            canWinText.text = "great work! you've collected enough mail for the day!";
        }
        else
        {
            canWinText.text = "Wilbur's words echo in your head: 'You need atleast 4 pieces of mail to finish work for the day'";
        }

        mailCountText.text = "Mail: " + GameManager.Instance.mailCount.ToString() + "/" + GameManager.Instance.maxMail.ToString();
        goldMailCountText.text = "Gold Mail: " + GameManager.Instance.goldMailCount.ToString() + "/" + GameManager.Instance.maxGoldMail.ToString();

        // minimumText.text = "You need " + minMail + " pieces of mail to continue!";
    }
}
