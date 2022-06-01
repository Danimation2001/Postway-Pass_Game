using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class AudioZone : MonoBehaviour
{
    //variables to hold audio objects
    public AudioSource mazeAudio;
    public AudioSource overworldAudio;
    public float fadeTime;

    IEnumerator FadeAudio(AudioSource source1, AudioSource source2)
    {
        float startVolume1 = source1.volume;
        float startVolume2 = source2.volume;

        while (source1.volume > 0)
        {
            source1.volume -= startVolume1 * Time.deltaTime / fadeTime;

            yield return null;
        }
        source1.Stop();
        source1.volume = startVolume1;

        source2.volume = 0;
        source2.Play();
        while (source2.volume < startVolume2)
        {
            source2.volume += startVolume2 * Time.deltaTime / fadeTime;

            yield return null;
        }
    }

    //when object with the Player tag enters the maze audio zone trigger, overworld music
    //will be stopped and maze audio will be played
    void OnTriggerEnter(Collider col)
    {
        if ((col.gameObject.CompareTag("Player")) && (overworldAudio.isPlaying))
        {
            StartCoroutine(FadeAudio(overworldAudio, mazeAudio));
        }
    }
    //when player moves out of maze audio zone the maze audio stops and overworld
    //music plays again 
    void OnTriggerExit(Collider col)
    {
        if (col.gameObject.CompareTag("Player"))
        {
            StartCoroutine(FadeAudio(mazeAudio, overworldAudio));
        }
    }
}
