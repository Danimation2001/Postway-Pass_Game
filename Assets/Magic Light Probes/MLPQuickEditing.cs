#if UNITY_EDITOR
using System.Collections.Generic;
using UnityEditor;

using UnityEngine;

namespace MagicLightProbes
{
    [HelpURL("https://motion-games-studio.gitbook.io/magic-light-probes/system-components/mlp-quick-editing")]
    public class MLPQuickEditing : MonoBehaviour
    {
        public MagicLightProbes parent;
        public float gizmoScale;
        public float drawDistance = 10;
        private Vector3 _lastPrefabPosition = Vector3.zero;
        private Quaternion _lastPrefabRotation = Quaternion.identity;
        
#if UNITY_2020_1_OR_NEWER
        private UnityEditor.SceneManagement.PrefabStage prefabStage;
        private UnityEditor.SceneManagement.PrefabStage.Mode prefabStageMode;
#endif

        private void OnDrawGizmosSelected()
        {
            var position = Vector3.zero;
            
            for (int i = 0; i < parent.localFinishedPositions.Count; i++)
            {
                if (parent.isInPrefab)
                {
                    if (parent.prefabConnectionObject == null)
                    {
                        Debug.LogFormat(
                            "<color=yellow>MLP:</color> Prefab Connection object lost for ["+ parent.prefabRootName + "], volume recalculation required.");
                        return;    
                    }
                    
                    Matrix4x4 noTRS = Matrix4x4.TRS(Vector3.zero, Quaternion.identity, Vector3.one);
                    Matrix4x4 parentTRS = Matrix4x4.TRS(parent.prefabConnectionObject.transform.position,
                        parent.prefabConnectionObject.transform.rotation, Vector3.one);
                    
#if UNITY_2020_1_OR_NEWER
                    prefabStage = UnityEditor.SceneManagement.PrefabStageUtility.GetCurrentPrefabStage();

                    if (prefabStage != null)
                    {
                        prefabStageMode = UnityEditor.SceneManagement.PrefabStageUtility.GetCurrentPrefabStage().mode;
                        
                        position = parent.calculatedFromPrefab ? parent.prefabConnectionObject.transform.position : Vector3.zero;
                        Gizmos.matrix = prefabStageMode == UnityEditor.SceneManagement.PrefabStage.Mode.InContext ? parentTRS : noTRS;
                    }
                    else
                    {
                        position = parent.calculatedFromPrefab ? parent.prefabConnectionObject.transform.position : Vector3.zero;
                        Gizmos.matrix = parent.calculatedFromPrefab ? parentTRS : noTRS;
                    }
#else
                    position = PrefabStageUtility.GetCurrentPrefabStage() != null ? Vector3.zero : 
                        parent.calculatedFromPrefab ? parent.prefabConnectionObject.transform.position : Vector3.zero;
   
                    Gizmos.matrix = PrefabStageUtility.GetCurrentPrefabStage() != null
                        ? noTRS : parent.calculatedFromPrefab
                            ? parentTRS : noTRS;
#endif

                    if (position != _lastPrefabPosition || parent.prefabConnectionObject.transform.rotation != _lastPrefabRotation)
                    {
                        parent.combinedVolumeComponent = parent.GetCombinedVolume(parent.combinedVolumeComponent);
                            
                        _lastPrefabPosition = position;
                        _lastPrefabRotation = parent.prefabConnectionObject.transform.rotation;
                        parent.combinedVolumeComponent.combined = false;
                        parent.recombinationNeeded = true;
                    }
                }

                if (Vector3.Distance(SceneView.lastActiveSceneView.camera.transform.position, parent.localFinishedPositions[i]) <= drawDistance)
                {
                    Gizmos.color = Color.yellow;
                    Gizmos.DrawSphere(parent.localFinishedPositions[i], gizmoScale);
                }
            }
        }

    }    
}
#endif
