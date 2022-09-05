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
    AudioSource _source;

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
        _anim = GetComponent<Animator>();
        _source = GetComponentInChildren<AudioSource>();
    }


    void OnTriggerEnter(Collider other)
    {
        if (other.tag == "Player")
        {
            _source.Play();
            UiObject.SetActive(true);
            Cursor.lockState = CursorLockMode.None;
            Time.timeScale = 0;
        }
    }

    public void Close()
    {
        Time.timeScale = 1;
        Cursor.lockState = CursorLockMode.Locked;
        StartCoroutine(CollectGold());
    }

    IEnumerator CollectGold()
    {
        UiObject.SetActive(false);
        GameManager.Instance.goldMailCount++;
        GameManager.Instance.collectedGoldMail.Add(mailID);
        _anim.Play("Collect");
        yield return new WaitForSeconds(1f);
        Destroy(gameObject);
    }
}