using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using TMPro;

public class RhythmUI : MonoBehaviour
{
    public TMP_Text songNameText;

    // Start is called before the first frame update
    void Start()
    {
        songNameText.text = Conductor.instance.songName;
    }

    // Update is called once per frame
    void Update()
    {
        
    }
}
