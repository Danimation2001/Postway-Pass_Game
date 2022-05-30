using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class AudioSwap : MonoBehaviour
{
    public AudioClip newTrack;

    //when object with the Player tag enters the trigger area,
    //the SwapTrack function will be called
    public void OnTriggerEnter(Collider col)
    {
        if(col.CompareTag("Player"))
        {
            AudioManager.instance.SwapTrack(newTrack);
        }
    } 

    public void OnTriggerExit(Collider col)
    {
        if(col.CompareTag("Player"))
        {
            AudioManager.instance.ReturnToDefault();
        }
    }
}
