using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DialogueSystem : MonoBehaviour
{

    [SerializeField] public GameObject DialogueUI;
    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    void OnCollisionEnter(Collider other)
    {
         if (other.tag == "Player" && Input.GetButton("Interact"))
        {
            DialogueUI.SetActive(true);
            Cursor.lockState = CursorLockMode.None;
        }
        else  {
            DialogueUI.SetActive(false);
        }
    }
}
