using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace AmazingAssets.TerrainToMesh.Example
{
    [RequireComponent(typeof(MeshFilter), typeof(MeshRenderer))]
    public class ExportMeshAndSplatmap : MonoBehaviour
    {
        public TerrainData terrainData;

        public int vertexCountHorizontal = 100;
        public int vertexCountVertical = 100;

        public bool terrainHasHoles = false;
        public bool createFallbackTextures;

        void Start()
        {
            if (terrainData == null)
                return;


            //1. Export mesh with edge fall/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

            Mesh terrainMesh = terrainData.TerrainToMesh().ExportMesh(vertexCountHorizontal, vertexCountVertical, TerrainToMesh.Normal.CalculateFromMesh);

            GetComponent<MeshFilter>().sharedMesh = terrainMesh;




            //2. Export Splatmap material from terrain/////////////////////////////////////////////////////////////////////////////////////////////////////////////////

            Material splatmapMaterial = terrainData.TerrainToMesh().ExportSplatmapMaterial(terrainHasHoles);

            GetComponent<Renderer>().sharedMaterial = splatmapMaterial;




            //3. Fallback for Splatmap material

            if (createFallbackTextures)
            {
                Texture2D fallbackDiffuse = terrainData.TerrainToMesh().ExportBasemapDiffuseTexture(1024, terrainHasHoles, false);
                Texture2D fallbackNormal = terrainData.TerrainToMesh().ExportBasemapNormalTexture(1024, false);

                splatmapMaterial.SetTexture(TerrainToMeshConstants.materailPropTextureMainTex, fallbackDiffuse);
                splatmapMaterial.SetTexture(TerrainToMeshConstants.materailPropTextureBumpMap, fallbackNormal);
            }
        }
    }
}