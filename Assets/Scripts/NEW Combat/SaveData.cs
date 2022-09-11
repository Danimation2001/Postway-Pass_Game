using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[System.Serializable]
public class SaveData
{
    public string songName = "Test";
    public int highScore = 0;
    public float hitPercent = 0f;

    void GetData()
    {
        songName = RhythmManager.instance.selectedSongName;
        highScore = RhythmManager.instance.bestScore;
        hitPercent = RhythmManager.instance.hitPercent;
    }

    public string ToJson()
    {
        GetData();
        string data = JsonUtility.ToJson(this);
        return data;
    }

    public static SaveData FromJson(string s)
    {
        SaveData t = JsonUtility.FromJson<SaveData>(s);
        return t;
    }
}
