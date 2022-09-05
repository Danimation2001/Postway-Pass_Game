using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.InputSystem;
using UnityEngine.Animations;
using TMPro;

public class HiddenMail : MonoBehaviour
{
    [SerializeField] private bool triggerActive = false;

    //set up sphere collider to be the trigger collider
    public Collider triggerCollider; 

    //holds mail object to be revealed
    public GameObject hiddenMail;
    
        //starts with the mail object not visible
        void Start()
        {
            hiddenMail.SetActive(false);
        }

        //entering trigger radius
        public void OnTriggerEnter(Collider triggerCollider)
        {
            if (triggerCollider.tag == "Player")
            {
                triggerActive = true;
                Debug.Log("ENTERED trigger radius");
            }
        }
 
        public void OnTriggerExit(Collider triggerCollider)
        {
            if (triggerCollider.tag == "Player")
            {
                triggerActive = false;
                Debug.Log("LEFT trigger radius");
            }
        }
 
        private void Update()
        {
            if (triggerActive && Input.GetKeyDown(KeyCode.E))
            {
                mailAppear();
            }
        }

        //makes object disappear when interacted with
        public void mailAppear()
        {
            gameObject.SetActive(false);
            hiddenMail.SetActive(true);
            Debug.Log("mail appeared");
        }
}



