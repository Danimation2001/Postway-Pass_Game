using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BeatStriker : MonoBehaviour
{
    public bool canHitNote;
    // public bool canHitHoldNote;
    // public bool canReleaseHoldNote;
    public BeatSystem beatSystem;

    void OnTriggerEnter2D(Collider2D other)
    {
        if (other.tag == "Beat")
        {
            canHitNote = true;
            beatSystem.hittableNote = other.gameObject;
        }

        // if (other.tag == "HoldStart")
        // {
        //     canHitHoldNote = true;
        // }
        // if (other.tag == "HoldEnd")
        // {
        //     canReleaseHoldNote = true;
        // }
    }

    void OnTriggerExit2D(Collider2D other)
    {
        if (other.tag == "Beat")
        {
            canHitNote = false;
        }

        // if (other.tag == "HoldStart")
        // {
        //     canHitHoldNote = false;
        // }
    }
}