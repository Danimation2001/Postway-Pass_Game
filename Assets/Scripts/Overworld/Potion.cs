using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Potion : MonoBehaviour
{
    public int potionID;

    void Start()
    {
        foreach (int id in GameManager.Instance.collectedPotions) // check if this potion is marked as being defeated
        {
            if (id == potionID)
            {
                gameObject.SetActive(false);
            }
        }
    }

    void OnTriggerEnter(Collider other)
    {
        if (other.tag == "Player")
        {
            GameManager.Instance.potionCount++;
            GameManager.Instance.collectedPotions.Add(potionID);
            Destroy(gameObject);
        }
    }
}
