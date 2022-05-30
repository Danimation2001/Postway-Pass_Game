using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class AudioZone : MonoBehaviour
{
    //variables to hold audio objects
    public AudioSource mazeAudio;
    public AudioSource overworldAudio;

    void Start() 
    {
        //Finding audio source files and objects on Start
        mazeAudio = gameObject.GetComponent<AudioSource>();
        GameObject overworldAudio = GameObject.Find("OverworldBGM");
        AudioSource audioSource = overworldAudio.GetComponent<AudioSource>();
    }

    //when object with the Player tag enters the maze audio zone trigger, overworld music
    //will be stopped and maze audio will be played
    void OnTriggerEnter(Collider col) 
    {
        if ((col.gameObject.CompareTag("Player")) && (overworldAudio.isPlaying))
       
        {
            overworldAudio.Pause();
            GetComponent<AudioSource>().Play();
            GetComponent<AudioSource>().loop = true;
        }
 }
    //when player moves out of maze audio zone the maze audio stops and overworld
    //music plays again 
    void OnTriggerExit(Collider col) 
    {
        if (col.gameObject.CompareTag("Player"))  
    {
        overworldAudio.Play();
        mazeAudio.Pause();
        GetComponent<AudioSource>().Stop();
        GetComponent<AudioSource>().loop = false;
    }
 }

}
