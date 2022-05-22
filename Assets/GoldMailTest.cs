using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using TMPro;


public class GoldMailTest : MonoBehaviour
{
    public GameObject UiObject;
    public GameObject GoldMail;
    public Animator _anim;
    public int mailID;


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

  
    void OnTriggerEnter(Collider other) {
        if(other.tag == "Player")
        {
            GameManager.Instance.mailCount++;
            GameManager.Instance.collectedMail.Add(mailID);
            // StartCoroutine(CollectMail());
            _anim.Play("Collect");
            UiObject.SetActive(true);
        }
    }

    void OnTriggerExit(Collider other) {
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
