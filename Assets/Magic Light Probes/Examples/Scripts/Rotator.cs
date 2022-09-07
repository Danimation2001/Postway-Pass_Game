using UnityEngine;

namespace MagicLightProbes
{
    [ExecuteInEditMode]
    public class Rotator : MonoBehaviour
    {
        public Vector3 localRotationSpeed;
        public Vector3 worldRotationSpeed;
        public bool executeInEditMode = false;
        public bool unscaledTime;  

        void OnRenderObject()
        {
            if (executeInEditMode)
            {
                if (!Application.isPlaying)
                {
                    Rotate();
                }
            }
        }

        void Update()
        {
            if (Application.isPlaying)
            {
                Rotate();
            }
        }

        void Rotate()
        {
            float deltaTime = !unscaledTime ? Time.deltaTime : Time.unscaledDeltaTime;

            if (localRotationSpeed != Vector3.zero)
            {
                transform.Rotate(localRotationSpeed * deltaTime, Space.Self);
            }

            if (worldRotationSpeed != Vector3.zero)
            {
                transform.Rotate(worldRotationSpeed * deltaTime, Space.World);
            }
        }
    }
}