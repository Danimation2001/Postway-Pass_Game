using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class WaterZone : MonoBehaviour
{
    Transform _groundPos;

    void Start()
    {
        _groundPos = GameObject.Find("GroundPos").transform;
    }

    private void OnTriggerEnter(Collider other)
    {
        if(other.CompareTag("Player"))
        {
            GameManager.Instance.lastPlayerPosition = _groundPos.localPosition;
            GameManager.Instance.lastPlayerRotation = Quaternion.Euler(Vector3.zero);
            GameManager.Instance.needsReposition = true;
        }
    }
}
