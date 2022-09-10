using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using TMPro;


public class GoldMail : MonoBehaviour
{
    public GameObject UiObject;
    public TMP_Text messageText;
    public Animator anim;
    public int mailID;
    public TextAsset message;


    // Start is called before the first frame update
    void Start()
    {
        foreach (int id in GameManager.Instance.collectedGoldMail) // check if this mail is marked as been collected
        {
            if (id == mailID)
            {
                gameObject.SetActive(false);
            }
        }
        anim = GetComponent<Animator>();
    }


    void OnTriggerEnter(Collider other)
    {
        if (other.tag == "Player")
        {
            Time.timeScale = 0f;
            UiObject.SetActive(true);
            Cursor.lockState = CursorLockMode.None;

            if (message != null)
            {
                messageText.text = message.text;
            }
        }
    }

    public void Collect()
    {
        Time.timeScale = 1f;
        Cursor.lockState = CursorLockMode.Locked;
        StartCoroutine(CollectGoldMail());
    }

    IEnumerator CollectGoldMail()
    {
        GameManager.Instance.goldMailCount++;
        GameManager.Instance.collectedGoldMail.Add(mailID);
        anim.Play("Collect");
        yield return new WaitForSeconds(1f);
        Destroy(gameObject);
    }
}
