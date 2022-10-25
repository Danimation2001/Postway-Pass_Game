using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Cinemachine;

public class MoveCamera : MonoBehaviour
{
    public CinemachineVirtualCamera cam;

    private void OnTriggerEnter(Collider other)
    {
        if (other.tag == "Player")
        {
            cam.GetCinemachineComponent<CinemachineTrackedDolly>().m_PathPosition = 1;
        }
    }
}
