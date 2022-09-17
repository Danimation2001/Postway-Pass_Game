using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class LampSwitch : MonoBehaviour
{
    //holds lamp lights and emission blocks
    public GameObject LampBlock;
    public GameObject Light;

    void Start()
    {

    }

    void Update()
    {
        
    }

    //entering trigger radius
    public void OnTriggerEnter(Collider other)
    {
        if (other.tag == "Player")
        {
            LightLamp();
        }
    }

    //turns on lamp blocks and lights once in radius 
    public void LightLamp()
    {
        LampBlock.SetActive(true);
        Light.SetActive(true); 
    }
}


