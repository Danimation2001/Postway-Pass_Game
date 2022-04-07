using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class IKFootPlacement : MonoBehaviour
{
    Animator _anim;
    [SerializeField] LayerMask _groundLayer;

    [Range(0, 1)]
    [SerializeField] float _distanceToGround;

    // Start is called before the first frame update
    void Start()
    {
        _anim = GetComponent<Animator>();
    }

    // Update is called once per frame
    void Update()
    {

    }

    void OnAnimatorIK(int layerIndex)
    {
        if (_anim)
        {
            _anim.SetIKPositionWeight(AvatarIKGoal.LeftFoot, _anim.GetFloat("IKLeftFootWeight"));
            _anim.SetIKRotationWeight(AvatarIKGoal.LeftFoot, _anim.GetFloat("IKLeftFootWeight"));

            _anim.SetIKPositionWeight(AvatarIKGoal.RightFoot, _anim.GetFloat("IKRightFootWeight"));
            _anim.SetIKRotationWeight(AvatarIKGoal.RightFoot, _anim.GetFloat("IKRightFootWeight"));


            // Left Foot
            RaycastHit hit;
            Ray ray = new Ray(_anim.GetIKPosition(AvatarIKGoal.LeftFoot) + Vector3.up, Vector3.down);

            if (Physics.Raycast(ray, out hit, _distanceToGround + 1f, _groundLayer))
            {
                Vector3 footPosition = hit.point;
                footPosition.y += _distanceToGround;
                _anim.SetIKPosition(AvatarIKGoal.LeftFoot, footPosition);
                Vector3 forward = Vector3.ProjectOnPlane(transform.forward, hit.normal);
                _anim.SetIKRotation(AvatarIKGoal.LeftFoot, Quaternion.LookRotation(forward, hit.normal));
            }

            // Right Foot
            ray = new Ray(_anim.GetIKPosition(AvatarIKGoal.RightFoot) + Vector3.up, Vector3.down);

            if (Physics.Raycast(ray, out hit, _distanceToGround + 1f, _groundLayer))
            {
                Vector3 footPosition = hit.point;
                footPosition.y += _distanceToGround;
                _anim.SetIKPosition(AvatarIKGoal.RightFoot, footPosition);
                Vector3 forward = Vector3.ProjectOnPlane(transform.forward, hit.normal);
                _anim.SetIKRotation(AvatarIKGoal.RightFoot, Quaternion.LookRotation(forward, hit.normal));
            }
        }
    }
}
