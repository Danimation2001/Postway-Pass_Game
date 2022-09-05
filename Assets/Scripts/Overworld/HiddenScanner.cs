using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class HiddenScanner : MonoBehaviour
{
    // Start is called before the first frame update
    void Start()
    {

    }

    // Update is called once per frame
    void Update()
    {

    }

    void OnTriggerEnter(Collider other)
    {
        if (other.tag == "Hidden Mail")
        {
            ParticleSystem particle = other.GetComponentInChildren<ParticleSystem>();
            particle.Play();
        }
    }

    void OnTriggerExit(Collider other)
    {
        if (other.tag == "Hidden Mail")
        {
            ParticleSystem particle = other.GetComponentInChildren<ParticleSystem>();
            particle.Stop();
        }
    }
}
