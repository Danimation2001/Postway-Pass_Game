using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using RhythmReaders;

public class MapFileReader : MonoBehaviour
{
    public Object beatMap;
    public RhythmData data;
    string[] lines;

    void Awake()
    {
        lines = beatMap.ToString().Split(new char[] {'\n', '\r'});
        
        // foreach(string line in lines)
        // {
        //     Debug.Log(line);
        // }
        
        RbmReader reader = new RbmReader(lines);
        data = reader.GetReadedData();
    }
}