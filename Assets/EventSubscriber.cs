using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using SonicBloom.Koreo;

public class EventSubscriber : MonoBehaviour
{
    // Start is called before the first frame update
    void Start()
    {
        Koreographer.Instance.RegisterForEvents("TestEventID", FireEventDebugLog);
        
    }

    void FireEventDebugLog(KoreographyEvent koreoEvent) {
        Debug.Log("Koreography Event Fired");
    }
}
