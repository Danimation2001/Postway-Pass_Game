#if UNITY_EDITOR
using System.Collections;
using System.Collections.Generic;
using System.IO;

using UnityEngine;
using UnityEngine.SceneManagement;

namespace MagicLightProbes
{
    /// <summary>
    /// Cannot work in multithreading mode
    /// </summary>
    public class CullGeometryCollisions
    {
        public IEnumerator ExecutePass(MagicLightProbes parent, MagicLightProbes.VolumeParameters volumePart, MagicLightProbes.CalculationTarget calculationTarget)
        {
            parent.currentPass = "Culling Geometry Collisions...";
            parent.currentPassProgressCounter = 0;
            parent.currentPassProgressFrameSkipper = 0;

            List<MLPPointData> tempAcceptedList = new List<MLPPointData>();
            List<MLPPointData> tempCulledList = new List<MLPPointData>();
            List<MLPPointData> tempCornerPointsList = new List<MLPPointData>();

            bool physicsOptionsChanged = false;

            if (!Physics.queriesHitBackfaces)
            {
                Physics.queriesHitBackfaces = true;
                physicsOptionsChanged = true;
            }

            if (parent.debugMode)
            {
                parent.tmpSharedPointsArray.Clear();
                parent.tmpSharedPointsArray.AddRange(parent.debugAcceptedPoints);
                parent.debugAcceptedPoints.Clear();
                parent.debugCulledPoints.Clear();
            }

            for (int i = 0; i < parent.tmpSharedPointsArray.Count; i++)
            {
                Collider[] colliders = new Collider[0];
                
                if (UnityEditor.SceneManagement.PrefabStageUtility.GetCurrentPrefabStage() == null)
                {
                    colliders = Physics.OverlapSphere(parent.tmpSharedPointsArray[i].position,
                        parent.collisionDetectionRadius, parent.layerMask);
                }

                if (colliders.Length == 0)
                {
                    Ray[] checkRays =
                    {
                        new Ray(parent.tmpSharedPointsArray[i].position, Vector3.down),
                        new Ray(parent.tmpSharedPointsArray[i].position, -Vector3.down),
                        new Ray(parent.tmpSharedPointsArray[i].position, Vector3.right),
                        new Ray(parent.tmpSharedPointsArray[i].position, -Vector3.right),
                        new Ray(parent.tmpSharedPointsArray[i].position, Vector3.forward),
                        // new Ray(parent.tmpSharedPointsArray[i].position, -Vector3.forward)
                    };

                    bool aboveInfinity = false;
                    int freeRays = 0;
                    int hitRays = 0;

                    for (var index = 0; index < checkRays.Length; index++)
                    {
                        var ray = checkRays[index];
                        RaycastHit hitInfoForward;
                        RaycastHit hitInfoBackward;

                        Vector3 endPoint = parent.tmpSharedPointsArray[i].position + (ray.direction * 5000.0f);
                        Ray backRay = new Ray(endPoint, (ray.origin - endPoint).normalized);

                        if (parent.RaycastPhysicsScene(ray.origin, ray.direction, 0, out hitInfoForward))
                        {
                            if (parent.CheckIfStatic(hitInfoForward.collider.gameObject))
                            {
                                if (parent.RaycastPhysicsScene(
                                    Vector3.MoveTowards(hitInfoForward.point, parent.tmpSharedPointsArray[i].position, 0.001f),
                                    Vector3.Normalize(parent.tmpSharedPointsArray[i].position - hitInfoForward.point),
                                    0,
                                    out hitInfoBackward))
                                {
                                    if (parent.CheckIfStatic(hitInfoForward.collider.gameObject))
                                    {
                                        if (hitInfoForward.distance >= hitInfoBackward.distance ||
                                            hitInfoForward.collider == hitInfoBackward.collider)
                                        {
                                            hitRays++;
                                        }
                                        else
                                        {
                                            hitRays = 0;
                                        }
                                    }
                                    else
                                    {
                                        hitRays = 0;
                                        break;
                                    }
                                }
                                else
                                {
                                    hitRays = 0;
                                    break;
                                }
                            }
                            else
                            {
                                hitRays = 0;
                                break;
                            }
                        }
                        else
                        {
                            if (index == 0)
                            {
                                aboveInfinity = true;
                                break;
                            }
                            else
                            {
                                hitRays = 0;
                                break;
                            }
                        }
                    }

                    if (hitRays <= 0 && !aboveInfinity)
                    {
                         tempAcceptedList.Add(parent.tmpSharedPointsArray[i]);
                    }
                    else
                    {
                         tempCulledList.Add(parent.tmpSharedPointsArray[i]);
                    }
                }
                else
                {
                    foreach (var collider in colliders)
                    {
                        if (parent.CheckIfStatic(collider.gameObject))
                        {
                            if (!tempCulledList.Contains(parent.tmpSharedPointsArray[i]))
                            {
                                tempCulledList.Add(parent.tmpSharedPointsArray[i]);
                            }
                        }
                        else
                        {
                            tempAcceptedList.Add(parent.tmpSharedPointsArray[i]);
                        }
                    }
                }

                if (!parent.isInBackground)
                {
                    if (parent.UpdateProgress(parent.tmpSharedPointsArray.Count, 1000))
                    {
                        yield return null;
                    }
                }
            }

            if (physicsOptionsChanged)
            {
                Physics.queriesHitBackfaces = true;
            }

            if (parent.debugMode)
            {
                parent.debugAcceptedPoints.AddRange(tempAcceptedList);
                parent.debugCulledPoints.AddRange(tempCulledList);

                if (parent.debugPass == MagicLightProbes.DebugPasses.GeometryCollision)
                {
                    switch (parent.drawMode)
                    {
                        case MagicLightProbes.DrawModes.Accepted:
                            parent.totalProbesInSubVolume = parent.debugAcceptedPoints.Count;
                            break;
                        case MagicLightProbes.DrawModes.Culled:
                            parent.totalProbesInSubVolume = parent.debugCulledPoints.Count;
                            break;
                        case MagicLightProbes.DrawModes.Both:
                            parent.totalProbesInSubVolume = parent.debugAcceptedPoints.Count + parent.debugCulledPoints.Count;
                            break;
                    }
                }
                else
                {
                    parent.totalProbesInSubVolume = parent.debugAcceptedPoints.Count;
                }
            }
            else
            {
                parent.tmpSharedPointsArray.Clear();
                parent.tmpSharedPointsArray.AddRange(tempAcceptedList);
                parent.tmpSharedPointsArray.AddRange(tempCornerPointsList);
                parent.tmpGeometryCollisionPoints.AddRange(tempCornerPointsList);
                tempAcceptedList.Clear();
                tempCulledList.Clear();
            }

            parent.calculatingVolumeSubPass = false;
        }
    }
}
#endif
