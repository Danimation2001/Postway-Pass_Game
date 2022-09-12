using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using SonicBloom.Koreo;

public class Conductorv2 : MonoBehaviour
{
    public KoreographyTrack track;

    // Start is called before the first frame update
   void Start()
   {
        List<KoreographyEvent> events = track.GetAllEvents();
   }
}
