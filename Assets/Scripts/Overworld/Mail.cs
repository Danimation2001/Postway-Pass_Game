using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Mail : MonoBehaviour
{
    public int mailID;
    Animator _anim;

    void Start()
    {
        foreach (int id in GameManager.Instance.collectedMail) // check if this mail is marked as been collected
        {
            if (id == mailID)
            {
                gameObject.SetActive(false);
            }
        }
        _anim = GetComponent<Animator>();
    }

    IEnumerator CollectMail()
    {
        GameManager.Instance.mailCount++;
        GameManager.Instance.collectedMail.Add(mailID);
        _anim.Play("Collect");
        yield return new WaitForSeconds(1f);
        Destroy(gameObject);
    }

    void OnTriggerEnter(Collider other)
    {
        if (other.tag == "Player")
        {
            StartCoroutine(CollectMail());
        }
    }
}