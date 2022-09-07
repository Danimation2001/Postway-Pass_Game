using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace MagicLightProbes
{
    [ExecuteInEditMode]
    public class MLPPrefab : MonoBehaviour
    {
        public string name;
        public string uid;

        private void OnEnable()
        {
            name = gameObject.name;
            uid = gameObject.GetInstanceID().ToString();
        }
    }
}
