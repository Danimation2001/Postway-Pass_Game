using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Note : MonoBehaviour
{
    bool _canBePressed; //can the note be hit?
    public KeyCode direction; //the direction of the note
    bool _beenHit; //has the note been hit?
    public int scorePerNote = 100;
    ButtonControllerv2 player;

    private void Start()
    {
        player = GameObject.Find("Player").GetComponent<ButtonControllerv2>();
    }

    // Update is called once per frame
    void Update()
    {
        //if the correct button is pressed and the note can be hit, hit
        if (Input.GetKeyDown(direction))
        {
            if (_canBePressed)
            {
                HitNote();
            }
        }
    }

    //if a note is over the hit line, allow it to be hit
    void OnTriggerEnter2D(Collider2D other)
    {
        if (other.tag == "Activator")
        {
            _canBePressed = true;
        }
    }

    //if the note leaves the hit line without being hit, miss.
    void OnTriggerExit2D(Collider2D other)
    {
        if (other.tag == "Activator" && !_beenHit)
        {
            _canBePressed = false;
            MissNote();
        }
    }

    void HitNote()
    {
        _beenHit = true;

        //add points and hit tracker
        RhythmManager.instance.hitNotes++;
        RhythmManager.instance.AddScore(scorePerNote);
        player.TakeDamage(-10);

        //increase multiplier (if it has not reached max)
        if (RhythmManager.instance.multiplier - 1 < RhythmManager.instance.multiThresholds.Length)
        {
            RhythmManager.instance.multiplierTracker++;
            RhythmManager.instance.IncreaseMultiplier();
        }

        Destroy(gameObject);
    }

    void MissNote()
    {
        //add the the missed note tracker and reset the multiplier
        RhythmManager.instance.missedNotes++;
        player.TakeDamage(10);
        RhythmManager.instance.ResetMultiplier();

        Destroy(gameObject);
    }
}
