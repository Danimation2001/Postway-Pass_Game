using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.InputSystem;
using UnityEngine.UI;
using TMPro;



public class GoldMailTestTilly : MonoBehaviour
{
    public GameObject UiObject;
    public GameObject GoldMail;
    public Animator _anim;
    public int mailID;
    public AudioSource playSound;

    // Start is called before the first frame update
    void Start()
    {
        UiObject.SetActive(false);
        foreach (int id in GameManager.Instance.collectedMail) // check if this mail is marked as been collected
        {
            if (id == mailID)
            {
                gameObject.SetActive(false);
            }
        }
        _anim = GetComponent<Animator>();
    }


    void OnTriggerEnter(Collider other)
    {
        if (other.tag == "Player")
        {
            GameManager.Instance.goldMailCount++;
            GameManager.Instance.collectedGoldMail.Add(mailID);
            // StartCoroutine(CollectMail());
            _anim.Play("Collect");
            playSound.Play();
            UiObject.SetActive(true);
            Cursor.lockState = CursorLockMode.None;
            Time.timeScale = 0;
        }
    }
    public void Close()
    {
        Cursor.lockState = CursorLockMode.Locked;
        Time.timeScale = 1;
    }

    void OnTriggerExit(Collider other)
    {
        UiObject.SetActive(false);
    }

    // void OnTriggerExit(Collider other){
    //     if(other.tag == "Player")
    //     {
    //         UiObject.SetActive(false);
    //         // Destroy(GoldMail);

    //     }
    // }
}