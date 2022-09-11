using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Scrollerv2 : MonoBehaviour
{
    public string direction;

    // If there are still notes left in the song, move the scroller objects in the correct direction (up -> down, left -> right). Use the song timing to interpolate the speed of movement.
    void Update()
    {
        if (Conductor.instance.songStarted && !RhythmManager.instance.gameOver)
        {
            switch (direction)
            {
                case "Down":
                    if (Conductor.instance.nextIndex[0] - 1 >= 0)
                    {
                        transform.Translate((Vector3.down * (Conductor.instance.beatsOnScreen - ((Conductor.instance.upTrack[Conductor.instance.nextIndex[0] - 1] - Conductor.instance.songPosInBeats))
                        / Conductor.instance.beatsOnScreen) * (Conductor.instance.scrollSpeed * 100) / Conductor.instance.songBpm) * Time.deltaTime);
                    }
                    break;

                case "Up":
                    if (Conductor.instance.nextIndex[1] - 1 >= 0)
                    {
                        transform.Translate((Vector3.up * (Conductor.instance.beatsOnScreen - ((Conductor.instance.downTrack[Conductor.instance.nextIndex[1] - 1] - Conductor.instance.songPosInBeats))
                        / Conductor.instance.beatsOnScreen) * (Conductor.instance.scrollSpeed * 100) / Conductor.instance.songBpm) * Time.deltaTime);
                    }
                    break;

                case "Right":
                    if (Conductor.instance.nextIndex[2] - 1 >= 0)
                    {
                        transform.Translate((Vector3.right * (Conductor.instance.beatsOnScreen - ((Conductor.instance.leftTrack[Conductor.instance.nextIndex[2] - 1] - Conductor.instance.songPosInBeats))
                        / Conductor.instance.beatsOnScreen) * (Conductor.instance.scrollSpeed * 100) / Conductor.instance.songBpm) * Time.deltaTime);
                    }
                    break;

                case "Left":
                    if (Conductor.instance.nextIndex[3] - 1 >= 0)
                    {
                        transform.Translate((Vector3.left * (Conductor.instance.beatsOnScreen - ((Conductor.instance.rightTrack[Conductor.instance.nextIndex[3] - 1] - Conductor.instance.songPosInBeats))
                        / Conductor.instance.beatsOnScreen) * (Conductor.instance.scrollSpeed * 100) / Conductor.instance.songBpm) * Time.deltaTime);
                    }
                    break;
            }
        }
    }
}
