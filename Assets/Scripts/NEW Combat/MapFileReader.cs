using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System.IO;
using RhythmReaders;

public class MapFileReader : MonoBehaviour
{
    public Object beatMap;
    public RhythmData data;
    string[] lines;

    void Awake()
    {
        lines = beatMap.ToString().Split('\n');
        RbmReader reader = new RbmReader(lines);
        // Conductor.instance.rhythmData = reader.GetReadedData();

        data = reader.GetReadedData();

        // foreach (Timestamp stamp in data.Timestamps)
        // {
        //     Debug.Log(stamp.TimeInSeconds);
        // }
    }
}