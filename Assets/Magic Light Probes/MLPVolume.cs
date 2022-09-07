using System.Collections.Generic;
using UnityEditor;
using UnityEngine;

#if UNITY_EDITOR

#endif
namespace MagicLightProbes
{
    [ExecuteInEditMode]
    public class MLPVolume : MonoBehaviour
    {
        [HideInInspector]
        public MagicLightProbes parentRootComponent;
        [HideInInspector]
        public MeshRenderer selfRenderer;
        [HideInInspector]
        public bool showGizmo;
        public bool showGizmoSelected;
        public bool isPartVolume;
        public bool isSubdividedPart;
        public bool isCalculated;
        public bool isInProcess;
        public bool skipped;
        public int id;
        public Color colorOnSelection;        

        public List<MLPPointData> localAcceptedPoints = new List<MLPPointData>();
        public List<MLPPointData> localNearbyGeometryPoints = new List<MLPPointData>();        
        public List<MLPPointData> localContrastPoints = new List<MLPPointData>();
        public List<MLPPointData> localCornerPoints = new List<MLPPointData>();
        public List<Vector3> localNearbyGeometryPointsPositions = new List<Vector3>();
        public List<Vector3> resultNearbyGeometryPointsPositions = new List<Vector3>();
        public List<Vector3> localCornerPointsPositions = new List<Vector3>();
        public List<Vector3> resultLocalCornerPointsPositions = new List<Vector3>();
        public List<Vector3> localEquivalentPointsPositions = new List<Vector3>();
        public List<Vector3> resultLocalEquivalentPointsPositions = new List<Vector3>();
        public List<Vector3> resultLocalFreePointsPositions = new List<Vector3>();
        public List<Vector3> localUnlitPointsPositions = new List<Vector3>();
        public List<Vector3> localFreePointsPositions = new List<Vector3>();
        public List<Vector3> resultLocalUnlitPointsPositions = new List<Vector3>();
        public List<Vector3> localDirections = new List<Vector3>();
        public List<Vector3> localAvaragedDirections = new List<Vector3>();
        public List<MLPPointData> localColorThresholdEditingPoints = new List<MLPPointData>();
        public int objectsInside;

#if UNITY_EDITOR

        private void Start()
        {
            parentRootComponent = GetComponentInParent<MagicLightProbes>();
            selfRenderer = GetComponent<MeshRenderer>();
        }

        private static void DrawVolumeWithBounds(MLPVolume volume, Color mainColor, Color boundsColor)
        {
            if (volume.parentRootComponent.prefabRoot == null)
            {
                volume.parentRootComponent.prefabRoot = GameObject.Find(volume.parentRootComponent.prefabRootName);
            }

            if (volume.parentRootComponent.isInPrefab)
            {
                Gizmos.matrix = UnityEditor.SceneManagement.PrefabStageUtility.GetCurrentPrefabStage() != null
                    ? Matrix4x4.TRS(volume.transform.position,
                        volume.isPartVolume ? volume.transform.rotation : volume.transform.localRotation,
                        volume.transform.localScale)
                    : Matrix4x4.TRS(volume.transform.position,
                        volume.isPartVolume
                            ? volume.transform.rotation
                            : volume.parentRootComponent.prefabRoot.transform.localRotation,
                        volume.transform.localScale);
            }
            else
            {
                Gizmos.matrix = Matrix4x4.TRS(volume.transform.position,
                    volume.isPartVolume
                        ? volume.transform.rotation
                        : volume.parentRootComponent.transform.localRotation,
                    volume.transform.localScale);
            }

            Gizmos.color = mainColor;
            Gizmos.DrawCube(Vector3.zero, Vector3.one);
            Gizmos.color = boundsColor;
            Gizmos.DrawWireCube(Vector3.zero, Vector3.one);
        }

        private static void DrawVolumeWithOnlyBounds(MLPVolume volume, Color boundsColor)
        {
            if (volume.parentRootComponent.prefabRoot == null)
            {
                volume.parentRootComponent.prefabRoot = volume.transform.root.gameObject;
            }

            if (volume.parentRootComponent.isInPrefab)
            {
                Gizmos.matrix = UnityEditor.SceneManagement.PrefabStageUtility.GetCurrentPrefabStage() != null
                    ? Matrix4x4.TRS(volume.transform.position,
                        volume.isPartVolume ? volume.transform.rotation : volume.transform.localRotation,
                        volume.transform.localScale)
                    : Matrix4x4.TRS(volume.transform.position,
                        volume.isPartVolume
                            ? volume.transform.rotation
                            : volume.parentRootComponent.prefabRoot.transform.localRotation,
                        volume.transform.localScale);
            }
            else
            {
                Gizmos.matrix = Matrix4x4.TRS(volume.transform.position,
                        volume.isPartVolume
                            ? volume.transform.rotation
                            : volume.parentRootComponent.transform.localRotation,
                        volume.transform.localScale);
            }

            Gizmos.color = boundsColor;
            Gizmos.DrawWireCube(Vector3.zero, Vector3.one);
        }

        [DrawGizmo(GizmoType.Selected | GizmoType.InSelectionHierarchy | GizmoType.Active)]
        private static void DrawGizmoOnSelection(MLPVolume volume, GizmoType gizmoType)
        {
            if (volume.showGizmoSelected)
            {
                DrawVolumeWithBounds(volume, new Color(1, 1, 0, 0.5f), Color.yellow); 
            }
        }

        [DrawGizmo(GizmoType.NonSelected | GizmoType.NotInSelectionHierarchy)]
        private static void DrawGizmoAlways(MLPVolume volume, GizmoType gizmoType)
        {
            if (volume.parentRootComponent.calculatingVolume)
            {
                if (volume.parentRootComponent.subVolumesDivided.Count > 0)
                {
                    if (volume.isPartVolume)
                    {
                        if (volume.skipped)
                        {
                            DrawVolumeWithBounds(volume, Color.red, Color.red);
                            return;
                        }

                        if (volume.isCalculated)
                        {
                            DrawVolumeWithOnlyBounds(volume, Color.yellow);
                        }
                        else
                        {
                            if (volume.isInProcess)
                            {
                                DrawVolumeWithBounds(volume, Color.yellow, Color.red);
                            }
                            else
                            {
                                DrawVolumeWithOnlyBounds(volume, Color.yellow);
                            }
                        }
                    }
                }
                else
                {
                    if (volume.isInProcess)
                    {
                        DrawVolumeWithBounds(volume, Color.yellow, Color.yellow);
                    }
                    else
                    {
                        DrawVolumeWithBounds(volume, Color.red, Color.yellow);
                    }
                }

            }
            else
            {
                if (volume.showGizmo)
                {
                    DrawVolumeWithBounds(volume, new Color(0, 1, 0, 0.5f), Color.yellow);
                }
            }
        }
#endif
    }
}
