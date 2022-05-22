using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class GoldMail : MonoBehaviour
{

}
// public GameObject GoldMail;
// public GameObject buttonAndTextDrawer;


// public void OnCollisionEnter(collision col) {
//     if(col.gameObject == GoldMail){
//         buttonAndTextDrawer.SetActive(true);
//     }
// }
// }

// {
//     public int goldmailID;
//     Animator _anim;

//     void Start()
//     {
//         foreach (int id in GameManager.Instance.collectedMail) // check if this mail is marked as been collected
//         {
//             if (id == goldmailID)
//             {
//                 gameObject.SetActive(false);
//             }
//         }
//         _anim = GetComponent<Animator>();
//     }

//     IEnumerator CollectMail()
//     {
//         GameManager.Instance.mailCount++;
//         GameManager.Instance.collectedMail.Add(goldmailID);
//         _anim.Play("Collect");
//         yield return new WaitForSeconds(1f);
//         Destroy(gameObject);
//     }

//     void OnTriggerEnter(Collider other)
//     {
//         if (other.tag == "Player")
//         {
//             StartCoroutine(CollectMail());
//         }
//     }
// }