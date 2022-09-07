#if UNITY_EDITOR
using System;
using System.Collections;
using System.Collections.Generic;
using System.IO;
using System.Threading.Tasks;
using Unity.Collections;
using Unity.Jobs;
using UnityEngine;
using UnityEngine.SceneManagement;

namespace MagicLightProbes
{
    /// <summary>
    /// Work in multithreading mode
    /// </summary>
    public class CullByHeight
    {
        struct ProbeRaycastData
        {
            public MLPPointData point;
            public List<RaycastHit> hits;
            public List<RaycastHit> finalList;
        }

        private List<Terrain> sceneTerrains = new List<Terrain>();
        
        public IEnumerator ExecutePass(MagicLightProbes parent, MagicLightProbes.VolumeParameters volumePart, MagicLightProbes.CalculationTarget calculationTarget)
        {
            parent.currentPass = "Culling By Max Height...";
            parent.currentPassProgressCounter = 0;
            parent.currentPassProgressFrameSkipper = 0;

            sceneTerrains.AddRange(GameObject.FindObjectsOfType<Terrain>());

            List<MLPPointData> tempList = new List<MLPPointData>();

            if (parent.useVolumeBottom)
            {
                for (int i = 0; i < parent.tmpSharedPointsArray.Count; i++)
                {
                    if (parent.tmpSharedPointsArray[i].position.y >= volumePart.position.y - (volumePart.demensions.y / 2))
                    {
                        tempList.Add(parent.tmpSharedPointsArray[i]);
                    }
                }
            }
            else
            {
                int maxHitsPerRay = 10;
                
                ProbeRaycastData[] probeRaycastDatas = new ProbeRaycastData[parent.tmpSharedPointsArray.Count];
                NativeArray<RaycastCommand> raycastCommands = new NativeArray<RaycastCommand>(parent.tmpSharedPointsArray.Count, Allocator.Persistent);
                NativeArray<RaycastHit> raycastResults = new NativeArray<RaycastHit>(parent.tmpSharedPointsArray.Count * maxHitsPerRay, Allocator.Persistent);
                List<RaycastHit> raycastHits = new List<RaycastHit>();
                
                for (int i = 0; i < parent.tmpSharedPointsArray.Count; i++)
                {
                    if (parent.tmpSharedPointsArray[i] != null)
                    {
                        raycastCommands[i] = new RaycastCommand(parent.tmpSharedPointsArray[i].position, 
                            Vector3.down, Mathf.Infinity, parent.layerMask, maxHits:1);
                    }
                }
                
                JobHandle handle = RaycastCommandMultihit.ScheduleBatch(raycastCommands, 
                    raycastResults, 32, maxHitsPerRay);
                
                handle.Complete();
                raycastHits.AddRange(raycastResults.ToArray());
                
                raycastResults.Dispose();
                raycastCommands.Dispose();

                Parallel.For(0, parent.tmpSharedPointsArray.Count, i =>
                {
                    probeRaycastDatas[i].point = parent.tmpSharedPointsArray[i];
                    probeRaycastDatas[i].hits = new List<RaycastHit>();

                    for (int j = 0; j < maxHitsPerRay; j++)
                    {
                        probeRaycastDatas[i].hits.Add(raycastHits[(i * maxHitsPerRay) + j]);
                    }
                });

                for (int i = 0; i < probeRaycastDatas.Length; i++)
                {
                    probeRaycastDatas[i].finalList = new List<RaycastHit>();
                    
                    for (int j = 0; j < probeRaycastDatas[i].hits.Count; j++)
                    {
                        if (probeRaycastDatas[i].hits[j].collider != null)
                        {
                            probeRaycastDatas[i].finalList.Add(probeRaycastDatas[i].hits[j]);
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
                
                parent.currentPassProgressCounter = 0;
                parent.currentPassProgressFrameSkipper = 0;

                for (int i = 0; i < parent.tmpSharedPointsArray.Count; i++)
                {
                    for (int j = 0; j < probeRaycastDatas[i].finalList.Count; j++)
                    {
                        RaycastHit outInfo = probeRaycastDatas[i].finalList[j];

#if TERRAINPACKAGE_EXIST
                        if (sceneTerrains.Find(item => item.name == outInfo.collider.name))
                        {
                            if (outInfo.distance <= parent.maxHeightAboveTerrain)
                            {
                                tempList.Add(parent.tmpSharedPointsArray[i]);
                            }
                            else
                            {
                                if (parent.debugMode)
                                {
                                    parent.tmpOutOfMaxHeightPoints.Add(parent.tmpSharedPointsArray[i]);
                                }
                            }
                        }
                        else
                        {
                            GroundDependentSpawn(parent, outInfo, tempList, i);
                        }
#else
                        GroundDependentSpawn(parent, outInfo, tempList, i);
#endif
                    }

                    if (!parent.isInBackground)
                    {
                        if (parent.UpdateProgress(parent.tmpSharedPointsArray.Count, 1000))
                        {
                            yield return null;
                        }
                    }
                }
            }

            if (parent.debugMode)
            {
                parent.debugAcceptedPoints.AddRange(tempList);
                parent.debugCulledPoints.AddRange(parent.tmpOutOfMaxHeightPoints);

                if (parent.debugPass == MagicLightProbes.DebugPasses.MaximumHeight)
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
                parent.tmpOutOfMaxHeightPoints.Clear();
                parent.tmpSharedPointsArray.Clear();
                parent.tmpSharedPointsArray.AddRange(tempList);
                tempList.Clear();

                parent.totalProbesInSubVolume = parent.tmpSharedPointsArray.Count;
            }

            parent.calculatingVolumeSubPass = false;
        }

        private void GroundDependentSpawn(MagicLightProbes parent, RaycastHit outInfo, List<MLPPointData> tempList, int probeIndex)
        {
            if (CheckIfIsGroundOrFloor(parent, outInfo.collider.name, parent.groundAndFloorObjects))
            {
                if (outInfo.distance <= parent.maxHeightAboveGeometry)
                {
                    tempList.Add(parent.tmpSharedPointsArray[probeIndex]);
                }
                else
                {
                    if (parent.debugMode)
                    {
                        parent.tmpOutOfMaxHeightPoints.Add(parent.tmpSharedPointsArray[probeIndex]);
                    }
                }
            }
        }

        private bool CheckIfIsGroundOrFloor (MagicLightProbes parent, string objectName, List<string> keywords)
        {
            bool result = false;

            Parallel.For(0, keywords.Count, (i, state) =>
            {
                if (result)
                {
                    state.Stop();
                }
                
                if (objectName.Contains(keywords[i]))
                {
                    result = true;
                    state.Stop();
                }
            });
            
            // for (int i = 0; i < keywords.Count; i++)
            // {
            //     if (checkObject.name.Contains(keywords[i]))
            //     {
            //         result = true;
            //         break;
            //     }
            //     else if (parent.CheckIfTagExist(keywords[i]))
            //     {
            //         if (checkObject.CompareTag(keywords[i]))
            //         {
            //             result = true;
            //             break;
            //         }
            //     }
            // }

            return result;
        }
    }
}
#endif
