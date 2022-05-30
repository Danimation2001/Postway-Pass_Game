using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class AudioManager : MonoBehaviour
{
    //variables to hold audio objects
   public AudioClip overworldAmbience;

   private AudioSource track01, track02;
   private bool isPlayingTrack01;

    //making singleton so can access from elsewhere
   public static AudioManager instance;

   public void Awake()
   {
       if (instance == null)
           instance = this; 
   }

   public void Start()
   {
       track01 = gameObject.AddComponent<AudioSource>();
       track01.loop = true;
       track02 = gameObject.AddComponent<AudioSource>();
       track02.loop = true;
       isPlayingTrack01 = true;

       track01.Play(); 

       SwapTrack(overworldAmbience);
   }

    //function to swap tracks when called
   public void SwapTrack(AudioClip newClip)
   {
       if (isPlayingTrack01)
    {
        track01.clip = newClip;
        track01.Stop();
        track01.loop = false;
        track02.Play();
        track02.loop = true;
    
    }
    else
    {
        track01.clip = newClip;
        track01.Play();
        track01.loop = true;
        track02.Stop();
        track02.loop = false;
    }
    isPlayingTrack01 = !isPlayingTrack01;
   }

    //function to return to default overworld ambience track
   public void ReturnToDefault()
   {
       SwapTrack(overworldAmbience);
   }
}
