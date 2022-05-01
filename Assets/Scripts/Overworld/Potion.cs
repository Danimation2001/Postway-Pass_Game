using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Potion : MonoBehaviour
{
    public int potionID;
    Animator _anim;

    void Start()
    {
        foreach (int id in GameManager.Instance.collectedPotions) // check if this potion is marked as been collected
        {
            if (id == potionID)
            {
                gameObject.SetActive(false);
            }
        }
        _anim = GetComponent<Animator>();
    }

    IEnumerator CollectPotion()
    {
        GameManager.Instance.potionCount++;
        GameManager.Instance.collectedPotions.Add(potionID);
        _anim.Play("Collect");
        yield return new WaitForSeconds(1f);
        Destroy(gameObject);
    }

    void OnTriggerEnter(Collider other)
    {
        if (other.tag == "Player")
        {
            StartCoroutine(CollectPotion());
        }
    }
}