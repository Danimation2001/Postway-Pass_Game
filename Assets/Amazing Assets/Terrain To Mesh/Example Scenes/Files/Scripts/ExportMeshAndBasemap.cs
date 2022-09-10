using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace AmazingAssets.TerrainToMesh.Example
{
    [RequireComponent(typeof(MeshFilter), typeof(MeshRenderer))]
    public class ExportMeshAndBasemap : MonoBehaviour
    {
        public TerrainData terrainData;

        public int vertexCountHorizontal = 100;
        public int vertexCountVertical = 100;

        public int mapsResolution = 512;
        public bool exportHoles = false;


        void Start()
        {
            if (terrainData == null)
                return;


            //1. Export mesh from terrain////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

            Mesh terrainMesh = terrainData.TerrainToMesh().ExportMesh(vertexCountHorizontal, vertexCountVertical, TerrainToMesh.Normal.CalculateFromMesh);

            GetComponent<MeshFilter>().sharedMesh = terrainMesh;




            //2. Export basemap textures////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

            Texture2D diffuseTexture = terrainData.TerrainToMesh().ExportBasemapDiffuseTexture(mapsResolution, exportHoles, false);  //alpha channel will contain holesmap
            Texture2D normalTexture = terrainData.TerrainToMesh().ExportBasemapNormalTexture(mapsResolution, false);

            Texture2D maskTexture = null;   //Built-in RP terain does not use Maskmaps
            if (TerrainToMeshUtilities.GetCurrentRenderPipeline() != TerrainToMeshUtilities.RenderPipeline.Builtin)
                maskTexture = terrainData.TerrainToMesh().ExportBasemapMaskTexture(mapsResolution, false);       //contains metallic(R), occlusion(G) and smoothness(A)



            string shaderName = TerrainToMeshConstants.shaderUnityDefault; //Default shader based on used render pipeline


            string mainTexturePropName = TerrainToMeshConstants.materailPropTextureMainTex;
            string bumpMapPropName = TerrainToMeshConstants.materailPropTextureBumpMap;
            string metallicSmoothnessPropName = TerrainToMeshConstants.materailPropTextureMetallicSmoothnessMap;




            //3. Create material and assign exported basemaps/////////////////////////////////////////////////////////////////////////////////////////////////

            Material material = new Material(Shader.Find(shaderName));

            InitializeMaterial(material);


            material.SetTexture(mainTexturePropName, diffuseTexture);

            if (normalTexture != null)
            {
                material.SetTexture(bumpMapPropName, normalTexture);
                material.EnableKeyword("_NORMALMAP");
            }

            if (maskTexture != null)
            {
                material.SetTexture(metallicSmoothnessPropName, maskTexture);
                material.EnableKeyword("_METALLICGLOSSMAP");
            }


            if(exportHoles)
            {
                SetupAlphaTest(material);
            }


            GetComponent<Renderer>().sharedMaterial = material;
        }

        void InitializeMaterial(Material material)
        {
            if (TerrainToMeshUtilities.GetCurrentRenderPipeline() == TerrainToMeshUtilities.RenderPipeline.HighDefinition)
            {
                if (material.HasProperty("_DistortionSrcBlend"))
                    material.SetFloat("_DistortionSrcBlend", 1);
                if (material.HasProperty("_DistortionDstBlend"))
                    material.SetFloat("_DistortionDstBlend", 1);
                if (material.HasProperty("_DistortionBlurSrcBlend"))
                    material.SetFloat("_DistortionBlurSrcBlend", 1);
                if (material.HasProperty("_DistortionBlurDstBlend"))
                    material.SetFloat("_DistortionBlurDstBlend", 1);

                if (material.HasProperty("_StencilWriteMask"))
                    material.SetFloat("_StencilWriteMask", 6);
                if (material.HasProperty("_StencilRefGBuffer"))
                    material.SetFloat("_StencilRefGBuffer", 10);
                if (material.HasProperty("_StencilWriteMaskGBuffer"))
                    material.SetFloat("_StencilWriteMaskGBuffer", 14);
                if (material.HasProperty("_StencilRefDepth"))
                    material.SetFloat("_StencilRefDepth", 8);

                if (material.HasProperty("_StencilRefMV"))
                    material.SetFloat("_StencilRefMV", 40);
                if (material.HasProperty("_StencilWriteMaskMV"))
                    material.SetFloat("_StencilWriteMaskMV", 40);

                if (material.HasProperty("_ZTestDepthEqualForOpaque"))
                    material.SetFloat("_ZTestDepthEqualForOpaque", 3);
                if (material.HasProperty("_ZTestModeDistortion"))
                    material.SetFloat("_ZTestModeDistortion", 4);

                material.EnableKeyword("_NORMALMAP_TANGENT_SPACE");
            }
        }

        void SetupAlphaTest(Material material)
        {
            material.EnableKeyword("_ALPHATEST_ON");

            material.renderQueue = (int)UnityEngine.Rendering.RenderQueue.AlphaTest;

            switch (TerrainToMeshUtilities.GetCurrentRenderPipeline())
            {
                case TerrainToMeshUtilities.RenderPipeline.Builtin:
                    {
                        if (material.HasProperty("_Mode"))
                            material.SetFloat("_Mode", 1);
                    }
                    break;

                case TerrainToMeshUtilities.RenderPipeline.Universal:
                    {
                        if (material.HasProperty("_AlphaClip"))
                            material.SetFloat("_AlphaClip", 1);
                    }
                    break;

                case TerrainToMeshUtilities.RenderPipeline.HighDefinition:
                    {
                        if (material.IsKeywordEnabled("_DISABLE_SSR_TRANSPARENT") == false)
                            material.EnableKeyword("_DISABLE_SSR_TRANSPARENT");

                        if (material.HasProperty("_AlphaCutoffEnable"))
                            material.SetFloat("_AlphaCutoffEnable", 1);

                        if (material.HasProperty("_ZTestGBuffer"))
                            material.SetFloat("_ZTestGBuffer", 3);
                    }
                    break;

                default:
                    break;
            }
        }
    }
}