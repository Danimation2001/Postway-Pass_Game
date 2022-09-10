using System.Collections;
using System.Collections.Generic;
using UnityEngine;


namespace AmazingAssets.TerrainToMesh.Example
{
    [RequireComponent(typeof(MeshFilter), typeof(MeshRenderer))]
    public class ExportMeshWithEdgeFall : MonoBehaviour
    {
        public TerrainData terrainData;

        public int vertexCountHorizontal = 100;
        public int vertexCountVertical = 100;

        public TerrainToMesh.EdgeFall edgeFall = new EdgeFall(0, true);

        public Texture2D edgeFallTexture;


        void Start()
        {
            if (terrainData == null)
                return;


            //1. Export mesh with edge fall/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

            Mesh terrainMesh = terrainData.TerrainToMesh().ExportMesh(vertexCountHorizontal, vertexCountVertical, TerrainToMesh.Normal.CalculateFromMesh, edgeFall);

            GetComponent<MeshFilter>().sharedMesh = terrainMesh;




            //2. Create materials////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
           
            string shaderName = TerrainToMeshConstants.shaderUnityDefault;                   //Default shader based on used render pipeline
            string mainTexturePropName = TerrainToMeshConstants.materailPropTextureMainTex;  //_MainTex property name inside shader. 

          
            Material meshMaterial = new Material(Shader.Find(shaderName));      //Material for main mesh 

            Material edgeFallMaterial = new Material(Shader.Find(shaderName));  //Material for edge fall (saved in sub-mesh)
            edgeFallMaterial.SetTexture(mainTexturePropName, edgeFallTexture);


            GetComponent<Renderer>().sharedMaterials = new Material[] { meshMaterial, edgeFallMaterial };
        }
    }
}
