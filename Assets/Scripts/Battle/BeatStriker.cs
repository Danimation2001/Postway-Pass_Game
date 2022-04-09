using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BeatStriker : MonoBehaviour
{
    public bool canHit;
    public BeatSystem beatSystem;

    void OnTriggerEnter2D(Collider2D other)
    {
        if (other.tag == "Beat")
        {
            canHit = true;
            beatSystem.hittableNote = other.gameObject;
        }
    }

    void OnTriggerExit2D(Collider2D other)
    {
        if (other.tag == "Beat")
        {
            canHit = false;
        }
    }
}