using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Animations.Rigging;

public class HeadLookControl : MonoBehaviour
{
    Rig _rig;
    public Transform lookTarget;
    public float threshold;
    public float blendSpeed;
    Transform _player;

    void Start()
    {
        _rig = gameObject.GetComponent<Rig>();
        _player = GameObject.FindGameObjectWithTag("Player").transform;
    }

    // Update is called once per frame
    void Update()
    {
        //Debug.Log(GetRelativePosition(_player, lookTarget.position));

        Vector3 relativePos = GetRelativePosition(_player, lookTarget.position);

        if (relativePos.z < threshold) _rig.weight = Mathf.Lerp(_rig.weight, 0f, blendSpeed * Time.deltaTime);

        if (relativePos.z > threshold) _rig.weight = Mathf.Lerp(_rig.weight, 1f, blendSpeed * Time.deltaTime);
    }

    Vector3 GetRelativePosition(Transform origin, Vector3 position)
    {
        Vector3 distance = position - origin.position;
        Vector3 relativePosition = Vector3.zero;
        relativePosition.x = Vector3.Dot(distance, origin.right.normalized);
        relativePosition.y = Vector3.Dot(distance, origin.up.normalized);
        relativePosition.z = Vector3.Dot(distance, origin.forward.normalized);

        return relativePosition;
    }
}
