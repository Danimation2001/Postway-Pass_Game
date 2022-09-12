using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using RhythmReaders;

public class Conductor : MonoBehaviour
{
    [Header("Song Data")]
    public string songName; //the name of the song
    public float scrollSpeed; //the speed the notes scroll
    public float beatsOnScreen = 4f; //how many notes are shown on screen
    public float songBpm; //Song beats per minute
    public float firstBeatOffset; //Offset of the first beat in seconds
    public RhythmData rhythmData = new RhythmData();

    [Header("Components")]
    public GameObject[] notes; //the note prefabs
    public Transform[] scrollers; //the scrolling objects
    public Transform[] noteSpawns; //the spawnpoints of the notes
    public AudioSource musicSource; //Source that will play music
    public AnimationSync animSync; //class that controls the pulsing circle

    [Header("Setup")]
    public float startTimer; //time to wait before starting the song
    float _startTimer;

    [HideInInspector] public float[] upTrack; //The positions in beats of each up note
    [HideInInspector] public float[] downTrack; //The positions in beats of each down note
    [HideInInspector] public float[] leftTrack; //The positions in beats of each left note
    [HideInInspector] public float[] rightTrack; //The positions in beats of each right note
    [HideInInspector] public int[] nextIndex = new int[4]; //number to navigate the tracks
    [HideInInspector] public bool songStarted = false; //has the song started?
    [HideInInspector] public bool songFinished = false; //has the song ended?
    [HideInInspector] public float songPosInBeats; //Current position in song in beats
    float _secPerBeat; //The number of seconds for each song beat
    float _songPosition; //Current position in song in seconds
    float _dspSongTime; //How much time has passed since the song started
    private static Conductor _instance;

    public static Conductor instance
    {
        get
        {
            return _instance;
        }
    }

    void Awake()
    {
        _instance = this;
    }

    // Start is called before the first frame update
    void Start()
    {
        _startTimer = startTimer;
        MapFileReader fileReader = GetComponent<MapFileReader>();
        rhythmData = fileReader.data;

        musicSource = GetComponent<AudioSource>();
        _secPerBeat = 60f / songBpm; //calculate seconds per beat

        foreach (Timestamp stamp in rhythmData.Timestamps)
        {
            stamp.TimeInBeats = stamp.TimeInSeconds / _secPerBeat;
        }

        InitArrayTrackData();
        //RhythmManager.instance.SetSongName(songName);
        //RhythmManager.instance.endPanel.SetActive(false);
    }

    List<int> upID = new List<int>(), downID = new List<int>(), leftID = new List<int>(), rightID = new List<int>();

    void InitArrayTrackData()
    {
        // foreach (Timestamp stamp in rhythmData.Timestamps)
        // {
        //     Debug.Log(stamp.Id);
        // }

        for (int i = 0; i < rhythmData.Timestamps.Length; i++)
        {
            if (!rhythmData.Timestamps[i].IsLong)
            {
                switch ((int)rhythmData.Timestamps[i].BeatTrackId)
                {
                    case 1:
                        upID.Add((int)rhythmData.Timestamps[i].Id);
                        break;

                    case 2:
                        downID.Add((int)rhythmData.Timestamps[i].Id);
                        break;

                    case 3:
                        leftID.Add((int)rhythmData.Timestamps[i].Id);
                        break;

                    case 4:
                        rightID.Add((int)rhythmData.Timestamps[i].Id);
                        break;
                }
            }
        }

        upTrack = new float[upID.Count];
        downTrack = new float[downID.Count];
        leftTrack = new float[leftID.Count];
        rightTrack = new float[rightID.Count];

        int[] next = new int[4];
        for (int i = 0; i < rhythmData.Timestamps.Length; i++)
        {
            if (!rhythmData.Timestamps[i].IsLong)
            {
                if (next[0] < upID.Count)
                {
                    if (rhythmData.Timestamps[i].Id == upID[next[0]])
                    {
                        upTrack[next[0]] = rhythmData.Timestamps[i].TimeInBeats;
                        next[0]++;
                    }
                }

                if (next[1] < downID.Count)
                {
                    if (rhythmData.Timestamps[i].Id == downID[next[1]])
                    {
                        downTrack[next[1]] = rhythmData.Timestamps[i].TimeInBeats;
                        next[1]++;
                    }
                }

                if (next[2] < leftID.Count)
                {
                    if (rhythmData.Timestamps[i].Id == leftID[next[2]])
                    {
                        leftTrack[next[2]] = rhythmData.Timestamps[i].TimeInBeats;
                        next[2]++;
                    }
                }

                if (next[3] < rightID.Count)
                {
                    if (rhythmData.Timestamps[i].Id == rightID[next[3]])
                    {
                        rightTrack[next[3]] = rhythmData.Timestamps[i].TimeInBeats;
                        next[3]++;
                    }
                }
            }
        }
    }

    // Update is called once per frame
    void Update()
    {
        //start the song when the player presses a button
        if (!songStarted)
        {
            _startTimer -= Time.deltaTime;

            if (_startTimer <= 0)
            {
                songStarted = true;
                //RhythmManager.instance.readyPanel.SetActive(false);
                musicSource.Play(); //start the song
                //animSync.enabled = true; //start the circle pulsing animation
                _dspSongTime = (float)AudioSettings.dspTime; //record when the music starts 
            }
        }

        if (songStarted)
        {
            _songPosition = (float)(AudioSettings.dspTime - _dspSongTime - firstBeatOffset); //determine how many seconds have passed since the song started
            songPosInBeats = _songPosition / _secPerBeat; //determine how many beats have passed since the song started
            //SpawnNotesv2(rhythmData.Timestamps);
            SpawnNotes(0, upTrack);
            SpawnNotes(1, downTrack);
            SpawnNotes(2, leftTrack);
            SpawnNotes(3, rightTrack);
        }

        //check if there are any notes left to be spawned and there are no notes in the scene, end the song
        if (nextIndex[0] >= upTrack.Length && nextIndex[1] >= downTrack.Length && nextIndex[2] >= leftTrack.Length && nextIndex[3] >= rightTrack.Length
        && scrollers[0].childCount == 0 && scrollers[1].childCount == 0 && scrollers[2].childCount == 0 && scrollers[3].childCount == 0)
        {
            songFinished = true;
        }

        if (songFinished)
        {
            GameManager.Instance.FinishedSong();
        }
    }

    void SpawnNotes(int index, float[] track)
    {
        if (nextIndex[index] < track.Length && track[nextIndex[index]] < songPosInBeats + beatsOnScreen)
        {
            GameObject note = Instantiate(notes[index], noteSpawns[index]);
            note.transform.SetParent(scrollers[index]);
            nextIndex[index]++;
        }
    }

    // void SpawnNotesv2(Timestamp[] timestamp)
    // {
    //     for (int i = 0; i < timestamp.Length; i++)
    //     {
    //         int indexDirection = (int)timestamp[i].BeatTrackId - 1;
    //         GameObject note = Instantiate(notes[indexDirection], noteSpawns[indexDirection]);
    //         note.transform.SetParent(scrollers[indexDirection]);
    //     }
    // }
}
