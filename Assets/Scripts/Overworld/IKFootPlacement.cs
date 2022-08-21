using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Animations.Rigging;

public class IKFootPlacement : MonoBehaviour
{
    public float maxHitDistance;
    public float addedHeight;
    public float yOffset;
    public float castRadius;
    [SerializeField] Transform footTransformR, footTransformL, footTargetTransformR, footTargetTransformL;
    [SerializeField] GameObject footRigConstraintR, footRigConstraintL;
    [SerializeField] Animator animator;
    Transform[] allFootTransforms = new Transform[2], allTargetTransforms = new Transform[2];
    TwoBoneIKConstraint[] allIKConstraints = new TwoBoneIKConstraint[2];
    float[] allIKWeights = new float[2];
    bool[] allGroundSphereHits = new bool[3];
    Vector3[] allHitNormals = new Vector3[2];
    LayerMask groundLayerMask;
    LayerMask hitLayer;
    float angleAboutX;
    float angleAboutZ;

    void Start()
    {
        // initialize the arrays
        allFootTransforms[0] = footTransformR;
        allFootTransforms[1] = footTransformL;

        allTargetTransforms[0] = footTargetTransformR;
        allTargetTransforms[1] = footTargetTransformL;

        allIKConstraints[0] = footRigConstraintR.GetComponent<TwoBoneIKConstraint>();
        allIKConstraints[1] = footRigConstraintL.GetComponent<TwoBoneIKConstraint>();

        groundLayerMask = LayerMask.NameToLayer("Environment");
    }

    void FixedUpdate()
    {
        RotateCharacterFeet();
    }

    void CheckGroundBelow(out Vector3 hitPoint, out bool gotGroundSphereCastHit, out Vector3 hitNormal, out LayerMask hitLayer, out float currentHitDistance,
        Transform objectTransform, int checkForLayerMask, float maxHitDistance, float addedHeight)
    {
        Vector3 startSphereCast = objectTransform.position + new Vector3(0f, addedHeight, 0f);
        RaycastHit hit;

        if (checkForLayerMask == -1)
        {
            Debug.LogError("Layer does not exist");
            gotGroundSphereCastHit = false;
            currentHitDistance = 0;
            hitLayer = LayerMask.NameToLayer("Player");
            hitNormal = Vector3.up;
            hitPoint = objectTransform.position;
        }
        else
        {
            int layerMask = (1 << checkForLayerMask);
            if (Physics.SphereCast(startSphereCast, castRadius, Vector3.down, out hit, maxHitDistance, layerMask, QueryTriggerInteraction.UseGlobal))
            {
                hitLayer = hit.transform.gameObject.layer;
                currentHitDistance = hit.distance - addedHeight;
                hitNormal = hit.normal;
                gotGroundSphereCastHit = true;
                hitPoint = hit.point;
            }
            else
            {
                gotGroundSphereCastHit = false;
                currentHitDistance = 0;
                hitLayer = LayerMask.NameToLayer("Player");
                hitNormal = Vector3.up;
                hitPoint = objectTransform.position;
            }
        }
    }

    Vector3 ProjectOnContactPlane(Vector3 vector, Vector3 hitNormal)
    {
        return vector - hitNormal * Vector3.Dot(vector, hitNormal);
    }

    void ProjectedAxisAngles(out float angleAboutX, out float angleAboutZ, Transform footTargetTransform, Vector3 hitNormal)
    {
        Vector3 xAxisProjected = ProjectOnContactPlane(footTargetTransform.up, hitNormal).normalized;
        Vector3 zAxisProjected = ProjectOnContactPlane(footTargetTransform.forward, hitNormal).normalized;

        angleAboutX = Vector3.SignedAngle(footTargetTransform.up, xAxisProjected, footTargetTransform.forward);
        angleAboutZ = Vector3.SignedAngle(footTargetTransform.forward, zAxisProjected, footTargetTransform.up);
    }

    void RotateCharacterFeet()
    {
        allIKWeights[0] = animator.GetFloat("IKRightFootWeight");
        allIKWeights[1] = animator.GetFloat("IKLeftFootWeight");

        for (int i = 0; i < allFootTransforms.Length; i++)
        {
            allIKConstraints[i].weight = allIKWeights[i];

            CheckGroundBelow(out Vector3 hitPoint, out allGroundSphereHits[i], out Vector3 hitNormal, out hitLayer, out _, allFootTransforms[i],
                groundLayerMask, maxHitDistance, addedHeight);
            allHitNormals[i] = hitNormal;

            if (allGroundSphereHits[i] == true)
            {
                ProjectedAxisAngles(out angleAboutX, out angleAboutZ, allFootTransforms[i], allHitNormals[i]);

                //align the foot target to the ground position
                allTargetTransforms[i].position = new Vector3(allFootTransforms[i].position.x, hitPoint.y + yOffset, allFootTransforms[i].position.z);

                //align the foot target to the ground rotation
                allTargetTransforms[i].rotation = allFootTransforms[i].rotation;
                if (i == 0) allTargetTransforms[i].localEulerAngles = new Vector3(allTargetTransforms[i].localEulerAngles.x + angleAboutZ,
                    allTargetTransforms[i].localEulerAngles.y, allTargetTransforms[i].localEulerAngles.z + angleAboutX);

                else if (i == 1) allTargetTransforms[i].localEulerAngles = new Vector3(allTargetTransforms[i].localEulerAngles.x + -angleAboutZ,
                    allTargetTransforms[i].localEulerAngles.y, allTargetTransforms[i].localEulerAngles.z + angleAboutX);
            }
            else
            {
                allTargetTransforms[i].position = allFootTransforms[i].position;
                allTargetTransforms[i].rotation = allFootTransforms[i].rotation;
            }
        }
    }
}
