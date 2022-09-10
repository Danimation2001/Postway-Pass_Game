Shader "Amazing Assets/Terrain To Mesh/Splatmap"
{
    Properties
    {


//[HideInInspector][CurvedWorldBendSettings] _CurvedWorldBendSettings("0|1|1", Vector) = (0, 0, 0, 0)


//Terrain To Mesh Properties/////////////////////////////////////////////////////////////////////////////////////////////////////////
[HideInInspector] [TerrainToMeshLayerCounter] _T2M_Layer_Count ("Layer Count", float) = 0		

[Space]
[HideInInspector] [NoScaleOffset] _T2M_SplatMap_0 ("Splat Map #10 (RGBA)", 2D) = "black" {}

[HideInInspector] _T2M_Layer_0_ColorTint ("Color Tint", Color) = (1, 1, 1, 1)
[HideInInspector] [NoScaleOffset] _T2M_Layer_0_Diffuse ("Paint Map 1 (R)", 2D) = "white" {}
[HideInInspector] _T2M_Layer_0_NormalScale("Strength", float) = 1
[HideInInspector] [NoScaleOffset] _T2M_Layer_0_NormalMap("Bump", 2D) = "bump" {}
[HideInInspector] [NoScaleOffset] _T2M_Layer_0_Mask ("Mask", 2D) = "white" {}
[HideInInspector] _T2M_Layer_0_uvScaleOffset("UV Scale", Vector) = (1, 1, 0, 0)
[HideInInspector] _T2M_Layer_0_MapsUsage("Maps Usage", Vector) = (0, 0, 0, 0)
[HideInInspector] _T2M_Layer_0_MetallicOcclusionSmoothness("Metallic (R), Occlusion (G), Smoothness(A)", Vector) = (0, 1, 0, 0)
[HideInInspector] _T2M_Layer_0_SmoothnessFromDiffuseAlpha("", float) = 0
[HideInInspector] _T2M_Layer_0_MaskMapRemapMin("Maskmap Remap Min", Vector) = (0, 0, 0, 0)
[HideInInspector] _T2M_Layer_0_MaskMapRemapMax("Maskmap Remap Max", Vector) = (1, 1, 1, 1)

[HideInInspector] _T2M_Layer_1_ColorTint ("Color Tint", Color) = (1, 1, 1, 1)
[HideInInspector] [NoScaleOffset] _T2M_Layer_1_Diffuse ("Paint Map 1 (R)", 2D) = "white" {}
[HideInInspector] _T2M_Layer_1_NormalScale("Strength", float) = 1
[HideInInspector] [NoScaleOffset] _T2M_Layer_1_NormalMap("Bump", 2D) = "bump" {}
[HideInInspector] [NoScaleOffset] _T2M_Layer_1_Mask ("Mask", 2D) = "white" {}
[HideInInspector] _T2M_Layer_1_uvScaleOffset("UV Scale", Vector) = (1, 1, 0, 0)
[HideInInspector] _T2M_Layer_1_MapsUsage("Maps Usage", Vector) = (0, 0, 0, 0)
[HideInInspector] _T2M_Layer_1_MetallicOcclusionSmoothness("Metallic (R), Occlusion (G), Smoothness(A)", Vector) = (0, 1, 0, 0)
[HideInInspector] _T2M_Layer_1_SmoothnessFromDiffuseAlpha("", float) = 0
[HideInInspector] _T2M_Layer_1_MaskMapRemapMin("Maskmap Remap Min", Vector) = (0, 0, 0, 0)
[HideInInspector] _T2M_Layer_1_MaskMapRemapMax("Maskmap Remap Max", Vector) = (1, 1, 1, 1)

[HideInInspector] _T2M_Layer_2_ColorTint ("Color Tint", Color) = (1, 1, 1, 1)
[HideInInspector] [NoScaleOffset] _T2M_Layer_2_Diffuse ("Paint Map 2 (G)", 2D) = "white" {}
[HideInInspector] _T2M_Layer_2_NormalScale("Strength", float) = 1
[HideInInspector] [NoScaleOffset] _T2M_Layer_2_NormalMap("Bump", 2D) = "bump" {}
[HideInInspector] [NoScaleOffset] _T2M_Layer_2_Mask ("Mask", 2D) = "white" {}
[HideInInspector] _T2M_Layer_2_uvScaleOffset("UV Scale", Vector) = (1, 1, 0, 0)
[HideInInspector] _T2M_Layer_2_MapsUsage("Maps Usage", Vector) = (0, 0, 0, 0)
[HideInInspector] _T2M_Layer_2_MetallicOcclusionSmoothness("Metallic (R), Occlusion (G), Smoothness(A)", Vector) = (0, 1, 0, 0)
[HideInInspector] _T2M_Layer_2_SmoothnessFromDiffuseAlpha("", float) = 0
[HideInInspector] _T2M_Layer_2_MaskMapRemapMin("Maskmap Remap Min", Vector) = (0, 0, 0, 0)
[HideInInspector] _T2M_Layer_2_MaskMapRemapMax("Maskmap Remap Max", Vector) = (1, 1, 1, 1)

[HideInInspector] _T2M_Layer_3_ColorTint ("Color Tint", Color) = (1, 1, 1, 1)
[HideInInspector] [NoScaleOffset] _T2M_Layer_3_Diffuse ("Paint Map 3 (B)", 2D) = "white" {}
[HideInInspector] _T2M_Layer_3_NormalScale("Strength", float) = 1
[HideInInspector] [NoScaleOffset] _T2M_Layer_3_NormalMap("Bump", 2D) = "bump" {}
[HideInInspector] [NoScaleOffset] _T2M_Layer_3_Mask ("Mask", 2D) = "white" {}
[HideInInspector] _T2M_Layer_3_uvScaleOffset("UV Scale", Vector) = (1, 1, 0, 0)
[HideInInspector] _T2M_Layer_3_MapsUsage("Maps Usage", Vector) = (0, 0, 0, 0)
[HideInInspector] _T2M_Layer_3_MetallicOcclusionSmoothness("Metallic (R), Occlusion (G), Smoothness(A)", Vector) = (0, 1, 0, 0)
[HideInInspector] _T2M_Layer_3_SmoothnessFromDiffuseAlpha("", float) = 0
[HideInInspector] _T2M_Layer_3_MaskMapRemapMin("Maskmap Remap Min", Vector) = (0, 0, 0, 0)
[HideInInspector] _T2M_Layer_3_MaskMapRemapMax("Maskmap Remap Max", Vector) = (1, 1, 1, 1)


[HideInInspector] [NoScaleOffset] _T2M_SplatMap_1 ("Splat Map #1 (RGBA)", 2D) = "black" {}

[HideInInspector] _T2M_Layer_4_ColorTint ("Color Tint", Color) = (1, 1, 1, 1)
[HideInInspector] [NoScaleOffset] _T2M_Layer_4_Diffuse ("Paint Map 4 (A)", 2D) = "white" {}
[HideInInspector] _T2M_Layer_4_NormalScale("Strength", float) = 1
[HideInInspector] [NoScaleOffset] _T2M_Layer_4_NormalMap("Bump", 2D) = "bump" {}
[HideInInspector] [NoScaleOffset] _T2M_Layer_4_Mask ("Mask", 2D) = "white" {}
[HideInInspector] _T2M_Layer_4_uvScaleOffset("UV Scale", Vector) = (1, 1, 0, 0)
[HideInInspector] _T2M_Layer_4_MapsUsage("Maps Usage", Vector) = (0, 0, 0, 0)
[HideInInspector] _T2M_Layer_4_MetallicOcclusionSmoothness("Metallic (R), Occlusion (G), Smoothness(A)", Vector) = (0, 1, 0, 0)
[HideInInspector] _T2M_Layer_4_SmoothnessFromDiffuseAlpha("", float) = 0
[HideInInspector] _T2M_Layer_4_MaskMapRemapMin("Maskmap Remap Min", Vector) = (0, 0, 0, 0)
[HideInInspector] _T2M_Layer_4_MaskMapRemapMax("Maskmap Remap Max", Vector) = (1, 1, 1, 1)

[HideInInspector] _T2M_Layer_5_ColorTint ("Color Tint", Color) = (1, 1, 1, 1)
[HideInInspector] [NoScaleOffset] _T2M_Layer_5_Diffuse ("Paint Map 5 (R)", 2D) = "white" {}
[HideInInspector] _T2M_Layer_5_NormalScale("Strength", float) = 1
[HideInInspector] [NoScaleOffset] _T2M_Layer_5_NormalMap("Bump", 2D) = "bump" {}
[HideInInspector] [NoScaleOffset] _T2M_Layer_5_Mask ("Mask", 2D) = "white" {}
[HideInInspector] _T2M_Layer_5_uvScaleOffset("UV Scale", Vector) = (1, 1, 0, 0)
[HideInInspector] _T2M_Layer_5_MapsUsage("Maps Usage", Vector) = (0, 0, 0, 0)
[HideInInspector] _T2M_Layer_5_MetallicOcclusionSmoothness("Metallic (R), Occlusion (G), Smoothness(A)", Vector) = (0, 1, 0, 0)
[HideInInspector] _T2M_Layer_5_SmoothnessFromDiffuseAlpha("", float) = 0
[HideInInspector] _T2M_Layer_5_MaskMapRemapMin("Maskmap Remap Min", Vector) = (0, 0, 0, 0)
[HideInInspector] _T2M_Layer_5_MaskMapRemapMax("Maskmap Remap Max", Vector) = (1, 1, 1, 1)

[HideInInspector] _T2M_Layer_6_ColorTint ("Color Tint", Color) = (1, 1, 1, 1)
[HideInInspector] [NoScaleOffset] _T2M_Layer_6_Diffuse ("Paint Map 6 (G)", 2D) = "white" {}
[HideInInspector] _T2M_Layer_6_NormalScale("Strength", float) = 1
[HideInInspector] [NoScaleOffset] _T2M_Layer_6_NormalMap("Bump", 2D) = "bump" {}
[HideInInspector] [NoScaleOffset] _T2M_Layer_6_Mask ("Mask", 2D) = "white" {}
[HideInInspector] _T2M_Layer_6_uvScaleOffset("UV Scale", Vector) = (1, 1, 0, 0)
[HideInInspector] _T2M_Layer_6_MapsUsage("Maps Usage", Vector) = (0, 0, 0, 0)
[HideInInspector] _T2M_Layer_6_MetallicOcclusionSmoothness("Metallic (R), Occlusion (G), Smoothness(A)", Vector) = (0, 1, 0, 0)
[HideInInspector] _T2M_Layer_6_SmoothnessFromDiffuseAlpha("", float) = 0
[HideInInspector] _T2M_Layer_6_MaskMapRemapMin("Maskmap Remap Min", Vector) = (0, 0, 0, 0)
[HideInInspector] _T2M_Layer_6_MaskMapRemapMax("Maskmap Remap Max", Vector) = (1, 1, 1, 1)

[HideInInspector] _T2M_Layer_7_ColorTint ("Color Tint", Color) = (1, 1, 1, 1)
[HideInInspector] [NoScaleOffset] _T2M_Layer_7_Diffuse ("Paint Map 7 (B)", 2D) = "white" {}
[HideInInspector] _T2M_Layer_7_NormalScale("Strength", float) = 1
[HideInInspector] [NoScaleOffset] _T2M_Layer_7_NormalMap("Bump", 2D) = "bump" {}
[HideInInspector] [NoScaleOffset] _T2M_Layer_7_Mask ("Mask", 2D) = "white" {}
[HideInInspector] _T2M_Layer_7_uvScaleOffset("UV Scale", Vector) = (1, 1, 0, 0)
[HideInInspector] _T2M_Layer_7_MapsUsage("Maps Usage", Vector) = (0, 0, 0, 0)
[HideInInspector] _T2M_Layer_7_MetallicOcclusionSmoothness("Metallic (R), Occlusion (G), Smoothness(A)", Vector) = (0, 1, 0, 0)
[HideInInspector] _T2M_Layer_7_SmoothnessFromDiffuseAlpha("", float) = 0
[HideInInspector] _T2M_Layer_7_MaskMapRemapMin("Maskmap Remap Min", Vector) = (0, 0, 0, 0)
[HideInInspector] _T2M_Layer_7_MaskMapRemapMax("Maskmap Remap Max", Vector) = (1, 1, 1, 1)


[HideInInspector] [NoScaleOffset] _T2M_SplatMap_2 ("Splat Map #2 (RGBA)", 2D) = "black" {}

[HideInInspector] _T2M_Layer_8_ColorTint ("Color Tint", Color) = (1, 1, 1, 1)
[HideInInspector] [NoScaleOffset] _T2M_Layer_8_Diffuse ("Paint Map 8 (A)", 2D) = "white" {}
[HideInInspector] _T2M_Layer_8_NormalScale("Strength", float) = 1
[HideInInspector] [NoScaleOffset] _T2M_Layer_8_NormalMap("Bump", 2D) = "bump" {}
[HideInInspector] [NoScaleOffset] _T2M_Layer_8_Mask ("Mask", 2D) = "white" {}
[HideInInspector] _T2M_Layer_8_uvScaleOffset("UV Scale", Vector) = (1, 1, 0, 0)
[HideInInspector] _T2M_Layer_8_MapsUsage("Maps Usage", Vector) = (0, 0, 0, 0)
[HideInInspector] _T2M_Layer_8_MetallicOcclusionSmoothness("Metallic (R), Occlusion (G), Smoothness(A)", Vector) = (0, 1, 0, 0)
[HideInInspector] _T2M_Layer_8_SmoothnessFromDiffuseAlpha("", float) = 0
[HideInInspector] _T2M_Layer_8_MaskMapRemapMin("Maskmap Remap Min", Vector) = (0, 0, 0, 0)
[HideInInspector] _T2M_Layer_8_MaskMapRemapMax("Maskmap Remap Max", Vector) = (1, 1, 1, 1)
			
[HideInInspector] _T2M_Layer_9_ColorTint ("Color Tint", Color) = (1, 1, 1, 1)
[HideInInspector] [NoScaleOffset] _T2M_Layer_9_Diffuse ("Paint Map 9 (R)", 2D) = "white" {}
[HideInInspector] _T2M_Layer_9_NormalScale("Strength", float) = 1
[HideInInspector] [NoScaleOffset] _T2M_Layer_9_NormalMap("Bump", 2D) = "bump" {}
[HideInInspector] [NoScaleOffset] _T2M_Layer_9_Mask ("Mask", 2D) = "white" {}
[HideInInspector] _T2M_Layer_9_uvScaleOffset("UV Scale", Vector) = (1, 1, 0, 0)
[HideInInspector] _T2M_Layer_9_MapsUsage("Maps Usage", Vector) = (0, 0, 0, 0)
[HideInInspector] _T2M_Layer_9_MetallicOcclusionSmoothness("Metallic (R), Occlusion (G), Smoothness(A)", Vector) = (0, 1, 0, 0)
[HideInInspector] _T2M_Layer_9_SmoothnessFromDiffuseAlpha("", float) = 0
[HideInInspector] _T2M_Layer_9_MaskMapRemapMin("Maskmap Remap Min", Vector) = (0, 0, 0, 0)
[HideInInspector] _T2M_Layer_9_MaskMapRemapMax("Maskmap Remap Max", Vector) = (1, 1, 1, 1)

[HideInInspector] _T2M_Layer_10_ColorTint ("Color Tint", Color) = (1, 1, 1, 1)
[HideInInspector] [NoScaleOffset] _T2M_Layer_10_Diffuse ("Paint Map 10 (G)", 2D) = "white" {}
[HideInInspector] _T2M_Layer_10_NormalScale("Strength", float) = 1
[HideInInspector] [NoScaleOffset] _T2M_Layer_10_NormalMap("Bump", 2D) = "bump" {}
[HideInInspector] [NoScaleOffset] _T2M_Layer_10_Mask ("Mask", 2D) = "white" {}
[HideInInspector] _T2M_Layer_10_uvScaleOffset("UV Scale", Vector) = (1, 1, 0, 0)
[HideInInspector] _T2M_Layer_10_MapsUsage("Maps Usage", Vector) = (0, 0, 0, 0)
[HideInInspector] _T2M_Layer_10_MetallicOcclusionSmoothness("Metallic (R), Occlusion (G), Smoothness(A)", Vector) = (0, 1, 0, 0)
[HideInInspector] _T2M_Layer_10_SmoothnessFromDiffuseAlpha("", float) = 0
[HideInInspector] _T2M_Layer_10_MaskMapRemapMin("Maskmap Remap Min", Vector) = (0, 0, 0, 0)
[HideInInspector] _T2M_Layer_10_MaskMapRemapMax("Maskmap Remap Max", Vector) = (1, 1, 1, 1)

[HideInInspector] _T2M_Layer_11_ColorTint ("Color Tint", Color) = (1, 1, 1, 1)
[HideInInspector] [NoScaleOffset] _T2M_Layer_11_Diffuse ("Paint Map 11 (B)", 2D) = "white" {}
[HideInInspector] _T2M_Layer_11_NormalScale("Strength", float) = 1
[HideInInspector] [NoScaleOffset] _T2M_Layer_11_NormalMap("Bump", 2D) = "bump" {}
[HideInInspector] [NoScaleOffset] _T2M_Layer_11_Mask ("Mask", 2D) = "white" {}
[HideInInspector] _T2M_Layer_11_uvScaleOffset("UV Scale", Vector) = (1, 1, 0, 0)
[HideInInspector] _T2M_Layer_11_MapsUsage("Maps Usage", Vector) = (0, 0, 0, 0)
[HideInInspector] _T2M_Layer_11_MetallicOcclusionSmoothness("Metallic (R), Occlusion (G), Smoothness(A)", Vector) = (0, 1, 0, 0)
[HideInInspector] _T2M_Layer_11_SmoothnessFromDiffuseAlpha("", float) = 0
[HideInInspector] _T2M_Layer_11_MaskMapRemapMin("Maskmap Remap Min", Vector) = (0, 0, 0, 0)
[HideInInspector] _T2M_Layer_11_MaskMapRemapMax("Maskmap Remap Max", Vector) = (1, 1, 1, 1)


[HideInInspector] [NoScaleOffset] _T2M_SplatMap_3 ("Splat Map #3 (RGBA)", 2D) = "black" {}

[HideInInspector] _T2M_Layer_12_ColorTint ("Color Tint", Color) = (1, 1, 1, 1)
[HideInInspector] [NoScaleOffset] _T2M_Layer_12_Diffuse ("Paint Map 12 (A)", 2D) = "white" {}
[HideInInspector] _T2M_Layer_12_NormalScale("Strength", float) = 1
[HideInInspector] [NoScaleOffset] _T2M_Layer_12_NormalMap("Bump", 2D) = "bump" {}
[HideInInspector] [NoScaleOffset] _T2M_Layer_12_Mask ("Mask", 2D) = "white" {}
[HideInInspector] _T2M_Layer_12_uvScaleOffset("UV Scale", Vector) = (1, 1, 0, 0)
[HideInInspector] _T2M_Layer_12_MapsUsage("Maps Usage", Vector) = (0, 0, 0, 0)
[HideInInspector] _T2M_Layer_12_MetallicOcclusionSmoothness("Metallic (R), Occlusion (G), Smoothness(A)", Vector) = (0, 1, 0, 0)
[HideInInspector] _T2M_Layer_12_SmoothnessFromDiffuseAlpha("", float) = 0
[HideInInspector] _T2M_Layer_12_MaskMapRemapMin("Maskmap Remap Min", Vector) = (0, 0, 0, 0)
[HideInInspector] _T2M_Layer_12_MaskMapRemapMax("Maskmap Remap Max", Vector) = (1, 1, 1, 1)
			
[HideInInspector] _T2M_Layer_13_ColorTint ("Color Tint", Color) = (1, 1, 1, 1)
[HideInInspector] [NoScaleOffset] _T2M_Layer_13_Diffuse ("Paint Map 13 (R)", 2D) = "white" {}
[HideInInspector] _T2M_Layer_13_NormalScale("Strength", float) = 1
[HideInInspector] [NoScaleOffset] _T2M_Layer_13_NormalMap("Bump", 2D) = "bump" {}
[HideInInspector] [NoScaleOffset] _T2M_Layer_13_Mask ("Mask", 2D) = "white" {}
[HideInInspector] _T2M_Layer_13_uvScaleOffset("UV Scale", Vector) = (1, 1, 0, 0)
[HideInInspector] _T2M_Layer_13_MapsUsage("Maps Usage", Vector) = (0, 0, 0, 0)
[HideInInspector] _T2M_Layer_13_MetallicOcclusionSmoothness("Metallic (R), Occlusion (G), Smoothness(A)", Vector) = (0, 1, 0, 0)
[HideInInspector] _T2M_Layer_13_SmoothnessFromDiffuseAlpha("", float) = 0
[HideInInspector] _T2M_Layer_13_MaskMapRemapMin("Maskmap Remap Min", Vector) = (0, 0, 0, 0)
[HideInInspector] _T2M_Layer_13_MaskMapRemapMax("Maskmap Remap Max", Vector) = (1, 1, 1, 1)

[HideInInspector] _T2M_Layer_14_ColorTint ("Color Tint", Color) = (1, 1, 1, 1)
[HideInInspector] [NoScaleOffset] _T2M_Layer_14_Diffuse ("Paint Map 14 (G)", 2D) = "white" {}
[HideInInspector] _T2M_Layer_14_NormalScale("Strength", float) = 1
[HideInInspector] [NoScaleOffset] _T2M_Layer_14_NormalMap("Bump", 2D) = "bump" {}
[HideInInspector] [NoScaleOffset] _T2M_Layer_14_Mask ("Mask", 2D) = "white" {}
[HideInInspector] _T2M_Layer_14_uvScaleOffset("UV Scale", Vector) = (1, 1, 0, 0)
[HideInInspector] _T2M_Layer_14_MapsUsage("Maps Usage", Vector) = (0, 0, 0, 0)
[HideInInspector] _T2M_Layer_14_MetallicOcclusionSmoothness("Metallic (R), Occlusion (G), Smoothness(A)", Vector) = (0, 1, 0, 0)
[HideInInspector] _T2M_Layer_14_SmoothnessFromDiffuseAlpha("", float) = 0
[HideInInspector] _T2M_Layer_14_MaskMapRemapMin("Maskmap Remap Min", Vector) = (0, 0, 0, 0)
[HideInInspector] _T2M_Layer_14_MaskMapRemapMax("Maskmap Remap Max", Vector) = (1, 1, 1, 1)

[HideInInspector] _T2M_Layer_15_ColorTint ("Color Tint", Color) = (1, 1, 1, 1)
[HideInInspector] [NoScaleOffset] _T2M_Layer_15_Diffuse ("Paint Map 15 (B)", 2D) = "white" {}
[HideInInspector] _T2M_Layer_15_NormalScale("Strength", float) = 1
[HideInInspector] [NoScaleOffset] _T2M_Layer_15_NormalMap("Bump", 2D) = "bump" {}
[HideInInspector] [NoScaleOffset] _T2M_Layer_15_Mask ("Mask", 2D) = "white" {}
[HideInInspector] _T2M_Layer_15_uvScaleOffset("UV Scale", Vector) = (1, 1, 0, 0)
[HideInInspector] _T2M_Layer_15_MapsUsage("Maps Usage", Vector) = (0, 0, 0, 0)
[HideInInspector] _T2M_Layer_15_MetallicOcclusionSmoothness("Metallic (R), Occlusion (G), Smoothness(A)", Vector) = (0, 1, 0, 0)
[HideInInspector] _T2M_Layer_15_SmoothnessFromDiffuseAlpha("", float) = 0
[HideInInspector] _T2M_Layer_15_MaskMapRemapMin("Maskmap Remap Min", Vector) = (0, 0, 0, 0)
[HideInInspector] _T2M_Layer_15_MaskMapRemapMax("Maskmap Remap Max", Vector) = (1, 1, 1, 1)


//Texture 2D Array
[HideInInspector] [NoScaleOffset] _T2M_SplatMaps2DArray("SplatMaps 2D Array", 2DArray) = "black" {}
[HideInInspector] [NoScaleOffset] _T2M_DiffuseMaps2DArray("DiffuseMaps 2D Array", 2DArray) = "white" {}
[HideInInspector] [NoScaleOffset] _T2M_NormalMaps2DArray("NormalMaps 2D Array", 2DArray) = "bump" {}
[HideInInspector] [NoScaleOffset] _T2M_MaskMaps2DArray("MaskMaps 2D Array", 2DArray) = "white" {}	 		 
		 
//Holesmap
[HideInInspector] [NoScaleOffset] _T2M_HolesMap ("Holes Map", 2D) = "white" {}

//Fallback use only
[HideInInspector] _Color("Color", Color) = (1, 1, 1, 1)								//Not used
[HideInInspector] [NoScaleOffset] _BaseMap("Fallback Diffuse", 2D) = "white" {}		
[HideInInspector] [NoScaleOffset] _BumpMap("Fallback Normal", 2D) = "bump" {}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


        [HideInInspector]_QueueOffset("_QueueOffset", Float) = 0
        [HideInInspector]_QueueControl("_QueueControl", Float) = -1
        [HideInInspector][NoScaleOffset]unity_Lightmaps("unity_Lightmaps", 2DArray) = "" {}
        [HideInInspector][NoScaleOffset]unity_LightmapsInd("unity_LightmapsInd", 2DArray) = "" {}
        [HideInInspector][NoScaleOffset]unity_ShadowMasks("unity_ShadowMasks", 2DArray) = "" {}
    }
    SubShader
    {
        Tags
        {
            "RenderPipeline"="UniversalPipeline"
            "RenderType"="Opaque"
            "UniversalMaterialType" = "Lit"
            "Queue"="Geometry"
            "ShaderGraphShader"="true"
            "ShaderGraphTargetId"="UniversalLitSubTarget"
        }
        Pass
        {
            Name "Universal Forward"
            Tags
            {
                "LightMode" = "UniversalForward"
            }
        
        // Render State
        Cull Back
        Blend One Zero
        ZTest LEqual
        ZWrite On
        
        // Debug
        // <None>
        
        // --------------------------------------------------
        // Pass
        
        HLSLPROGRAM
        
        // Pragmas
        #pragma target 4.5
        #pragma exclude_renderers gles gles3 glcore
        #pragma multi_compile_instancing
        #pragma multi_compile_fog
        #pragma instancing_options renderinglayer
        #pragma multi_compile _ DOTS_INSTANCING_ON
        #pragma vertex vert
        #pragma fragment frag
        
        // Keywords
        #pragma multi_compile_fragment _ _SCREEN_SPACE_OCCLUSION
        #pragma multi_compile _ LIGHTMAP_ON
        #pragma multi_compile _ DYNAMICLIGHTMAP_ON
        #pragma multi_compile _ DIRLIGHTMAP_COMBINED
        #pragma multi_compile _ _MAIN_LIGHT_SHADOWS _MAIN_LIGHT_SHADOWS_CASCADE _MAIN_LIGHT_SHADOWS_SCREEN
        #pragma multi_compile _ _ADDITIONAL_LIGHTS_VERTEX _ADDITIONAL_LIGHTS
        #pragma multi_compile_fragment _ _ADDITIONAL_LIGHT_SHADOWS
        #pragma multi_compile_fragment _ _REFLECTION_PROBE_BLENDING
        #pragma multi_compile_fragment _ _REFLECTION_PROBE_BOX_PROJECTION
        #pragma multi_compile_fragment _ _SHADOWS_SOFT
        #pragma multi_compile _ LIGHTMAP_SHADOW_MIXING
        #pragma multi_compile _ SHADOWS_SHADOWMASK
        #pragma multi_compile_fragment _ _DBUFFER_MRT1 _DBUFFER_MRT2 _DBUFFER_MRT3
        #pragma multi_compile_fragment _ _LIGHT_LAYERS
        #pragma multi_compile_fragment _ DEBUG_DISPLAY
        #pragma multi_compile_fragment _ _LIGHT_COOKIES
        #pragma multi_compile _ _CLUSTERED_RENDERING
        // GraphKeywords: <None>
        
        // Defines
        
        #define _NORMALMAP 1
        #define _NORMAL_DROPOFF_TS 1
        #define ATTRIBUTES_NEED_NORMAL
        #define ATTRIBUTES_NEED_TANGENT
        #define ATTRIBUTES_NEED_TEXCOORD0
        #define ATTRIBUTES_NEED_TEXCOORD1
        #define ATTRIBUTES_NEED_TEXCOORD2
        #define VARYINGS_NEED_POSITION_WS
        #define VARYINGS_NEED_NORMAL_WS
        #define VARYINGS_NEED_TANGENT_WS
        #define VARYINGS_NEED_TEXCOORD0
        #define VARYINGS_NEED_FOG_AND_VERTEX_LIGHT
        #define VARYINGS_NEED_SHADOW_COORD
        #define FEATURES_GRAPH_VERTEX
        /* WARNING: $splice Could not find named fragment 'PassInstancing' */
        #define SHADERPASS SHADERPASS_FORWARD
        #define _FOG_FRAGMENT 1
        /* WARNING: $splice Could not find named fragment 'DotsInstancingVars' */
        
        
        // custom interpolator pre-include
        /* WARNING: $splice Could not find named fragment 'sgci_CustomInterpolatorPreInclude' */
        
        // Includes
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Shadows.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/DBuffer.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
        
        // --------------------------------------------------
        // Structs and Packing
        
        // custom interpolators pre packing
        /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPrePacking' */
        
        struct Attributes
        {
             float3 positionOS : POSITION;
             float3 normalOS : NORMAL;
             float4 tangentOS : TANGENT;
             float4 uv0 : TEXCOORD0;
             float4 uv1 : TEXCOORD1;
             float4 uv2 : TEXCOORD2;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : INSTANCEID_SEMANTIC;
            #endif
        };
        struct Varyings
        {
             float4 positionCS : SV_POSITION;
             float3 positionWS;
             float3 normalWS;
             float4 tangentWS;
             float4 texCoord0;
            #if defined(LIGHTMAP_ON)
             float2 staticLightmapUV;
            #endif
            #if defined(DYNAMICLIGHTMAP_ON)
             float2 dynamicLightmapUV;
            #endif
            #if !defined(LIGHTMAP_ON)
             float3 sh;
            #endif
             float4 fogFactorAndVertexLight;
            #if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
             float4 shadowCoord;
            #endif
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
        };
        struct SurfaceDescriptionInputs
        {
             float3 TangentSpaceNormal;
             float4 uv0;
        };
        struct VertexDescriptionInputs
        {
             float3 ObjectSpaceNormal;
             float3 ObjectSpaceTangent;
             float3 ObjectSpacePosition;
        };
        struct PackedVaryings
        {
             float4 positionCS : SV_POSITION;
             float3 interp0 : INTERP0;
             float3 interp1 : INTERP1;
             float4 interp2 : INTERP2;
             float4 interp3 : INTERP3;
             float2 interp4 : INTERP4;
             float2 interp5 : INTERP5;
             float3 interp6 : INTERP6;
             float4 interp7 : INTERP7;
             float4 interp8 : INTERP8;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
        };
        
        PackedVaryings PackVaryings (Varyings input)
        {
            PackedVaryings output;
            ZERO_INITIALIZE(PackedVaryings, output);
            output.positionCS = input.positionCS;
            output.interp0.xyz =  input.positionWS;
            output.interp1.xyz =  input.normalWS;
            output.interp2.xyzw =  input.tangentWS;
            output.interp3.xyzw =  input.texCoord0;
            #if defined(LIGHTMAP_ON)
            output.interp4.xy =  input.staticLightmapUV;
            #endif
            #if defined(DYNAMICLIGHTMAP_ON)
            output.interp5.xy =  input.dynamicLightmapUV;
            #endif
            #if !defined(LIGHTMAP_ON)
            output.interp6.xyz =  input.sh;
            #endif
            output.interp7.xyzw =  input.fogFactorAndVertexLight;
            #if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
            output.interp8.xyzw =  input.shadowCoord;
            #endif
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        
        Varyings UnpackVaryings (PackedVaryings input)
        {
            Varyings output;
            output.positionCS = input.positionCS;
            output.positionWS = input.interp0.xyz;
            output.normalWS = input.interp1.xyz;
            output.tangentWS = input.interp2.xyzw;
            output.texCoord0 = input.interp3.xyzw;
            #if defined(LIGHTMAP_ON)
            output.staticLightmapUV = input.interp4.xy;
            #endif
            #if defined(DYNAMICLIGHTMAP_ON)
            output.dynamicLightmapUV = input.interp5.xy;
            #endif
            #if !defined(LIGHTMAP_ON)
            output.sh = input.interp6.xyz;
            #endif
            output.fogFactorAndVertexLight = input.interp7.xyzw;
            #if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
            output.shadowCoord = input.interp8.xyzw;
            #endif
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        
        
        // --------------------------------------------------
        // Graph
        
        // Graph Properties
        CBUFFER_START(UnityPerMaterial)
        CBUFFER_END
        
        // Object and Global properties
        
        // Graph Includes


//Curved World
//#define CURVEDWORLD_BEND_TYPE_CLASSICRUNNER_X_POSITIVE
//#define CURVEDWORLD_BEND_ID_1
//#pragma shader_feature_local CURVEDWORLD_DISABLED_ON
//#pragma shader_feature_local CURVEDWORLD_NORMAL_TRANSFORMATION_ON
//#include "Assets/Amazing Assets/Curved World/Shaders/Core/CurvedWorldTransform.cginc"


//Terrain To Mesh Keywords//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma shader_feature_local _ _T2M_TEXTURE_SAMPLE_TYPE_ARRAY

#pragma shader_feature_local _ _T2M_LAYER_COUNT_3 _T2M_LAYER_COUNT_4 _T2M_LAYER_COUNT_5 _T2M_LAYER_COUNT_6 _T2M_LAYER_COUNT_7 _T2M_LAYER_COUNT_8 _T2M_LAYER_COUNT_9 _T2M_LAYER_COUNT_10 _T2M_LAYER_COUNT_11 _T2M_LAYER_COUNT_12 _T2M_LAYER_COUNT_13 _T2M_LAYER_COUNT_14 _T2M_LAYER_COUNT_15 _T2M_LAYER_COUNT_16
		
#pragma shader_feature_local _T2M_LAYER_0_NORMAL
#pragma shader_feature_local _T2M_LAYER_1_NORMAL
#pragma shader_feature_local _T2M_LAYER_2_NORMAL
#pragma shader_feature_local _T2M_LAYER_3_NORMAL
#pragma shader_feature_local _T2M_LAYER_4_NORMAL
#pragma shader_feature_local _T2M_LAYER_5_NORMAL
#pragma shader_feature_local _T2M_LAYER_6_NORMAL
#pragma shader_feature_local _T2M_LAYER_7_NORMAL
#pragma shader_feature_local _T2M_LAYER_8_NORMAL
#pragma shader_feature_local _T2M_LAYER_9_NORMAL
#pragma shader_feature_local _T2M_LAYER_10_NORMAL
#pragma shader_feature_local _T2M_LAYER_11_NORMAL
#pragma shader_feature_local _T2M_LAYER_12_NORMAL
#pragma shader_feature_local _T2M_LAYER_13_NORMAL
#pragma shader_feature_local _T2M_LAYER_14_NORMAL
#pragma shader_feature_local _T2M_LAYER_15_NORMAL

#pragma shader_feature_local _T2M_LAYER_0_MASK
#pragma shader_feature_local _T2M_LAYER_1_MASK
#pragma shader_feature_local _T2M_LAYER_2_MASK
#pragma shader_feature_local _T2M_LAYER_3_MASK
#pragma shader_feature_local _T2M_LAYER_4_MASK
#pragma shader_feature_local _T2M_LAYER_5_MASK
#pragma shader_feature_local _T2M_LAYER_6_MASK
#pragma shader_feature_local _T2M_LAYER_7_MASK
#pragma shader_feature_local _T2M_LAYER_8_MASK
#pragma shader_feature_local _T2M_LAYER_9_MASK
#pragma shader_feature_local _T2M_LAYER_10_MASK
#pragma shader_feature_local _T2M_LAYER_11_MASK
#pragma shader_feature_local _T2M_LAYER_12_MASK
#pragma shader_feature_local _T2M_LAYER_13_MASK
#pragma shader_feature_local _T2M_LAYER_14_MASK
#pragma shader_feature_local _T2M_LAYER_15_MASK

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


#define TERRAIN_TO_MESH_NEED_NORMAL
#define TERRAIN_TO_MESH_NEED_METALLIC_SMOOTHNESS_OCCLUSION


#include "Splatmap.cginc"
        
        // -- Property used by ScenePickingPass
        #ifdef SCENEPICKINGPASS
        float4 _SelectionID;
        #endif
        
        // -- Properties used by SceneSelectionPass
        #ifdef SCENESELECTIONPASS
        int _ObjectId;
        int _PassValue;
        #endif
        
        // Graph Functions
        // GraphFunctions: <None>
        
        // Custom interpolators pre vertex
        /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPreVertex' */
        
        // Graph Vertex
        struct VertexDescription
        {
            float3 Position;
            float3 Normal;
            float3 Tangent;
        };
        
        VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
        {
            VertexDescription description = (VertexDescription)0;
            float3 _SHGTerrainToMeshCurvedWorldCustomFunction_1d12c500e42ebf8b903bf40b7a0a5e2c_vertex_0;
            float3 _SHGTerrainToMeshCurvedWorldCustomFunction_1d12c500e42ebf8b903bf40b7a0a5e2c_normal_4;
            SHG_TerrainToMeshCurvedWorld_float(IN.ObjectSpacePosition, IN.ObjectSpaceNormal, (float4(IN.ObjectSpaceTangent, 1.0)), _SHGTerrainToMeshCurvedWorldCustomFunction_1d12c500e42ebf8b903bf40b7a0a5e2c_vertex_0, _SHGTerrainToMeshCurvedWorldCustomFunction_1d12c500e42ebf8b903bf40b7a0a5e2c_normal_4);
            description.Position = _SHGTerrainToMeshCurvedWorldCustomFunction_1d12c500e42ebf8b903bf40b7a0a5e2c_vertex_0;
            description.Normal = _SHGTerrainToMeshCurvedWorldCustomFunction_1d12c500e42ebf8b903bf40b7a0a5e2c_normal_4;
            description.Tangent = IN.ObjectSpaceTangent;
            return description;
        }
        
        // Custom interpolators, pre surface
        #ifdef FEATURES_GRAPH_VERTEX
        Varyings CustomInterpolatorPassThroughFunc(inout Varyings output, VertexDescription input)
        {
        return output;
        }
        #define CUSTOMINTERPOLATOR_VARYPASSTHROUGH_FUNC
        #endif
        
        // Graph Pixel
        struct SurfaceDescription
        {
            float3 BaseColor;
            float3 NormalTS;
            float3 Emission;
            float Metallic;
            float Smoothness;
            float Occlusion;
        };
        
        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            float4 _UV_d56c6fdf7ac2828fa944da2372119006_Out_0 = IN.uv0;
            float3 _SHGTerrainToMeshCalculateLayersBlendCustomFunction_24112ec2b2aa8c829e8ab4bb7ea28f60_albedo_1;
            float _SHGTerrainToMeshCalculateLayersBlendCustomFunction_24112ec2b2aa8c829e8ab4bb7ea28f60_alpha_2;
            float3 _SHGTerrainToMeshCalculateLayersBlendCustomFunction_24112ec2b2aa8c829e8ab4bb7ea28f60_normal_3;
            float _SHGTerrainToMeshCalculateLayersBlendCustomFunction_24112ec2b2aa8c829e8ab4bb7ea28f60_metallic_4;
            float _SHGTerrainToMeshCalculateLayersBlendCustomFunction_24112ec2b2aa8c829e8ab4bb7ea28f60_smoothness_5;
            float _SHGTerrainToMeshCalculateLayersBlendCustomFunction_24112ec2b2aa8c829e8ab4bb7ea28f60_occlusion_6;
            SHG_TerrainToMeshCalculateLayersBlend_float(_UV_d56c6fdf7ac2828fa944da2372119006_Out_0, _SHGTerrainToMeshCalculateLayersBlendCustomFunction_24112ec2b2aa8c829e8ab4bb7ea28f60_albedo_1, _SHGTerrainToMeshCalculateLayersBlendCustomFunction_24112ec2b2aa8c829e8ab4bb7ea28f60_alpha_2, _SHGTerrainToMeshCalculateLayersBlendCustomFunction_24112ec2b2aa8c829e8ab4bb7ea28f60_normal_3, _SHGTerrainToMeshCalculateLayersBlendCustomFunction_24112ec2b2aa8c829e8ab4bb7ea28f60_metallic_4, _SHGTerrainToMeshCalculateLayersBlendCustomFunction_24112ec2b2aa8c829e8ab4bb7ea28f60_smoothness_5, _SHGTerrainToMeshCalculateLayersBlendCustomFunction_24112ec2b2aa8c829e8ab4bb7ea28f60_occlusion_6);
            surface.BaseColor = _SHGTerrainToMeshCalculateLayersBlendCustomFunction_24112ec2b2aa8c829e8ab4bb7ea28f60_albedo_1;
            surface.NormalTS = _SHGTerrainToMeshCalculateLayersBlendCustomFunction_24112ec2b2aa8c829e8ab4bb7ea28f60_normal_3;
            surface.Emission = float3(0, 0, 0);
            surface.Metallic = _SHGTerrainToMeshCalculateLayersBlendCustomFunction_24112ec2b2aa8c829e8ab4bb7ea28f60_metallic_4;
            surface.Smoothness = _SHGTerrainToMeshCalculateLayersBlendCustomFunction_24112ec2b2aa8c829e8ab4bb7ea28f60_smoothness_5;
            surface.Occlusion = _SHGTerrainToMeshCalculateLayersBlendCustomFunction_24112ec2b2aa8c829e8ab4bb7ea28f60_occlusion_6;
            return surface;
        }
        
        // --------------------------------------------------
        // Build Graph Inputs
        #ifdef HAVE_VFX_MODIFICATION
        #define VFX_SRP_ATTRIBUTES Attributes
        #define VFX_SRP_VARYINGS Varyings
        #define VFX_SRP_SURFACE_INPUTS SurfaceDescriptionInputs
        #endif
        VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
        {
            VertexDescriptionInputs output;
            ZERO_INITIALIZE(VertexDescriptionInputs, output);
        
            output.ObjectSpaceNormal =                          input.normalOS;
            output.ObjectSpaceTangent =                         input.tangentOS.xyz;
            output.ObjectSpacePosition =                        input.positionOS;
        
            return output;
        }
        SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
        {
            SurfaceDescriptionInputs output;
            ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
        
        #ifdef HAVE_VFX_MODIFICATION
            // FragInputs from VFX come from two places: Interpolator or CBuffer.
            /* WARNING: $splice Could not find named fragment 'VFXSetFragInputs' */
        
        #endif
        
            
        
        
        
            output.TangentSpaceNormal = float3(0.0f, 0.0f, 1.0f);
        
        
        
            #if UNITY_UV_STARTS_AT_TOP
            #else
            #endif
        
        
            output.uv0 = input.texCoord0;
        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
        #else
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        #endif
        #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        
                return output;
        }
        
        // --------------------------------------------------
        // Main
        
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/PBRForwardPass.hlsl"
        
        // --------------------------------------------------
        // Visual Effect Vertex Invocations
        #ifdef HAVE_VFX_MODIFICATION
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/VisualEffectVertex.hlsl"
        #endif
        
        ENDHLSL
        }
        Pass
        {
            Name "GBuffer"
            Tags
            {
                "LightMode" = "UniversalGBuffer"
            }
        
        // Render State
        Cull Back
        Blend One Zero
        ZTest LEqual
        ZWrite On
        
        // Debug
        // <None>
        
        // --------------------------------------------------
        // Pass
        
        HLSLPROGRAM
        
        // Pragmas
        #pragma target 4.5
        #pragma exclude_renderers gles gles3 glcore
        #pragma multi_compile_instancing
        #pragma multi_compile_fog
        #pragma instancing_options renderinglayer
        #pragma multi_compile _ DOTS_INSTANCING_ON
        #pragma vertex vert
        #pragma fragment frag
        
        // Keywords
        #pragma multi_compile _ LIGHTMAP_ON
        #pragma multi_compile _ DYNAMICLIGHTMAP_ON
        #pragma multi_compile _ DIRLIGHTMAP_COMBINED
        #pragma multi_compile _ _MAIN_LIGHT_SHADOWS _MAIN_LIGHT_SHADOWS_CASCADE _MAIN_LIGHT_SHADOWS_SCREEN
        #pragma multi_compile_fragment _ _REFLECTION_PROBE_BLENDING
        #pragma multi_compile_fragment _ _REFLECTION_PROBE_BOX_PROJECTION
        #pragma multi_compile_fragment _ _SHADOWS_SOFT
        #pragma multi_compile _ LIGHTMAP_SHADOW_MIXING
        #pragma multi_compile _ SHADOWS_SHADOWMASK
        #pragma multi_compile _ _MIXED_LIGHTING_SUBTRACTIVE
        #pragma multi_compile_fragment _ _DBUFFER_MRT1 _DBUFFER_MRT2 _DBUFFER_MRT3
        #pragma multi_compile_fragment _ _GBUFFER_NORMALS_OCT
        #pragma multi_compile_fragment _ _LIGHT_LAYERS
        #pragma multi_compile_fragment _ _RENDER_PASS_ENABLED
        #pragma multi_compile_fragment _ DEBUG_DISPLAY
        // GraphKeywords: <None>
        
        // Defines
        
        #define _NORMALMAP 1
        #define _NORMAL_DROPOFF_TS 1
        #define ATTRIBUTES_NEED_NORMAL
        #define ATTRIBUTES_NEED_TANGENT
        #define ATTRIBUTES_NEED_TEXCOORD0
        #define ATTRIBUTES_NEED_TEXCOORD1
        #define ATTRIBUTES_NEED_TEXCOORD2
        #define VARYINGS_NEED_POSITION_WS
        #define VARYINGS_NEED_NORMAL_WS
        #define VARYINGS_NEED_TANGENT_WS
        #define VARYINGS_NEED_TEXCOORD0
        #define VARYINGS_NEED_FOG_AND_VERTEX_LIGHT
        #define VARYINGS_NEED_SHADOW_COORD
        #define FEATURES_GRAPH_VERTEX
        /* WARNING: $splice Could not find named fragment 'PassInstancing' */
        #define SHADERPASS SHADERPASS_GBUFFER
        #define _FOG_FRAGMENT 1
        /* WARNING: $splice Could not find named fragment 'DotsInstancingVars' */
        
        
        // custom interpolator pre-include
        /* WARNING: $splice Could not find named fragment 'sgci_CustomInterpolatorPreInclude' */
        
        // Includes
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Shadows.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/DBuffer.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
        
        // --------------------------------------------------
        // Structs and Packing
        
        // custom interpolators pre packing
        /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPrePacking' */
        
        struct Attributes
        {
             float3 positionOS : POSITION;
             float3 normalOS : NORMAL;
             float4 tangentOS : TANGENT;
             float4 uv0 : TEXCOORD0;
             float4 uv1 : TEXCOORD1;
             float4 uv2 : TEXCOORD2;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : INSTANCEID_SEMANTIC;
            #endif
        };
        struct Varyings
        {
             float4 positionCS : SV_POSITION;
             float3 positionWS;
             float3 normalWS;
             float4 tangentWS;
             float4 texCoord0;
            #if defined(LIGHTMAP_ON)
             float2 staticLightmapUV;
            #endif
            #if defined(DYNAMICLIGHTMAP_ON)
             float2 dynamicLightmapUV;
            #endif
            #if !defined(LIGHTMAP_ON)
             float3 sh;
            #endif
             float4 fogFactorAndVertexLight;
            #if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
             float4 shadowCoord;
            #endif
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
        };
        struct SurfaceDescriptionInputs
        {
             float3 TangentSpaceNormal;
             float4 uv0;
        };
        struct VertexDescriptionInputs
        {
             float3 ObjectSpaceNormal;
             float3 ObjectSpaceTangent;
             float3 ObjectSpacePosition;
        };
        struct PackedVaryings
        {
             float4 positionCS : SV_POSITION;
             float3 interp0 : INTERP0;
             float3 interp1 : INTERP1;
             float4 interp2 : INTERP2;
             float4 interp3 : INTERP3;
             float2 interp4 : INTERP4;
             float2 interp5 : INTERP5;
             float3 interp6 : INTERP6;
             float4 interp7 : INTERP7;
             float4 interp8 : INTERP8;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
        };
        
        PackedVaryings PackVaryings (Varyings input)
        {
            PackedVaryings output;
            ZERO_INITIALIZE(PackedVaryings, output);
            output.positionCS = input.positionCS;
            output.interp0.xyz =  input.positionWS;
            output.interp1.xyz =  input.normalWS;
            output.interp2.xyzw =  input.tangentWS;
            output.interp3.xyzw =  input.texCoord0;
            #if defined(LIGHTMAP_ON)
            output.interp4.xy =  input.staticLightmapUV;
            #endif
            #if defined(DYNAMICLIGHTMAP_ON)
            output.interp5.xy =  input.dynamicLightmapUV;
            #endif
            #if !defined(LIGHTMAP_ON)
            output.interp6.xyz =  input.sh;
            #endif
            output.interp7.xyzw =  input.fogFactorAndVertexLight;
            #if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
            output.interp8.xyzw =  input.shadowCoord;
            #endif
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        
        Varyings UnpackVaryings (PackedVaryings input)
        {
            Varyings output;
            output.positionCS = input.positionCS;
            output.positionWS = input.interp0.xyz;
            output.normalWS = input.interp1.xyz;
            output.tangentWS = input.interp2.xyzw;
            output.texCoord0 = input.interp3.xyzw;
            #if defined(LIGHTMAP_ON)
            output.staticLightmapUV = input.interp4.xy;
            #endif
            #if defined(DYNAMICLIGHTMAP_ON)
            output.dynamicLightmapUV = input.interp5.xy;
            #endif
            #if !defined(LIGHTMAP_ON)
            output.sh = input.interp6.xyz;
            #endif
            output.fogFactorAndVertexLight = input.interp7.xyzw;
            #if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
            output.shadowCoord = input.interp8.xyzw;
            #endif
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        
        
        // --------------------------------------------------
        // Graph
        
        // Graph Properties
        CBUFFER_START(UnityPerMaterial)
        CBUFFER_END
        
        // Object and Global properties
        
        // Graph Includes


//Curved World
//#define CURVEDWORLD_BEND_TYPE_CLASSICRUNNER_X_POSITIVE
//#define CURVEDWORLD_BEND_ID_1
//#pragma shader_feature_local CURVEDWORLD_DISABLED_ON
//#pragma shader_feature_local CURVEDWORLD_NORMAL_TRANSFORMATION_ON
//#include "Assets/Amazing Assets/Curved World/Shaders/Core/CurvedWorldTransform.cginc"


//Terrain To Mesh Keywords//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma shader_feature_local _ _T2M_TEXTURE_SAMPLE_TYPE_ARRAY

#pragma shader_feature_local _ _T2M_LAYER_COUNT_3 _T2M_LAYER_COUNT_4 _T2M_LAYER_COUNT_5 _T2M_LAYER_COUNT_6 _T2M_LAYER_COUNT_7 _T2M_LAYER_COUNT_8 _T2M_LAYER_COUNT_9 _T2M_LAYER_COUNT_10 _T2M_LAYER_COUNT_11 _T2M_LAYER_COUNT_12 _T2M_LAYER_COUNT_13 _T2M_LAYER_COUNT_14 _T2M_LAYER_COUNT_15 _T2M_LAYER_COUNT_16
		
#pragma shader_feature_local _T2M_LAYER_0_NORMAL
#pragma shader_feature_local _T2M_LAYER_1_NORMAL
#pragma shader_feature_local _T2M_LAYER_2_NORMAL
#pragma shader_feature_local _T2M_LAYER_3_NORMAL
#pragma shader_feature_local _T2M_LAYER_4_NORMAL
#pragma shader_feature_local _T2M_LAYER_5_NORMAL
#pragma shader_feature_local _T2M_LAYER_6_NORMAL
#pragma shader_feature_local _T2M_LAYER_7_NORMAL
#pragma shader_feature_local _T2M_LAYER_8_NORMAL
#pragma shader_feature_local _T2M_LAYER_9_NORMAL
#pragma shader_feature_local _T2M_LAYER_10_NORMAL
#pragma shader_feature_local _T2M_LAYER_11_NORMAL
#pragma shader_feature_local _T2M_LAYER_12_NORMAL
#pragma shader_feature_local _T2M_LAYER_13_NORMAL
#pragma shader_feature_local _T2M_LAYER_14_NORMAL
#pragma shader_feature_local _T2M_LAYER_15_NORMAL

#pragma shader_feature_local _T2M_LAYER_0_MASK
#pragma shader_feature_local _T2M_LAYER_1_MASK
#pragma shader_feature_local _T2M_LAYER_2_MASK
#pragma shader_feature_local _T2M_LAYER_3_MASK
#pragma shader_feature_local _T2M_LAYER_4_MASK
#pragma shader_feature_local _T2M_LAYER_5_MASK
#pragma shader_feature_local _T2M_LAYER_6_MASK
#pragma shader_feature_local _T2M_LAYER_7_MASK
#pragma shader_feature_local _T2M_LAYER_8_MASK
#pragma shader_feature_local _T2M_LAYER_9_MASK
#pragma shader_feature_local _T2M_LAYER_10_MASK
#pragma shader_feature_local _T2M_LAYER_11_MASK
#pragma shader_feature_local _T2M_LAYER_12_MASK
#pragma shader_feature_local _T2M_LAYER_13_MASK
#pragma shader_feature_local _T2M_LAYER_14_MASK
#pragma shader_feature_local _T2M_LAYER_15_MASK

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


#define TERRAIN_TO_MESH_NEED_NORMAL
#define TERRAIN_TO_MESH_NEED_METALLIC_SMOOTHNESS_OCCLUSION


#include "Splatmap.cginc"
        
        // -- Property used by ScenePickingPass
        #ifdef SCENEPICKINGPASS
        float4 _SelectionID;
        #endif
        
        // -- Properties used by SceneSelectionPass
        #ifdef SCENESELECTIONPASS
        int _ObjectId;
        int _PassValue;
        #endif
        
        // Graph Functions
        // GraphFunctions: <None>
        
        // Custom interpolators pre vertex
        /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPreVertex' */
        
        // Graph Vertex
        struct VertexDescription
        {
            float3 Position;
            float3 Normal;
            float3 Tangent;
        };
        
        VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
        {
            VertexDescription description = (VertexDescription)0;
            float3 _SHGTerrainToMeshCurvedWorldCustomFunction_1d12c500e42ebf8b903bf40b7a0a5e2c_vertex_0;
            float3 _SHGTerrainToMeshCurvedWorldCustomFunction_1d12c500e42ebf8b903bf40b7a0a5e2c_normal_4;
            SHG_TerrainToMeshCurvedWorld_float(IN.ObjectSpacePosition, IN.ObjectSpaceNormal, (float4(IN.ObjectSpaceTangent, 1.0)), _SHGTerrainToMeshCurvedWorldCustomFunction_1d12c500e42ebf8b903bf40b7a0a5e2c_vertex_0, _SHGTerrainToMeshCurvedWorldCustomFunction_1d12c500e42ebf8b903bf40b7a0a5e2c_normal_4);
            description.Position = _SHGTerrainToMeshCurvedWorldCustomFunction_1d12c500e42ebf8b903bf40b7a0a5e2c_vertex_0;
            description.Normal = _SHGTerrainToMeshCurvedWorldCustomFunction_1d12c500e42ebf8b903bf40b7a0a5e2c_normal_4;
            description.Tangent = IN.ObjectSpaceTangent;
            return description;
        }
        
        // Custom interpolators, pre surface
        #ifdef FEATURES_GRAPH_VERTEX
        Varyings CustomInterpolatorPassThroughFunc(inout Varyings output, VertexDescription input)
        {
        return output;
        }
        #define CUSTOMINTERPOLATOR_VARYPASSTHROUGH_FUNC
        #endif
        
        // Graph Pixel
        struct SurfaceDescription
        {
            float3 BaseColor;
            float3 NormalTS;
            float3 Emission;
            float Metallic;
            float Smoothness;
            float Occlusion;
        };
        
        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            float4 _UV_d56c6fdf7ac2828fa944da2372119006_Out_0 = IN.uv0;
            float3 _SHGTerrainToMeshCalculateLayersBlendCustomFunction_24112ec2b2aa8c829e8ab4bb7ea28f60_albedo_1;
            float _SHGTerrainToMeshCalculateLayersBlendCustomFunction_24112ec2b2aa8c829e8ab4bb7ea28f60_alpha_2;
            float3 _SHGTerrainToMeshCalculateLayersBlendCustomFunction_24112ec2b2aa8c829e8ab4bb7ea28f60_normal_3;
            float _SHGTerrainToMeshCalculateLayersBlendCustomFunction_24112ec2b2aa8c829e8ab4bb7ea28f60_metallic_4;
            float _SHGTerrainToMeshCalculateLayersBlendCustomFunction_24112ec2b2aa8c829e8ab4bb7ea28f60_smoothness_5;
            float _SHGTerrainToMeshCalculateLayersBlendCustomFunction_24112ec2b2aa8c829e8ab4bb7ea28f60_occlusion_6;
            SHG_TerrainToMeshCalculateLayersBlend_float(_UV_d56c6fdf7ac2828fa944da2372119006_Out_0, _SHGTerrainToMeshCalculateLayersBlendCustomFunction_24112ec2b2aa8c829e8ab4bb7ea28f60_albedo_1, _SHGTerrainToMeshCalculateLayersBlendCustomFunction_24112ec2b2aa8c829e8ab4bb7ea28f60_alpha_2, _SHGTerrainToMeshCalculateLayersBlendCustomFunction_24112ec2b2aa8c829e8ab4bb7ea28f60_normal_3, _SHGTerrainToMeshCalculateLayersBlendCustomFunction_24112ec2b2aa8c829e8ab4bb7ea28f60_metallic_4, _SHGTerrainToMeshCalculateLayersBlendCustomFunction_24112ec2b2aa8c829e8ab4bb7ea28f60_smoothness_5, _SHGTerrainToMeshCalculateLayersBlendCustomFunction_24112ec2b2aa8c829e8ab4bb7ea28f60_occlusion_6);
            surface.BaseColor = _SHGTerrainToMeshCalculateLayersBlendCustomFunction_24112ec2b2aa8c829e8ab4bb7ea28f60_albedo_1;
            surface.NormalTS = _SHGTerrainToMeshCalculateLayersBlendCustomFunction_24112ec2b2aa8c829e8ab4bb7ea28f60_normal_3;
            surface.Emission = float3(0, 0, 0);
            surface.Metallic = _SHGTerrainToMeshCalculateLayersBlendCustomFunction_24112ec2b2aa8c829e8ab4bb7ea28f60_metallic_4;
            surface.Smoothness = _SHGTerrainToMeshCalculateLayersBlendCustomFunction_24112ec2b2aa8c829e8ab4bb7ea28f60_smoothness_5;
            surface.Occlusion = _SHGTerrainToMeshCalculateLayersBlendCustomFunction_24112ec2b2aa8c829e8ab4bb7ea28f60_occlusion_6;
            return surface;
        }
        
        // --------------------------------------------------
        // Build Graph Inputs
        #ifdef HAVE_VFX_MODIFICATION
        #define VFX_SRP_ATTRIBUTES Attributes
        #define VFX_SRP_VARYINGS Varyings
        #define VFX_SRP_SURFACE_INPUTS SurfaceDescriptionInputs
        #endif
        VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
        {
            VertexDescriptionInputs output;
            ZERO_INITIALIZE(VertexDescriptionInputs, output);
        
            output.ObjectSpaceNormal =                          input.normalOS;
            output.ObjectSpaceTangent =                         input.tangentOS.xyz;
            output.ObjectSpacePosition =                        input.positionOS;
        
            return output;
        }
        SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
        {
            SurfaceDescriptionInputs output;
            ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
        
        #ifdef HAVE_VFX_MODIFICATION
            // FragInputs from VFX come from two places: Interpolator or CBuffer.
            /* WARNING: $splice Could not find named fragment 'VFXSetFragInputs' */
        
        #endif
        
            
        
        
        
            output.TangentSpaceNormal = float3(0.0f, 0.0f, 1.0f);
        
        
        
            #if UNITY_UV_STARTS_AT_TOP
            #else
            #endif
        
        
            output.uv0 = input.texCoord0;
        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
        #else
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        #endif
        #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        
                return output;
        }
        
        // --------------------------------------------------
        // Main
        
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/UnityGBuffer.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/PBRGBufferPass.hlsl"
        
        // --------------------------------------------------
        // Visual Effect Vertex Invocations
        #ifdef HAVE_VFX_MODIFICATION
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/VisualEffectVertex.hlsl"
        #endif
        
        ENDHLSL
        }
        Pass
        {
            Name "ShadowCaster"
            Tags
            {
                "LightMode" = "ShadowCaster"
            }
        
        // Render State
        Cull Back
        ZTest LEqual
        ZWrite On
        ColorMask 0
        
        // Debug
        // <None>
        
        // --------------------------------------------------
        // Pass
        
        HLSLPROGRAM
        
        // Pragmas
        #pragma target 4.5
        #pragma exclude_renderers gles gles3 glcore
        #pragma multi_compile_instancing
        #pragma multi_compile _ DOTS_INSTANCING_ON
        #pragma vertex vert
        #pragma fragment frag
        
        // Keywords
        #pragma multi_compile_vertex _ _CASTING_PUNCTUAL_LIGHT_SHADOW
        // GraphKeywords: <None>
        
        // Defines
        
        #define _NORMALMAP 1
        #define _NORMAL_DROPOFF_TS 1
        #define ATTRIBUTES_NEED_NORMAL
        #define ATTRIBUTES_NEED_TANGENT
        #define VARYINGS_NEED_NORMAL_WS
        #define FEATURES_GRAPH_VERTEX
        /* WARNING: $splice Could not find named fragment 'PassInstancing' */
        #define SHADERPASS SHADERPASS_SHADOWCASTER
        /* WARNING: $splice Could not find named fragment 'DotsInstancingVars' */
        
        
        // custom interpolator pre-include
        /* WARNING: $splice Could not find named fragment 'sgci_CustomInterpolatorPreInclude' */
        
        // Includes
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
        
        // --------------------------------------------------
        // Structs and Packing
        
        // custom interpolators pre packing
        /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPrePacking' */
        
        struct Attributes
        {
             float3 positionOS : POSITION;
             float3 normalOS : NORMAL;
             float4 tangentOS : TANGENT;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : INSTANCEID_SEMANTIC;
            #endif
        };
        struct Varyings
        {
             float4 positionCS : SV_POSITION;
             float3 normalWS;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
        };
        struct SurfaceDescriptionInputs
        {
        };
        struct VertexDescriptionInputs
        {
             float3 ObjectSpaceNormal;
             float3 ObjectSpaceTangent;
             float3 ObjectSpacePosition;
        };
        struct PackedVaryings
        {
             float4 positionCS : SV_POSITION;
             float3 interp0 : INTERP0;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
        };
        
        PackedVaryings PackVaryings (Varyings input)
        {
            PackedVaryings output;
            ZERO_INITIALIZE(PackedVaryings, output);
            output.positionCS = input.positionCS;
            output.interp0.xyz =  input.normalWS;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        
        Varyings UnpackVaryings (PackedVaryings input)
        {
            Varyings output;
            output.positionCS = input.positionCS;
            output.normalWS = input.interp0.xyz;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        
        
        // --------------------------------------------------
        // Graph
        
        // Graph Properties
        CBUFFER_START(UnityPerMaterial)
        CBUFFER_END
        
        // Object and Global properties
        
        // Graph Includes


//Curved World
//#define CURVEDWORLD_BEND_TYPE_CLASSICRUNNER_X_POSITIVE
//#define CURVEDWORLD_BEND_ID_1
//#pragma shader_feature_local CURVEDWORLD_DISABLED_ON
//#pragma shader_feature_local CURVEDWORLD_NORMAL_TRANSFORMATION_ON
//#include "Assets/Amazing Assets/Curved World/Shaders/Core/CurvedWorldTransform.cginc"


//Terrain To Mesh Keywords//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma shader_feature_local _ _T2M_TEXTURE_SAMPLE_TYPE_ARRAY

#pragma shader_feature_local _ _T2M_LAYER_COUNT_3 _T2M_LAYER_COUNT_4 _T2M_LAYER_COUNT_5 _T2M_LAYER_COUNT_6 _T2M_LAYER_COUNT_7 _T2M_LAYER_COUNT_8 _T2M_LAYER_COUNT_9 _T2M_LAYER_COUNT_10 _T2M_LAYER_COUNT_11 _T2M_LAYER_COUNT_12 _T2M_LAYER_COUNT_13 _T2M_LAYER_COUNT_14 _T2M_LAYER_COUNT_15 _T2M_LAYER_COUNT_16
		
#pragma shader_feature_local _T2M_LAYER_0_NORMAL
#pragma shader_feature_local _T2M_LAYER_1_NORMAL
#pragma shader_feature_local _T2M_LAYER_2_NORMAL
#pragma shader_feature_local _T2M_LAYER_3_NORMAL
#pragma shader_feature_local _T2M_LAYER_4_NORMAL
#pragma shader_feature_local _T2M_LAYER_5_NORMAL
#pragma shader_feature_local _T2M_LAYER_6_NORMAL
#pragma shader_feature_local _T2M_LAYER_7_NORMAL
#pragma shader_feature_local _T2M_LAYER_8_NORMAL
#pragma shader_feature_local _T2M_LAYER_9_NORMAL
#pragma shader_feature_local _T2M_LAYER_10_NORMAL
#pragma shader_feature_local _T2M_LAYER_11_NORMAL
#pragma shader_feature_local _T2M_LAYER_12_NORMAL
#pragma shader_feature_local _T2M_LAYER_13_NORMAL
#pragma shader_feature_local _T2M_LAYER_14_NORMAL
#pragma shader_feature_local _T2M_LAYER_15_NORMAL

#pragma shader_feature_local _T2M_LAYER_0_MASK
#pragma shader_feature_local _T2M_LAYER_1_MASK
#pragma shader_feature_local _T2M_LAYER_2_MASK
#pragma shader_feature_local _T2M_LAYER_3_MASK
#pragma shader_feature_local _T2M_LAYER_4_MASK
#pragma shader_feature_local _T2M_LAYER_5_MASK
#pragma shader_feature_local _T2M_LAYER_6_MASK
#pragma shader_feature_local _T2M_LAYER_7_MASK
#pragma shader_feature_local _T2M_LAYER_8_MASK
#pragma shader_feature_local _T2M_LAYER_9_MASK
#pragma shader_feature_local _T2M_LAYER_10_MASK
#pragma shader_feature_local _T2M_LAYER_11_MASK
#pragma shader_feature_local _T2M_LAYER_12_MASK
#pragma shader_feature_local _T2M_LAYER_13_MASK
#pragma shader_feature_local _T2M_LAYER_14_MASK
#pragma shader_feature_local _T2M_LAYER_15_MASK

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


#define TERRAIN_TO_MESH_NEED_NORMAL
#define TERRAIN_TO_MESH_NEED_METALLIC_SMOOTHNESS_OCCLUSION


#include "Splatmap.cginc"
        
        // -- Property used by ScenePickingPass
        #ifdef SCENEPICKINGPASS
        float4 _SelectionID;
        #endif
        
        // -- Properties used by SceneSelectionPass
        #ifdef SCENESELECTIONPASS
        int _ObjectId;
        int _PassValue;
        #endif
        
        // Graph Functions
        // GraphFunctions: <None>
        
        // Custom interpolators pre vertex
        /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPreVertex' */
        
        // Graph Vertex
        struct VertexDescription
        {
            float3 Position;
            float3 Normal;
            float3 Tangent;
        };
        
        VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
        {
            VertexDescription description = (VertexDescription)0;
            float3 _SHGTerrainToMeshCurvedWorldCustomFunction_1d12c500e42ebf8b903bf40b7a0a5e2c_vertex_0;
            float3 _SHGTerrainToMeshCurvedWorldCustomFunction_1d12c500e42ebf8b903bf40b7a0a5e2c_normal_4;
            SHG_TerrainToMeshCurvedWorld_float(IN.ObjectSpacePosition, IN.ObjectSpaceNormal, (float4(IN.ObjectSpaceTangent, 1.0)), _SHGTerrainToMeshCurvedWorldCustomFunction_1d12c500e42ebf8b903bf40b7a0a5e2c_vertex_0, _SHGTerrainToMeshCurvedWorldCustomFunction_1d12c500e42ebf8b903bf40b7a0a5e2c_normal_4);
            description.Position = _SHGTerrainToMeshCurvedWorldCustomFunction_1d12c500e42ebf8b903bf40b7a0a5e2c_vertex_0;
            description.Normal = _SHGTerrainToMeshCurvedWorldCustomFunction_1d12c500e42ebf8b903bf40b7a0a5e2c_normal_4;
            description.Tangent = IN.ObjectSpaceTangent;
            return description;
        }
        
        // Custom interpolators, pre surface
        #ifdef FEATURES_GRAPH_VERTEX
        Varyings CustomInterpolatorPassThroughFunc(inout Varyings output, VertexDescription input)
        {
        return output;
        }
        #define CUSTOMINTERPOLATOR_VARYPASSTHROUGH_FUNC
        #endif
        
        // Graph Pixel
        struct SurfaceDescription
        {
        };
        
        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            return surface;
        }
        
        // --------------------------------------------------
        // Build Graph Inputs
        #ifdef HAVE_VFX_MODIFICATION
        #define VFX_SRP_ATTRIBUTES Attributes
        #define VFX_SRP_VARYINGS Varyings
        #define VFX_SRP_SURFACE_INPUTS SurfaceDescriptionInputs
        #endif
        VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
        {
            VertexDescriptionInputs output;
            ZERO_INITIALIZE(VertexDescriptionInputs, output);
        
            output.ObjectSpaceNormal =                          input.normalOS;
            output.ObjectSpaceTangent =                         input.tangentOS.xyz;
            output.ObjectSpacePosition =                        input.positionOS;
        
            return output;
        }
        SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
        {
            SurfaceDescriptionInputs output;
            ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
        
        #ifdef HAVE_VFX_MODIFICATION
            // FragInputs from VFX come from two places: Interpolator or CBuffer.
            /* WARNING: $splice Could not find named fragment 'VFXSetFragInputs' */
        
        #endif
        
            
        
        
        
        
        
        
            #if UNITY_UV_STARTS_AT_TOP
            #else
            #endif
        
        
        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
        #else
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        #endif
        #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        
                return output;
        }
        
        // --------------------------------------------------
        // Main
        
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShadowCasterPass.hlsl"
        
        // --------------------------------------------------
        // Visual Effect Vertex Invocations
        #ifdef HAVE_VFX_MODIFICATION
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/VisualEffectVertex.hlsl"
        #endif
        
        ENDHLSL
        }
        Pass
        {
            Name "DepthOnly"
            Tags
            {
                "LightMode" = "DepthOnly"
            }
        
        // Render State
        Cull Back
        ZTest LEqual
        ZWrite On
        ColorMask R
        
        // Debug
        // <None>
        
        // --------------------------------------------------
        // Pass
        
        HLSLPROGRAM
        
        // Pragmas
        #pragma target 4.5
        #pragma exclude_renderers gles gles3 glcore
        #pragma multi_compile_instancing
        #pragma multi_compile _ DOTS_INSTANCING_ON
        #pragma vertex vert
        #pragma fragment frag
        
        // Keywords
        // PassKeywords: <None>
        // GraphKeywords: <None>
        
        // Defines
        
        #define _NORMALMAP 1
        #define _NORMAL_DROPOFF_TS 1
        #define ATTRIBUTES_NEED_NORMAL
        #define ATTRIBUTES_NEED_TANGENT
        #define FEATURES_GRAPH_VERTEX
        /* WARNING: $splice Could not find named fragment 'PassInstancing' */
        #define SHADERPASS SHADERPASS_DEPTHONLY
        /* WARNING: $splice Could not find named fragment 'DotsInstancingVars' */
        
        
        // custom interpolator pre-include
        /* WARNING: $splice Could not find named fragment 'sgci_CustomInterpolatorPreInclude' */
        
        // Includes
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
        
        // --------------------------------------------------
        // Structs and Packing
        
        // custom interpolators pre packing
        /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPrePacking' */
        
        struct Attributes
        {
             float3 positionOS : POSITION;
             float3 normalOS : NORMAL;
             float4 tangentOS : TANGENT;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : INSTANCEID_SEMANTIC;
            #endif
        };
        struct Varyings
        {
             float4 positionCS : SV_POSITION;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
        };
        struct SurfaceDescriptionInputs
        {
        };
        struct VertexDescriptionInputs
        {
             float3 ObjectSpaceNormal;
             float3 ObjectSpaceTangent;
             float3 ObjectSpacePosition;
        };
        struct PackedVaryings
        {
             float4 positionCS : SV_POSITION;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
        };
        
        PackedVaryings PackVaryings (Varyings input)
        {
            PackedVaryings output;
            ZERO_INITIALIZE(PackedVaryings, output);
            output.positionCS = input.positionCS;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        
        Varyings UnpackVaryings (PackedVaryings input)
        {
            Varyings output;
            output.positionCS = input.positionCS;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        
        
        // --------------------------------------------------
        // Graph
        
        // Graph Properties
        CBUFFER_START(UnityPerMaterial)
        CBUFFER_END
        
        // Object and Global properties
        
        // Graph Includes


//Curved World
//#define CURVEDWORLD_BEND_TYPE_CLASSICRUNNER_X_POSITIVE
//#define CURVEDWORLD_BEND_ID_1
//#pragma shader_feature_local CURVEDWORLD_DISABLED_ON
//#pragma shader_feature_local CURVEDWORLD_NORMAL_TRANSFORMATION_ON
//#include "Assets/Amazing Assets/Curved World/Shaders/Core/CurvedWorldTransform.cginc"


//Terrain To Mesh Keywords//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma shader_feature_local _ _T2M_TEXTURE_SAMPLE_TYPE_ARRAY

#pragma shader_feature_local _ _T2M_LAYER_COUNT_3 _T2M_LAYER_COUNT_4 _T2M_LAYER_COUNT_5 _T2M_LAYER_COUNT_6 _T2M_LAYER_COUNT_7 _T2M_LAYER_COUNT_8 _T2M_LAYER_COUNT_9 _T2M_LAYER_COUNT_10 _T2M_LAYER_COUNT_11 _T2M_LAYER_COUNT_12 _T2M_LAYER_COUNT_13 _T2M_LAYER_COUNT_14 _T2M_LAYER_COUNT_15 _T2M_LAYER_COUNT_16
		
#pragma shader_feature_local _T2M_LAYER_0_NORMAL
#pragma shader_feature_local _T2M_LAYER_1_NORMAL
#pragma shader_feature_local _T2M_LAYER_2_NORMAL
#pragma shader_feature_local _T2M_LAYER_3_NORMAL
#pragma shader_feature_local _T2M_LAYER_4_NORMAL
#pragma shader_feature_local _T2M_LAYER_5_NORMAL
#pragma shader_feature_local _T2M_LAYER_6_NORMAL
#pragma shader_feature_local _T2M_LAYER_7_NORMAL
#pragma shader_feature_local _T2M_LAYER_8_NORMAL
#pragma shader_feature_local _T2M_LAYER_9_NORMAL
#pragma shader_feature_local _T2M_LAYER_10_NORMAL
#pragma shader_feature_local _T2M_LAYER_11_NORMAL
#pragma shader_feature_local _T2M_LAYER_12_NORMAL
#pragma shader_feature_local _T2M_LAYER_13_NORMAL
#pragma shader_feature_local _T2M_LAYER_14_NORMAL
#pragma shader_feature_local _T2M_LAYER_15_NORMAL

#pragma shader_feature_local _T2M_LAYER_0_MASK
#pragma shader_feature_local _T2M_LAYER_1_MASK
#pragma shader_feature_local _T2M_LAYER_2_MASK
#pragma shader_feature_local _T2M_LAYER_3_MASK
#pragma shader_feature_local _T2M_LAYER_4_MASK
#pragma shader_feature_local _T2M_LAYER_5_MASK
#pragma shader_feature_local _T2M_LAYER_6_MASK
#pragma shader_feature_local _T2M_LAYER_7_MASK
#pragma shader_feature_local _T2M_LAYER_8_MASK
#pragma shader_feature_local _T2M_LAYER_9_MASK
#pragma shader_feature_local _T2M_LAYER_10_MASK
#pragma shader_feature_local _T2M_LAYER_11_MASK
#pragma shader_feature_local _T2M_LAYER_12_MASK
#pragma shader_feature_local _T2M_LAYER_13_MASK
#pragma shader_feature_local _T2M_LAYER_14_MASK
#pragma shader_feature_local _T2M_LAYER_15_MASK

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


#define TERRAIN_TO_MESH_NEED_NORMAL
#define TERRAIN_TO_MESH_NEED_METALLIC_SMOOTHNESS_OCCLUSION


#include "Splatmap.cginc"
        
        // -- Property used by ScenePickingPass
        #ifdef SCENEPICKINGPASS
        float4 _SelectionID;
        #endif
        
        // -- Properties used by SceneSelectionPass
        #ifdef SCENESELECTIONPASS
        int _ObjectId;
        int _PassValue;
        #endif
        
        // Graph Functions
        // GraphFunctions: <None>
        
        // Custom interpolators pre vertex
        /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPreVertex' */
        
        // Graph Vertex
        struct VertexDescription
        {
            float3 Position;
            float3 Normal;
            float3 Tangent;
        };
        
        VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
        {
            VertexDescription description = (VertexDescription)0;
            float3 _SHGTerrainToMeshCurvedWorldCustomFunction_1d12c500e42ebf8b903bf40b7a0a5e2c_vertex_0;
            float3 _SHGTerrainToMeshCurvedWorldCustomFunction_1d12c500e42ebf8b903bf40b7a0a5e2c_normal_4;
            SHG_TerrainToMeshCurvedWorld_float(IN.ObjectSpacePosition, IN.ObjectSpaceNormal, (float4(IN.ObjectSpaceTangent, 1.0)), _SHGTerrainToMeshCurvedWorldCustomFunction_1d12c500e42ebf8b903bf40b7a0a5e2c_vertex_0, _SHGTerrainToMeshCurvedWorldCustomFunction_1d12c500e42ebf8b903bf40b7a0a5e2c_normal_4);
            description.Position = _SHGTerrainToMeshCurvedWorldCustomFunction_1d12c500e42ebf8b903bf40b7a0a5e2c_vertex_0;
            description.Normal = _SHGTerrainToMeshCurvedWorldCustomFunction_1d12c500e42ebf8b903bf40b7a0a5e2c_normal_4;
            description.Tangent = IN.ObjectSpaceTangent;
            return description;
        }
        
        // Custom interpolators, pre surface
        #ifdef FEATURES_GRAPH_VERTEX
        Varyings CustomInterpolatorPassThroughFunc(inout Varyings output, VertexDescription input)
        {
        return output;
        }
        #define CUSTOMINTERPOLATOR_VARYPASSTHROUGH_FUNC
        #endif
        
        // Graph Pixel
        struct SurfaceDescription
        {
        };
        
        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            return surface;
        }
        
        // --------------------------------------------------
        // Build Graph Inputs
        #ifdef HAVE_VFX_MODIFICATION
        #define VFX_SRP_ATTRIBUTES Attributes
        #define VFX_SRP_VARYINGS Varyings
        #define VFX_SRP_SURFACE_INPUTS SurfaceDescriptionInputs
        #endif
        VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
        {
            VertexDescriptionInputs output;
            ZERO_INITIALIZE(VertexDescriptionInputs, output);
        
            output.ObjectSpaceNormal =                          input.normalOS;
            output.ObjectSpaceTangent =                         input.tangentOS.xyz;
            output.ObjectSpacePosition =                        input.positionOS;
        
            return output;
        }
        SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
        {
            SurfaceDescriptionInputs output;
            ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
        
        #ifdef HAVE_VFX_MODIFICATION
            // FragInputs from VFX come from two places: Interpolator or CBuffer.
            /* WARNING: $splice Could not find named fragment 'VFXSetFragInputs' */
        
        #endif
        
            
        
        
        
        
        
        
            #if UNITY_UV_STARTS_AT_TOP
            #else
            #endif
        
        
        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
        #else
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        #endif
        #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        
                return output;
        }
        
        // --------------------------------------------------
        // Main
        
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/DepthOnlyPass.hlsl"
        
        // --------------------------------------------------
        // Visual Effect Vertex Invocations
        #ifdef HAVE_VFX_MODIFICATION
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/VisualEffectVertex.hlsl"
        #endif
        
        ENDHLSL
        }
        Pass
        {
            Name "DepthNormals"
            Tags
            {
                "LightMode" = "DepthNormals"
            }
        
        // Render State
        Cull Back
        ZTest LEqual
        ZWrite On
        
        // Debug
        // <None>
        
        // --------------------------------------------------
        // Pass
        
        HLSLPROGRAM
        
        // Pragmas
        #pragma target 4.5
        #pragma exclude_renderers gles gles3 glcore
        #pragma multi_compile_instancing
        #pragma multi_compile _ DOTS_INSTANCING_ON
        #pragma vertex vert
        #pragma fragment frag
        
        // Keywords
        // PassKeywords: <None>
        // GraphKeywords: <None>
        
        // Defines
        
        #define _NORMALMAP 1
        #define _NORMAL_DROPOFF_TS 1
        #define ATTRIBUTES_NEED_NORMAL
        #define ATTRIBUTES_NEED_TANGENT
        #define ATTRIBUTES_NEED_TEXCOORD0
        #define ATTRIBUTES_NEED_TEXCOORD1
        #define VARYINGS_NEED_NORMAL_WS
        #define VARYINGS_NEED_TANGENT_WS
        #define VARYINGS_NEED_TEXCOORD0
        #define FEATURES_GRAPH_VERTEX
        /* WARNING: $splice Could not find named fragment 'PassInstancing' */
        #define SHADERPASS SHADERPASS_DEPTHNORMALS
        /* WARNING: $splice Could not find named fragment 'DotsInstancingVars' */
        
        
        // custom interpolator pre-include
        /* WARNING: $splice Could not find named fragment 'sgci_CustomInterpolatorPreInclude' */
        
        // Includes
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
        
        // --------------------------------------------------
        // Structs and Packing
        
        // custom interpolators pre packing
        /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPrePacking' */
        
        struct Attributes
        {
             float3 positionOS : POSITION;
             float3 normalOS : NORMAL;
             float4 tangentOS : TANGENT;
             float4 uv0 : TEXCOORD0;
             float4 uv1 : TEXCOORD1;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : INSTANCEID_SEMANTIC;
            #endif
        };
        struct Varyings
        {
             float4 positionCS : SV_POSITION;
             float3 normalWS;
             float4 tangentWS;
             float4 texCoord0;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
        };
        struct SurfaceDescriptionInputs
        {
             float3 TangentSpaceNormal;
             float4 uv0;
        };
        struct VertexDescriptionInputs
        {
             float3 ObjectSpaceNormal;
             float3 ObjectSpaceTangent;
             float3 ObjectSpacePosition;
        };
        struct PackedVaryings
        {
             float4 positionCS : SV_POSITION;
             float3 interp0 : INTERP0;
             float4 interp1 : INTERP1;
             float4 interp2 : INTERP2;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
        };
        
        PackedVaryings PackVaryings (Varyings input)
        {
            PackedVaryings output;
            ZERO_INITIALIZE(PackedVaryings, output);
            output.positionCS = input.positionCS;
            output.interp0.xyz =  input.normalWS;
            output.interp1.xyzw =  input.tangentWS;
            output.interp2.xyzw =  input.texCoord0;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        
        Varyings UnpackVaryings (PackedVaryings input)
        {
            Varyings output;
            output.positionCS = input.positionCS;
            output.normalWS = input.interp0.xyz;
            output.tangentWS = input.interp1.xyzw;
            output.texCoord0 = input.interp2.xyzw;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        
        
        // --------------------------------------------------
        // Graph
        
        // Graph Properties
        CBUFFER_START(UnityPerMaterial)
        CBUFFER_END
        
        // Object and Global properties
        
        // Graph Includes


//Curved World
//#define CURVEDWORLD_BEND_TYPE_CLASSICRUNNER_X_POSITIVE
//#define CURVEDWORLD_BEND_ID_1
//#pragma shader_feature_local CURVEDWORLD_DISABLED_ON
//#pragma shader_feature_local CURVEDWORLD_NORMAL_TRANSFORMATION_ON
//#include "Assets/Amazing Assets/Curved World/Shaders/Core/CurvedWorldTransform.cginc"


//Terrain To Mesh Keywords//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma shader_feature_local _ _T2M_TEXTURE_SAMPLE_TYPE_ARRAY

#pragma shader_feature_local _ _T2M_LAYER_COUNT_3 _T2M_LAYER_COUNT_4 _T2M_LAYER_COUNT_5 _T2M_LAYER_COUNT_6 _T2M_LAYER_COUNT_7 _T2M_LAYER_COUNT_8 _T2M_LAYER_COUNT_9 _T2M_LAYER_COUNT_10 _T2M_LAYER_COUNT_11 _T2M_LAYER_COUNT_12 _T2M_LAYER_COUNT_13 _T2M_LAYER_COUNT_14 _T2M_LAYER_COUNT_15 _T2M_LAYER_COUNT_16
		
#pragma shader_feature_local _T2M_LAYER_0_NORMAL
#pragma shader_feature_local _T2M_LAYER_1_NORMAL
#pragma shader_feature_local _T2M_LAYER_2_NORMAL
#pragma shader_feature_local _T2M_LAYER_3_NORMAL
#pragma shader_feature_local _T2M_LAYER_4_NORMAL
#pragma shader_feature_local _T2M_LAYER_5_NORMAL
#pragma shader_feature_local _T2M_LAYER_6_NORMAL
#pragma shader_feature_local _T2M_LAYER_7_NORMAL
#pragma shader_feature_local _T2M_LAYER_8_NORMAL
#pragma shader_feature_local _T2M_LAYER_9_NORMAL
#pragma shader_feature_local _T2M_LAYER_10_NORMAL
#pragma shader_feature_local _T2M_LAYER_11_NORMAL
#pragma shader_feature_local _T2M_LAYER_12_NORMAL
#pragma shader_feature_local _T2M_LAYER_13_NORMAL
#pragma shader_feature_local _T2M_LAYER_14_NORMAL
#pragma shader_feature_local _T2M_LAYER_15_NORMAL

#pragma shader_feature_local _T2M_LAYER_0_MASK
#pragma shader_feature_local _T2M_LAYER_1_MASK
#pragma shader_feature_local _T2M_LAYER_2_MASK
#pragma shader_feature_local _T2M_LAYER_3_MASK
#pragma shader_feature_local _T2M_LAYER_4_MASK
#pragma shader_feature_local _T2M_LAYER_5_MASK
#pragma shader_feature_local _T2M_LAYER_6_MASK
#pragma shader_feature_local _T2M_LAYER_7_MASK
#pragma shader_feature_local _T2M_LAYER_8_MASK
#pragma shader_feature_local _T2M_LAYER_9_MASK
#pragma shader_feature_local _T2M_LAYER_10_MASK
#pragma shader_feature_local _T2M_LAYER_11_MASK
#pragma shader_feature_local _T2M_LAYER_12_MASK
#pragma shader_feature_local _T2M_LAYER_13_MASK
#pragma shader_feature_local _T2M_LAYER_14_MASK
#pragma shader_feature_local _T2M_LAYER_15_MASK

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


#define TERRAIN_TO_MESH_NEED_NORMAL
#define TERRAIN_TO_MESH_NEED_METALLIC_SMOOTHNESS_OCCLUSION


#include "Splatmap.cginc"
        
        // -- Property used by ScenePickingPass
        #ifdef SCENEPICKINGPASS
        float4 _SelectionID;
        #endif
        
        // -- Properties used by SceneSelectionPass
        #ifdef SCENESELECTIONPASS
        int _ObjectId;
        int _PassValue;
        #endif
        
        // Graph Functions
        // GraphFunctions: <None>
        
        // Custom interpolators pre vertex
        /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPreVertex' */
        
        // Graph Vertex
        struct VertexDescription
        {
            float3 Position;
            float3 Normal;
            float3 Tangent;
        };
        
        VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
        {
            VertexDescription description = (VertexDescription)0;
            float3 _SHGTerrainToMeshCurvedWorldCustomFunction_1d12c500e42ebf8b903bf40b7a0a5e2c_vertex_0;
            float3 _SHGTerrainToMeshCurvedWorldCustomFunction_1d12c500e42ebf8b903bf40b7a0a5e2c_normal_4;
            SHG_TerrainToMeshCurvedWorld_float(IN.ObjectSpacePosition, IN.ObjectSpaceNormal, (float4(IN.ObjectSpaceTangent, 1.0)), _SHGTerrainToMeshCurvedWorldCustomFunction_1d12c500e42ebf8b903bf40b7a0a5e2c_vertex_0, _SHGTerrainToMeshCurvedWorldCustomFunction_1d12c500e42ebf8b903bf40b7a0a5e2c_normal_4);
            description.Position = _SHGTerrainToMeshCurvedWorldCustomFunction_1d12c500e42ebf8b903bf40b7a0a5e2c_vertex_0;
            description.Normal = _SHGTerrainToMeshCurvedWorldCustomFunction_1d12c500e42ebf8b903bf40b7a0a5e2c_normal_4;
            description.Tangent = IN.ObjectSpaceTangent;
            return description;
        }
        
        // Custom interpolators, pre surface
        #ifdef FEATURES_GRAPH_VERTEX
        Varyings CustomInterpolatorPassThroughFunc(inout Varyings output, VertexDescription input)
        {
        return output;
        }
        #define CUSTOMINTERPOLATOR_VARYPASSTHROUGH_FUNC
        #endif
        
        // Graph Pixel
        struct SurfaceDescription
        {
            float3 NormalTS;
        };
        
        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            float4 _UV_d56c6fdf7ac2828fa944da2372119006_Out_0 = IN.uv0;
            float3 _SHGTerrainToMeshCalculateLayersBlendCustomFunction_24112ec2b2aa8c829e8ab4bb7ea28f60_albedo_1;
            float _SHGTerrainToMeshCalculateLayersBlendCustomFunction_24112ec2b2aa8c829e8ab4bb7ea28f60_alpha_2;
            float3 _SHGTerrainToMeshCalculateLayersBlendCustomFunction_24112ec2b2aa8c829e8ab4bb7ea28f60_normal_3;
            float _SHGTerrainToMeshCalculateLayersBlendCustomFunction_24112ec2b2aa8c829e8ab4bb7ea28f60_metallic_4;
            float _SHGTerrainToMeshCalculateLayersBlendCustomFunction_24112ec2b2aa8c829e8ab4bb7ea28f60_smoothness_5;
            float _SHGTerrainToMeshCalculateLayersBlendCustomFunction_24112ec2b2aa8c829e8ab4bb7ea28f60_occlusion_6;
            SHG_TerrainToMeshCalculateLayersBlend_float(_UV_d56c6fdf7ac2828fa944da2372119006_Out_0, _SHGTerrainToMeshCalculateLayersBlendCustomFunction_24112ec2b2aa8c829e8ab4bb7ea28f60_albedo_1, _SHGTerrainToMeshCalculateLayersBlendCustomFunction_24112ec2b2aa8c829e8ab4bb7ea28f60_alpha_2, _SHGTerrainToMeshCalculateLayersBlendCustomFunction_24112ec2b2aa8c829e8ab4bb7ea28f60_normal_3, _SHGTerrainToMeshCalculateLayersBlendCustomFunction_24112ec2b2aa8c829e8ab4bb7ea28f60_metallic_4, _SHGTerrainToMeshCalculateLayersBlendCustomFunction_24112ec2b2aa8c829e8ab4bb7ea28f60_smoothness_5, _SHGTerrainToMeshCalculateLayersBlendCustomFunction_24112ec2b2aa8c829e8ab4bb7ea28f60_occlusion_6);
            surface.NormalTS = _SHGTerrainToMeshCalculateLayersBlendCustomFunction_24112ec2b2aa8c829e8ab4bb7ea28f60_normal_3;
            return surface;
        }
        
        // --------------------------------------------------
        // Build Graph Inputs
        #ifdef HAVE_VFX_MODIFICATION
        #define VFX_SRP_ATTRIBUTES Attributes
        #define VFX_SRP_VARYINGS Varyings
        #define VFX_SRP_SURFACE_INPUTS SurfaceDescriptionInputs
        #endif
        VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
        {
            VertexDescriptionInputs output;
            ZERO_INITIALIZE(VertexDescriptionInputs, output);
        
            output.ObjectSpaceNormal =                          input.normalOS;
            output.ObjectSpaceTangent =                         input.tangentOS.xyz;
            output.ObjectSpacePosition =                        input.positionOS;
        
            return output;
        }
        SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
        {
            SurfaceDescriptionInputs output;
            ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
        
        #ifdef HAVE_VFX_MODIFICATION
            // FragInputs from VFX come from two places: Interpolator or CBuffer.
            /* WARNING: $splice Could not find named fragment 'VFXSetFragInputs' */
        
        #endif
        
            
        
        
        
            output.TangentSpaceNormal = float3(0.0f, 0.0f, 1.0f);
        
        
        
            #if UNITY_UV_STARTS_AT_TOP
            #else
            #endif
        
        
            output.uv0 = input.texCoord0;
        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
        #else
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        #endif
        #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        
                return output;
        }
        
        // --------------------------------------------------
        // Main
        
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/DepthNormalsOnlyPass.hlsl"
        
        // --------------------------------------------------
        // Visual Effect Vertex Invocations
        #ifdef HAVE_VFX_MODIFICATION
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/VisualEffectVertex.hlsl"
        #endif
        
        ENDHLSL
        }
        Pass
        {
            Name "Meta"
            Tags
            {
                "LightMode" = "Meta"
            }
        
        // Render State
        Cull Off
        
        // Debug
        // <None>
        
        // --------------------------------------------------
        // Pass
        
        HLSLPROGRAM
        
        // Pragmas
        #pragma target 4.5
        #pragma exclude_renderers gles gles3 glcore
        #pragma vertex vert
        #pragma fragment frag
        
        // Keywords
        #pragma shader_feature _ EDITOR_VISUALIZATION
        // GraphKeywords: <None>
        
        // Defines
        
        #define _NORMALMAP 1
        #define _NORMAL_DROPOFF_TS 1
        #define ATTRIBUTES_NEED_NORMAL
        #define ATTRIBUTES_NEED_TANGENT
        #define ATTRIBUTES_NEED_TEXCOORD0
        #define ATTRIBUTES_NEED_TEXCOORD1
        #define ATTRIBUTES_NEED_TEXCOORD2
        #define VARYINGS_NEED_TEXCOORD0
        #define VARYINGS_NEED_TEXCOORD1
        #define VARYINGS_NEED_TEXCOORD2
        #define FEATURES_GRAPH_VERTEX
        /* WARNING: $splice Could not find named fragment 'PassInstancing' */
        #define SHADERPASS SHADERPASS_META
        #define _FOG_FRAGMENT 1
        /* WARNING: $splice Could not find named fragment 'DotsInstancingVars' */
        
        
        // custom interpolator pre-include
        /* WARNING: $splice Could not find named fragment 'sgci_CustomInterpolatorPreInclude' */
        
        // Includes
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/MetaInput.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
        
        // --------------------------------------------------
        // Structs and Packing
        
        // custom interpolators pre packing
        /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPrePacking' */
        
        struct Attributes
        {
             float3 positionOS : POSITION;
             float3 normalOS : NORMAL;
             float4 tangentOS : TANGENT;
             float4 uv0 : TEXCOORD0;
             float4 uv1 : TEXCOORD1;
             float4 uv2 : TEXCOORD2;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : INSTANCEID_SEMANTIC;
            #endif
        };
        struct Varyings
        {
             float4 positionCS : SV_POSITION;
             float4 texCoord0;
             float4 texCoord1;
             float4 texCoord2;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
        };
        struct SurfaceDescriptionInputs
        {
             float4 uv0;
        };
        struct VertexDescriptionInputs
        {
             float3 ObjectSpaceNormal;
             float3 ObjectSpaceTangent;
             float3 ObjectSpacePosition;
        };
        struct PackedVaryings
        {
             float4 positionCS : SV_POSITION;
             float4 interp0 : INTERP0;
             float4 interp1 : INTERP1;
             float4 interp2 : INTERP2;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
        };
        
        PackedVaryings PackVaryings (Varyings input)
        {
            PackedVaryings output;
            ZERO_INITIALIZE(PackedVaryings, output);
            output.positionCS = input.positionCS;
            output.interp0.xyzw =  input.texCoord0;
            output.interp1.xyzw =  input.texCoord1;
            output.interp2.xyzw =  input.texCoord2;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        
        Varyings UnpackVaryings (PackedVaryings input)
        {
            Varyings output;
            output.positionCS = input.positionCS;
            output.texCoord0 = input.interp0.xyzw;
            output.texCoord1 = input.interp1.xyzw;
            output.texCoord2 = input.interp2.xyzw;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        
        
        // --------------------------------------------------
        // Graph
        
        // Graph Properties
        CBUFFER_START(UnityPerMaterial)
        CBUFFER_END
        
        // Object and Global properties
        
        // Graph Includes


//Curved World
//#define CURVEDWORLD_BEND_TYPE_CLASSICRUNNER_X_POSITIVE
//#define CURVEDWORLD_BEND_ID_1
//#pragma shader_feature_local CURVEDWORLD_DISABLED_ON
//#pragma shader_feature_local CURVEDWORLD_NORMAL_TRANSFORMATION_ON
//#include "Assets/Amazing Assets/Curved World/Shaders/Core/CurvedWorldTransform.cginc"


//Terrain To Mesh Keywords//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma shader_feature_local _ _T2M_TEXTURE_SAMPLE_TYPE_ARRAY

#pragma shader_feature_local _ _T2M_LAYER_COUNT_3 _T2M_LAYER_COUNT_4 _T2M_LAYER_COUNT_5 _T2M_LAYER_COUNT_6 _T2M_LAYER_COUNT_7 _T2M_LAYER_COUNT_8 _T2M_LAYER_COUNT_9 _T2M_LAYER_COUNT_10 _T2M_LAYER_COUNT_11 _T2M_LAYER_COUNT_12 _T2M_LAYER_COUNT_13 _T2M_LAYER_COUNT_14 _T2M_LAYER_COUNT_15 _T2M_LAYER_COUNT_16
		
#pragma shader_feature_local _T2M_LAYER_0_NORMAL
#pragma shader_feature_local _T2M_LAYER_1_NORMAL
#pragma shader_feature_local _T2M_LAYER_2_NORMAL
#pragma shader_feature_local _T2M_LAYER_3_NORMAL
#pragma shader_feature_local _T2M_LAYER_4_NORMAL
#pragma shader_feature_local _T2M_LAYER_5_NORMAL
#pragma shader_feature_local _T2M_LAYER_6_NORMAL
#pragma shader_feature_local _T2M_LAYER_7_NORMAL
#pragma shader_feature_local _T2M_LAYER_8_NORMAL
#pragma shader_feature_local _T2M_LAYER_9_NORMAL
#pragma shader_feature_local _T2M_LAYER_10_NORMAL
#pragma shader_feature_local _T2M_LAYER_11_NORMAL
#pragma shader_feature_local _T2M_LAYER_12_NORMAL
#pragma shader_feature_local _T2M_LAYER_13_NORMAL
#pragma shader_feature_local _T2M_LAYER_14_NORMAL
#pragma shader_feature_local _T2M_LAYER_15_NORMAL

#pragma shader_feature_local _T2M_LAYER_0_MASK
#pragma shader_feature_local _T2M_LAYER_1_MASK
#pragma shader_feature_local _T2M_LAYER_2_MASK
#pragma shader_feature_local _T2M_LAYER_3_MASK
#pragma shader_feature_local _T2M_LAYER_4_MASK
#pragma shader_feature_local _T2M_LAYER_5_MASK
#pragma shader_feature_local _T2M_LAYER_6_MASK
#pragma shader_feature_local _T2M_LAYER_7_MASK
#pragma shader_feature_local _T2M_LAYER_8_MASK
#pragma shader_feature_local _T2M_LAYER_9_MASK
#pragma shader_feature_local _T2M_LAYER_10_MASK
#pragma shader_feature_local _T2M_LAYER_11_MASK
#pragma shader_feature_local _T2M_LAYER_12_MASK
#pragma shader_feature_local _T2M_LAYER_13_MASK
#pragma shader_feature_local _T2M_LAYER_14_MASK
#pragma shader_feature_local _T2M_LAYER_15_MASK

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


#define TERRAIN_TO_MESH_NEED_NORMAL
#define TERRAIN_TO_MESH_NEED_METALLIC_SMOOTHNESS_OCCLUSION


#include "Splatmap.cginc"
        
        // -- Property used by ScenePickingPass
        #ifdef SCENEPICKINGPASS
        float4 _SelectionID;
        #endif
        
        // -- Properties used by SceneSelectionPass
        #ifdef SCENESELECTIONPASS
        int _ObjectId;
        int _PassValue;
        #endif
        
        // Graph Functions
        // GraphFunctions: <None>
        
        // Custom interpolators pre vertex
        /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPreVertex' */
        
        // Graph Vertex
        struct VertexDescription
        {
            float3 Position;
            float3 Normal;
            float3 Tangent;
        };
        
        VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
        {
            VertexDescription description = (VertexDescription)0;
            float3 _SHGTerrainToMeshCurvedWorldCustomFunction_1d12c500e42ebf8b903bf40b7a0a5e2c_vertex_0;
            float3 _SHGTerrainToMeshCurvedWorldCustomFunction_1d12c500e42ebf8b903bf40b7a0a5e2c_normal_4;
            SHG_TerrainToMeshCurvedWorld_float(IN.ObjectSpacePosition, IN.ObjectSpaceNormal, (float4(IN.ObjectSpaceTangent, 1.0)), _SHGTerrainToMeshCurvedWorldCustomFunction_1d12c500e42ebf8b903bf40b7a0a5e2c_vertex_0, _SHGTerrainToMeshCurvedWorldCustomFunction_1d12c500e42ebf8b903bf40b7a0a5e2c_normal_4);
            description.Position = _SHGTerrainToMeshCurvedWorldCustomFunction_1d12c500e42ebf8b903bf40b7a0a5e2c_vertex_0;
            description.Normal = _SHGTerrainToMeshCurvedWorldCustomFunction_1d12c500e42ebf8b903bf40b7a0a5e2c_normal_4;
            description.Tangent = IN.ObjectSpaceTangent;
            return description;
        }
        
        // Custom interpolators, pre surface
        #ifdef FEATURES_GRAPH_VERTEX
        Varyings CustomInterpolatorPassThroughFunc(inout Varyings output, VertexDescription input)
        {
        return output;
        }
        #define CUSTOMINTERPOLATOR_VARYPASSTHROUGH_FUNC
        #endif
        
        // Graph Pixel
        struct SurfaceDescription
        {
            float3 BaseColor;
            float3 Emission;
        };
        
        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            float4 _UV_d56c6fdf7ac2828fa944da2372119006_Out_0 = IN.uv0;
            float3 _SHGTerrainToMeshCalculateLayersBlendCustomFunction_24112ec2b2aa8c829e8ab4bb7ea28f60_albedo_1;
            float _SHGTerrainToMeshCalculateLayersBlendCustomFunction_24112ec2b2aa8c829e8ab4bb7ea28f60_alpha_2;
            float3 _SHGTerrainToMeshCalculateLayersBlendCustomFunction_24112ec2b2aa8c829e8ab4bb7ea28f60_normal_3;
            float _SHGTerrainToMeshCalculateLayersBlendCustomFunction_24112ec2b2aa8c829e8ab4bb7ea28f60_metallic_4;
            float _SHGTerrainToMeshCalculateLayersBlendCustomFunction_24112ec2b2aa8c829e8ab4bb7ea28f60_smoothness_5;
            float _SHGTerrainToMeshCalculateLayersBlendCustomFunction_24112ec2b2aa8c829e8ab4bb7ea28f60_occlusion_6;
            SHG_TerrainToMeshCalculateLayersBlend_float(_UV_d56c6fdf7ac2828fa944da2372119006_Out_0, _SHGTerrainToMeshCalculateLayersBlendCustomFunction_24112ec2b2aa8c829e8ab4bb7ea28f60_albedo_1, _SHGTerrainToMeshCalculateLayersBlendCustomFunction_24112ec2b2aa8c829e8ab4bb7ea28f60_alpha_2, _SHGTerrainToMeshCalculateLayersBlendCustomFunction_24112ec2b2aa8c829e8ab4bb7ea28f60_normal_3, _SHGTerrainToMeshCalculateLayersBlendCustomFunction_24112ec2b2aa8c829e8ab4bb7ea28f60_metallic_4, _SHGTerrainToMeshCalculateLayersBlendCustomFunction_24112ec2b2aa8c829e8ab4bb7ea28f60_smoothness_5, _SHGTerrainToMeshCalculateLayersBlendCustomFunction_24112ec2b2aa8c829e8ab4bb7ea28f60_occlusion_6);
            surface.BaseColor = _SHGTerrainToMeshCalculateLayersBlendCustomFunction_24112ec2b2aa8c829e8ab4bb7ea28f60_albedo_1;
            surface.Emission = float3(0, 0, 0);
            return surface;
        }
        
        // --------------------------------------------------
        // Build Graph Inputs
        #ifdef HAVE_VFX_MODIFICATION
        #define VFX_SRP_ATTRIBUTES Attributes
        #define VFX_SRP_VARYINGS Varyings
        #define VFX_SRP_SURFACE_INPUTS SurfaceDescriptionInputs
        #endif
        VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
        {
            VertexDescriptionInputs output;
            ZERO_INITIALIZE(VertexDescriptionInputs, output);
        
            output.ObjectSpaceNormal =                          input.normalOS;
            output.ObjectSpaceTangent =                         input.tangentOS.xyz;
            output.ObjectSpacePosition =                        input.positionOS;
        
            return output;
        }
        SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
        {
            SurfaceDescriptionInputs output;
            ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
        
        #ifdef HAVE_VFX_MODIFICATION
            // FragInputs from VFX come from two places: Interpolator or CBuffer.
            /* WARNING: $splice Could not find named fragment 'VFXSetFragInputs' */
        
        #endif
        
            
        
        
        
        
        
        
            #if UNITY_UV_STARTS_AT_TOP
            #else
            #endif
        
        
            output.uv0 = input.texCoord0;
        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
        #else
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        #endif
        #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        
                return output;
        }
        
        // --------------------------------------------------
        // Main
        
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/LightingMetaPass.hlsl"
        
        // --------------------------------------------------
        // Visual Effect Vertex Invocations
        #ifdef HAVE_VFX_MODIFICATION
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/VisualEffectVertex.hlsl"
        #endif
        
        ENDHLSL
        }
        Pass
        {
            Name "SceneSelectionPass"
            Tags
            {
                "LightMode" = "SceneSelectionPass"
            }
        
        // Render State
        Cull Off
        
        // Debug
        // <None>
        
        // --------------------------------------------------
        // Pass
        
        HLSLPROGRAM
        
        // Pragmas
        #pragma target 4.5
        #pragma exclude_renderers gles gles3 glcore
        #pragma vertex vert
        #pragma fragment frag
        
        // Keywords
        // PassKeywords: <None>
        // GraphKeywords: <None>
        
        // Defines
        
        #define _NORMALMAP 1
        #define _NORMAL_DROPOFF_TS 1
        #define ATTRIBUTES_NEED_NORMAL
        #define ATTRIBUTES_NEED_TANGENT
        #define FEATURES_GRAPH_VERTEX
        /* WARNING: $splice Could not find named fragment 'PassInstancing' */
        #define SHADERPASS SHADERPASS_DEPTHONLY
        #define SCENESELECTIONPASS 1
        #define ALPHA_CLIP_THRESHOLD 1
        /* WARNING: $splice Could not find named fragment 'DotsInstancingVars' */
        
        
        // custom interpolator pre-include
        /* WARNING: $splice Could not find named fragment 'sgci_CustomInterpolatorPreInclude' */
        
        // Includes
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
        
        // --------------------------------------------------
        // Structs and Packing
        
        // custom interpolators pre packing
        /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPrePacking' */
        
        struct Attributes
        {
             float3 positionOS : POSITION;
             float3 normalOS : NORMAL;
             float4 tangentOS : TANGENT;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : INSTANCEID_SEMANTIC;
            #endif
        };
        struct Varyings
        {
             float4 positionCS : SV_POSITION;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
        };
        struct SurfaceDescriptionInputs
        {
        };
        struct VertexDescriptionInputs
        {
             float3 ObjectSpaceNormal;
             float3 ObjectSpaceTangent;
             float3 ObjectSpacePosition;
        };
        struct PackedVaryings
        {
             float4 positionCS : SV_POSITION;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
        };
        
        PackedVaryings PackVaryings (Varyings input)
        {
            PackedVaryings output;
            ZERO_INITIALIZE(PackedVaryings, output);
            output.positionCS = input.positionCS;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        
        Varyings UnpackVaryings (PackedVaryings input)
        {
            Varyings output;
            output.positionCS = input.positionCS;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        
        
        // --------------------------------------------------
        // Graph
        
        // Graph Properties
        CBUFFER_START(UnityPerMaterial)
        CBUFFER_END
        
        // Object and Global properties
        
        // Graph Includes


//Curved World
//#define CURVEDWORLD_BEND_TYPE_CLASSICRUNNER_X_POSITIVE
//#define CURVEDWORLD_BEND_ID_1
//#pragma shader_feature_local CURVEDWORLD_DISABLED_ON
//#pragma shader_feature_local CURVEDWORLD_NORMAL_TRANSFORMATION_ON
//#include "Assets/Amazing Assets/Curved World/Shaders/Core/CurvedWorldTransform.cginc"


//Terrain To Mesh Keywords//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma shader_feature_local _ _T2M_TEXTURE_SAMPLE_TYPE_ARRAY

#pragma shader_feature_local _ _T2M_LAYER_COUNT_3 _T2M_LAYER_COUNT_4 _T2M_LAYER_COUNT_5 _T2M_LAYER_COUNT_6 _T2M_LAYER_COUNT_7 _T2M_LAYER_COUNT_8 _T2M_LAYER_COUNT_9 _T2M_LAYER_COUNT_10 _T2M_LAYER_COUNT_11 _T2M_LAYER_COUNT_12 _T2M_LAYER_COUNT_13 _T2M_LAYER_COUNT_14 _T2M_LAYER_COUNT_15 _T2M_LAYER_COUNT_16
		
#pragma shader_feature_local _T2M_LAYER_0_NORMAL
#pragma shader_feature_local _T2M_LAYER_1_NORMAL
#pragma shader_feature_local _T2M_LAYER_2_NORMAL
#pragma shader_feature_local _T2M_LAYER_3_NORMAL
#pragma shader_feature_local _T2M_LAYER_4_NORMAL
#pragma shader_feature_local _T2M_LAYER_5_NORMAL
#pragma shader_feature_local _T2M_LAYER_6_NORMAL
#pragma shader_feature_local _T2M_LAYER_7_NORMAL
#pragma shader_feature_local _T2M_LAYER_8_NORMAL
#pragma shader_feature_local _T2M_LAYER_9_NORMAL
#pragma shader_feature_local _T2M_LAYER_10_NORMAL
#pragma shader_feature_local _T2M_LAYER_11_NORMAL
#pragma shader_feature_local _T2M_LAYER_12_NORMAL
#pragma shader_feature_local _T2M_LAYER_13_NORMAL
#pragma shader_feature_local _T2M_LAYER_14_NORMAL
#pragma shader_feature_local _T2M_LAYER_15_NORMAL

#pragma shader_feature_local _T2M_LAYER_0_MASK
#pragma shader_feature_local _T2M_LAYER_1_MASK
#pragma shader_feature_local _T2M_LAYER_2_MASK
#pragma shader_feature_local _T2M_LAYER_3_MASK
#pragma shader_feature_local _T2M_LAYER_4_MASK
#pragma shader_feature_local _T2M_LAYER_5_MASK
#pragma shader_feature_local _T2M_LAYER_6_MASK
#pragma shader_feature_local _T2M_LAYER_7_MASK
#pragma shader_feature_local _T2M_LAYER_8_MASK
#pragma shader_feature_local _T2M_LAYER_9_MASK
#pragma shader_feature_local _T2M_LAYER_10_MASK
#pragma shader_feature_local _T2M_LAYER_11_MASK
#pragma shader_feature_local _T2M_LAYER_12_MASK
#pragma shader_feature_local _T2M_LAYER_13_MASK
#pragma shader_feature_local _T2M_LAYER_14_MASK
#pragma shader_feature_local _T2M_LAYER_15_MASK

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


#define TERRAIN_TO_MESH_NEED_NORMAL
#define TERRAIN_TO_MESH_NEED_METALLIC_SMOOTHNESS_OCCLUSION


#include "Splatmap.cginc"
        
        // -- Property used by ScenePickingPass
        #ifdef SCENEPICKINGPASS
        float4 _SelectionID;
        #endif
        
        // -- Properties used by SceneSelectionPass
        #ifdef SCENESELECTIONPASS
        int _ObjectId;
        int _PassValue;
        #endif
        
        // Graph Functions
        // GraphFunctions: <None>
        
        // Custom interpolators pre vertex
        /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPreVertex' */
        
        // Graph Vertex
        struct VertexDescription
        {
            float3 Position;
            float3 Normal;
            float3 Tangent;
        };
        
        VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
        {
            VertexDescription description = (VertexDescription)0;
            float3 _SHGTerrainToMeshCurvedWorldCustomFunction_1d12c500e42ebf8b903bf40b7a0a5e2c_vertex_0;
            float3 _SHGTerrainToMeshCurvedWorldCustomFunction_1d12c500e42ebf8b903bf40b7a0a5e2c_normal_4;
            SHG_TerrainToMeshCurvedWorld_float(IN.ObjectSpacePosition, IN.ObjectSpaceNormal, (float4(IN.ObjectSpaceTangent, 1.0)), _SHGTerrainToMeshCurvedWorldCustomFunction_1d12c500e42ebf8b903bf40b7a0a5e2c_vertex_0, _SHGTerrainToMeshCurvedWorldCustomFunction_1d12c500e42ebf8b903bf40b7a0a5e2c_normal_4);
            description.Position = _SHGTerrainToMeshCurvedWorldCustomFunction_1d12c500e42ebf8b903bf40b7a0a5e2c_vertex_0;
            description.Normal = _SHGTerrainToMeshCurvedWorldCustomFunction_1d12c500e42ebf8b903bf40b7a0a5e2c_normal_4;
            description.Tangent = IN.ObjectSpaceTangent;
            return description;
        }
        
        // Custom interpolators, pre surface
        #ifdef FEATURES_GRAPH_VERTEX
        Varyings CustomInterpolatorPassThroughFunc(inout Varyings output, VertexDescription input)
        {
        return output;
        }
        #define CUSTOMINTERPOLATOR_VARYPASSTHROUGH_FUNC
        #endif
        
        // Graph Pixel
        struct SurfaceDescription
        {
        };
        
        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            return surface;
        }
        
        // --------------------------------------------------
        // Build Graph Inputs
        #ifdef HAVE_VFX_MODIFICATION
        #define VFX_SRP_ATTRIBUTES Attributes
        #define VFX_SRP_VARYINGS Varyings
        #define VFX_SRP_SURFACE_INPUTS SurfaceDescriptionInputs
        #endif
        VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
        {
            VertexDescriptionInputs output;
            ZERO_INITIALIZE(VertexDescriptionInputs, output);
        
            output.ObjectSpaceNormal =                          input.normalOS;
            output.ObjectSpaceTangent =                         input.tangentOS.xyz;
            output.ObjectSpacePosition =                        input.positionOS;
        
            return output;
        }
        SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
        {
            SurfaceDescriptionInputs output;
            ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
        
        #ifdef HAVE_VFX_MODIFICATION
            // FragInputs from VFX come from two places: Interpolator or CBuffer.
            /* WARNING: $splice Could not find named fragment 'VFXSetFragInputs' */
        
        #endif
        
            
        
        
        
        
        
        
            #if UNITY_UV_STARTS_AT_TOP
            #else
            #endif
        
        
        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
        #else
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        #endif
        #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        
                return output;
        }
        
        // --------------------------------------------------
        // Main
        
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/SelectionPickingPass.hlsl"
        
        // --------------------------------------------------
        // Visual Effect Vertex Invocations
        #ifdef HAVE_VFX_MODIFICATION
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/VisualEffectVertex.hlsl"
        #endif
        
        ENDHLSL
        }
        Pass
        {
            Name "ScenePickingPass"
            Tags
            {
                "LightMode" = "Picking"
            }
        
        // Render State
        Cull Back
        
        // Debug
        // <None>
        
        // --------------------------------------------------
        // Pass
        
        HLSLPROGRAM
        
        // Pragmas
        #pragma target 4.5
        #pragma exclude_renderers gles gles3 glcore
        #pragma vertex vert
        #pragma fragment frag
        
        // Keywords
        // PassKeywords: <None>
        // GraphKeywords: <None>
        
        // Defines
        
        #define _NORMALMAP 1
        #define _NORMAL_DROPOFF_TS 1
        #define ATTRIBUTES_NEED_NORMAL
        #define ATTRIBUTES_NEED_TANGENT
        #define FEATURES_GRAPH_VERTEX
        /* WARNING: $splice Could not find named fragment 'PassInstancing' */
        #define SHADERPASS SHADERPASS_DEPTHONLY
        #define SCENEPICKINGPASS 1
        #define ALPHA_CLIP_THRESHOLD 1
        /* WARNING: $splice Could not find named fragment 'DotsInstancingVars' */
        
        
        // custom interpolator pre-include
        /* WARNING: $splice Could not find named fragment 'sgci_CustomInterpolatorPreInclude' */
        
        // Includes
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
        
        // --------------------------------------------------
        // Structs and Packing
        
        // custom interpolators pre packing
        /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPrePacking' */
        
        struct Attributes
        {
             float3 positionOS : POSITION;
             float3 normalOS : NORMAL;
             float4 tangentOS : TANGENT;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : INSTANCEID_SEMANTIC;
            #endif
        };
        struct Varyings
        {
             float4 positionCS : SV_POSITION;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
        };
        struct SurfaceDescriptionInputs
        {
        };
        struct VertexDescriptionInputs
        {
             float3 ObjectSpaceNormal;
             float3 ObjectSpaceTangent;
             float3 ObjectSpacePosition;
        };
        struct PackedVaryings
        {
             float4 positionCS : SV_POSITION;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
        };
        
        PackedVaryings PackVaryings (Varyings input)
        {
            PackedVaryings output;
            ZERO_INITIALIZE(PackedVaryings, output);
            output.positionCS = input.positionCS;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        
        Varyings UnpackVaryings (PackedVaryings input)
        {
            Varyings output;
            output.positionCS = input.positionCS;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        
        
        // --------------------------------------------------
        // Graph
        
        // Graph Properties
        CBUFFER_START(UnityPerMaterial)
        CBUFFER_END
        
        // Object and Global properties
        
        // Graph Includes


//Curved World
//#define CURVEDWORLD_BEND_TYPE_CLASSICRUNNER_X_POSITIVE
//#define CURVEDWORLD_BEND_ID_1
//#pragma shader_feature_local CURVEDWORLD_DISABLED_ON
//#pragma shader_feature_local CURVEDWORLD_NORMAL_TRANSFORMATION_ON
//#include "Assets/Amazing Assets/Curved World/Shaders/Core/CurvedWorldTransform.cginc"


//Terrain To Mesh Keywords//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma shader_feature_local _ _T2M_TEXTURE_SAMPLE_TYPE_ARRAY

#pragma shader_feature_local _ _T2M_LAYER_COUNT_3 _T2M_LAYER_COUNT_4 _T2M_LAYER_COUNT_5 _T2M_LAYER_COUNT_6 _T2M_LAYER_COUNT_7 _T2M_LAYER_COUNT_8 _T2M_LAYER_COUNT_9 _T2M_LAYER_COUNT_10 _T2M_LAYER_COUNT_11 _T2M_LAYER_COUNT_12 _T2M_LAYER_COUNT_13 _T2M_LAYER_COUNT_14 _T2M_LAYER_COUNT_15 _T2M_LAYER_COUNT_16
		
#pragma shader_feature_local _T2M_LAYER_0_NORMAL
#pragma shader_feature_local _T2M_LAYER_1_NORMAL
#pragma shader_feature_local _T2M_LAYER_2_NORMAL
#pragma shader_feature_local _T2M_LAYER_3_NORMAL
#pragma shader_feature_local _T2M_LAYER_4_NORMAL
#pragma shader_feature_local _T2M_LAYER_5_NORMAL
#pragma shader_feature_local _T2M_LAYER_6_NORMAL
#pragma shader_feature_local _T2M_LAYER_7_NORMAL
#pragma shader_feature_local _T2M_LAYER_8_NORMAL
#pragma shader_feature_local _T2M_LAYER_9_NORMAL
#pragma shader_feature_local _T2M_LAYER_10_NORMAL
#pragma shader_feature_local _T2M_LAYER_11_NORMAL
#pragma shader_feature_local _T2M_LAYER_12_NORMAL
#pragma shader_feature_local _T2M_LAYER_13_NORMAL
#pragma shader_feature_local _T2M_LAYER_14_NORMAL
#pragma shader_feature_local _T2M_LAYER_15_NORMAL

#pragma shader_feature_local _T2M_LAYER_0_MASK
#pragma shader_feature_local _T2M_LAYER_1_MASK
#pragma shader_feature_local _T2M_LAYER_2_MASK
#pragma shader_feature_local _T2M_LAYER_3_MASK
#pragma shader_feature_local _T2M_LAYER_4_MASK
#pragma shader_feature_local _T2M_LAYER_5_MASK
#pragma shader_feature_local _T2M_LAYER_6_MASK
#pragma shader_feature_local _T2M_LAYER_7_MASK
#pragma shader_feature_local _T2M_LAYER_8_MASK
#pragma shader_feature_local _T2M_LAYER_9_MASK
#pragma shader_feature_local _T2M_LAYER_10_MASK
#pragma shader_feature_local _T2M_LAYER_11_MASK
#pragma shader_feature_local _T2M_LAYER_12_MASK
#pragma shader_feature_local _T2M_LAYER_13_MASK
#pragma shader_feature_local _T2M_LAYER_14_MASK
#pragma shader_feature_local _T2M_LAYER_15_MASK

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


#define TERRAIN_TO_MESH_NEED_NORMAL
#define TERRAIN_TO_MESH_NEED_METALLIC_SMOOTHNESS_OCCLUSION


#include "Splatmap.cginc"
        
        // -- Property used by ScenePickingPass
        #ifdef SCENEPICKINGPASS
        float4 _SelectionID;
        #endif
        
        // -- Properties used by SceneSelectionPass
        #ifdef SCENESELECTIONPASS
        int _ObjectId;
        int _PassValue;
        #endif
        
        // Graph Functions
        // GraphFunctions: <None>
        
        // Custom interpolators pre vertex
        /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPreVertex' */
        
        // Graph Vertex
        struct VertexDescription
        {
            float3 Position;
            float3 Normal;
            float3 Tangent;
        };
        
        VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
        {
            VertexDescription description = (VertexDescription)0;
            float3 _SHGTerrainToMeshCurvedWorldCustomFunction_1d12c500e42ebf8b903bf40b7a0a5e2c_vertex_0;
            float3 _SHGTerrainToMeshCurvedWorldCustomFunction_1d12c500e42ebf8b903bf40b7a0a5e2c_normal_4;
            SHG_TerrainToMeshCurvedWorld_float(IN.ObjectSpacePosition, IN.ObjectSpaceNormal, (float4(IN.ObjectSpaceTangent, 1.0)), _SHGTerrainToMeshCurvedWorldCustomFunction_1d12c500e42ebf8b903bf40b7a0a5e2c_vertex_0, _SHGTerrainToMeshCurvedWorldCustomFunction_1d12c500e42ebf8b903bf40b7a0a5e2c_normal_4);
            description.Position = _SHGTerrainToMeshCurvedWorldCustomFunction_1d12c500e42ebf8b903bf40b7a0a5e2c_vertex_0;
            description.Normal = _SHGTerrainToMeshCurvedWorldCustomFunction_1d12c500e42ebf8b903bf40b7a0a5e2c_normal_4;
            description.Tangent = IN.ObjectSpaceTangent;
            return description;
        }
        
        // Custom interpolators, pre surface
        #ifdef FEATURES_GRAPH_VERTEX
        Varyings CustomInterpolatorPassThroughFunc(inout Varyings output, VertexDescription input)
        {
        return output;
        }
        #define CUSTOMINTERPOLATOR_VARYPASSTHROUGH_FUNC
        #endif
        
        // Graph Pixel
        struct SurfaceDescription
        {
        };
        
        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            return surface;
        }
        
        // --------------------------------------------------
        // Build Graph Inputs
        #ifdef HAVE_VFX_MODIFICATION
        #define VFX_SRP_ATTRIBUTES Attributes
        #define VFX_SRP_VARYINGS Varyings
        #define VFX_SRP_SURFACE_INPUTS SurfaceDescriptionInputs
        #endif
        VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
        {
            VertexDescriptionInputs output;
            ZERO_INITIALIZE(VertexDescriptionInputs, output);
        
            output.ObjectSpaceNormal =                          input.normalOS;
            output.ObjectSpaceTangent =                         input.tangentOS.xyz;
            output.ObjectSpacePosition =                        input.positionOS;
        
            return output;
        }
        SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
        {
            SurfaceDescriptionInputs output;
            ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
        
        #ifdef HAVE_VFX_MODIFICATION
            // FragInputs from VFX come from two places: Interpolator or CBuffer.
            /* WARNING: $splice Could not find named fragment 'VFXSetFragInputs' */
        
        #endif
        
            
        
        
        
        
        
        
            #if UNITY_UV_STARTS_AT_TOP
            #else
            #endif
        
        
        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
        #else
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        #endif
        #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        
                return output;
        }
        
        // --------------------------------------------------
        // Main
        
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/SelectionPickingPass.hlsl"
        
        // --------------------------------------------------
        // Visual Effect Vertex Invocations
        #ifdef HAVE_VFX_MODIFICATION
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/VisualEffectVertex.hlsl"
        #endif
        
        ENDHLSL
        }
        Pass
        {
            // Name: <None>
            Tags
            {
                "LightMode" = "Universal2D"
            }
        
        // Render State
        Cull Back
        Blend One Zero
        ZTest LEqual
        ZWrite On
        
        // Debug
        // <None>
        
        // --------------------------------------------------
        // Pass
        
        HLSLPROGRAM
        
        // Pragmas
        #pragma target 4.5
        #pragma exclude_renderers gles gles3 glcore
        #pragma vertex vert
        #pragma fragment frag
        
        // Keywords
        // PassKeywords: <None>
        // GraphKeywords: <None>
        
        // Defines
        
        #define _NORMALMAP 1
        #define _NORMAL_DROPOFF_TS 1
        #define ATTRIBUTES_NEED_NORMAL
        #define ATTRIBUTES_NEED_TANGENT
        #define ATTRIBUTES_NEED_TEXCOORD0
        #define VARYINGS_NEED_TEXCOORD0
        #define FEATURES_GRAPH_VERTEX
        /* WARNING: $splice Could not find named fragment 'PassInstancing' */
        #define SHADERPASS SHADERPASS_2D
        /* WARNING: $splice Could not find named fragment 'DotsInstancingVars' */
        
        
        // custom interpolator pre-include
        /* WARNING: $splice Could not find named fragment 'sgci_CustomInterpolatorPreInclude' */
        
        // Includes
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
        
        // --------------------------------------------------
        // Structs and Packing
        
        // custom interpolators pre packing
        /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPrePacking' */
        
        struct Attributes
        {
             float3 positionOS : POSITION;
             float3 normalOS : NORMAL;
             float4 tangentOS : TANGENT;
             float4 uv0 : TEXCOORD0;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : INSTANCEID_SEMANTIC;
            #endif
        };
        struct Varyings
        {
             float4 positionCS : SV_POSITION;
             float4 texCoord0;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
        };
        struct SurfaceDescriptionInputs
        {
             float4 uv0;
        };
        struct VertexDescriptionInputs
        {
             float3 ObjectSpaceNormal;
             float3 ObjectSpaceTangent;
             float3 ObjectSpacePosition;
        };
        struct PackedVaryings
        {
             float4 positionCS : SV_POSITION;
             float4 interp0 : INTERP0;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
        };
        
        PackedVaryings PackVaryings (Varyings input)
        {
            PackedVaryings output;
            ZERO_INITIALIZE(PackedVaryings, output);
            output.positionCS = input.positionCS;
            output.interp0.xyzw =  input.texCoord0;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        
        Varyings UnpackVaryings (PackedVaryings input)
        {
            Varyings output;
            output.positionCS = input.positionCS;
            output.texCoord0 = input.interp0.xyzw;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        
        
        // --------------------------------------------------
        // Graph
        
        // Graph Properties
        CBUFFER_START(UnityPerMaterial)
        CBUFFER_END
        
        // Object and Global properties
        
        // Graph Includes


//Curved World
//#define CURVEDWORLD_BEND_TYPE_CLASSICRUNNER_X_POSITIVE
//#define CURVEDWORLD_BEND_ID_1
//#pragma shader_feature_local CURVEDWORLD_DISABLED_ON
//#pragma shader_feature_local CURVEDWORLD_NORMAL_TRANSFORMATION_ON
//#include "Assets/Amazing Assets/Curved World/Shaders/Core/CurvedWorldTransform.cginc"


//Terrain To Mesh Keywords//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma shader_feature_local _ _T2M_TEXTURE_SAMPLE_TYPE_ARRAY

#pragma shader_feature_local _ _T2M_LAYER_COUNT_3 _T2M_LAYER_COUNT_4 _T2M_LAYER_COUNT_5 _T2M_LAYER_COUNT_6 _T2M_LAYER_COUNT_7 _T2M_LAYER_COUNT_8 _T2M_LAYER_COUNT_9 _T2M_LAYER_COUNT_10 _T2M_LAYER_COUNT_11 _T2M_LAYER_COUNT_12 _T2M_LAYER_COUNT_13 _T2M_LAYER_COUNT_14 _T2M_LAYER_COUNT_15 _T2M_LAYER_COUNT_16
		
#pragma shader_feature_local _T2M_LAYER_0_NORMAL
#pragma shader_feature_local _T2M_LAYER_1_NORMAL
#pragma shader_feature_local _T2M_LAYER_2_NORMAL
#pragma shader_feature_local _T2M_LAYER_3_NORMAL
#pragma shader_feature_local _T2M_LAYER_4_NORMAL
#pragma shader_feature_local _T2M_LAYER_5_NORMAL
#pragma shader_feature_local _T2M_LAYER_6_NORMAL
#pragma shader_feature_local _T2M_LAYER_7_NORMAL
#pragma shader_feature_local _T2M_LAYER_8_NORMAL
#pragma shader_feature_local _T2M_LAYER_9_NORMAL
#pragma shader_feature_local _T2M_LAYER_10_NORMAL
#pragma shader_feature_local _T2M_LAYER_11_NORMAL
#pragma shader_feature_local _T2M_LAYER_12_NORMAL
#pragma shader_feature_local _T2M_LAYER_13_NORMAL
#pragma shader_feature_local _T2M_LAYER_14_NORMAL
#pragma shader_feature_local _T2M_LAYER_15_NORMAL

#pragma shader_feature_local _T2M_LAYER_0_MASK
#pragma shader_feature_local _T2M_LAYER_1_MASK
#pragma shader_feature_local _T2M_LAYER_2_MASK
#pragma shader_feature_local _T2M_LAYER_3_MASK
#pragma shader_feature_local _T2M_LAYER_4_MASK
#pragma shader_feature_local _T2M_LAYER_5_MASK
#pragma shader_feature_local _T2M_LAYER_6_MASK
#pragma shader_feature_local _T2M_LAYER_7_MASK
#pragma shader_feature_local _T2M_LAYER_8_MASK
#pragma shader_feature_local _T2M_LAYER_9_MASK
#pragma shader_feature_local _T2M_LAYER_10_MASK
#pragma shader_feature_local _T2M_LAYER_11_MASK
#pragma shader_feature_local _T2M_LAYER_12_MASK
#pragma shader_feature_local _T2M_LAYER_13_MASK
#pragma shader_feature_local _T2M_LAYER_14_MASK
#pragma shader_feature_local _T2M_LAYER_15_MASK

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


#define TERRAIN_TO_MESH_NEED_NORMAL
#define TERRAIN_TO_MESH_NEED_METALLIC_SMOOTHNESS_OCCLUSION


#include "Splatmap.cginc"
        
        // -- Property used by ScenePickingPass
        #ifdef SCENEPICKINGPASS
        float4 _SelectionID;
        #endif
        
        // -- Properties used by SceneSelectionPass
        #ifdef SCENESELECTIONPASS
        int _ObjectId;
        int _PassValue;
        #endif
        
        // Graph Functions
        // GraphFunctions: <None>
        
        // Custom interpolators pre vertex
        /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPreVertex' */
        
        // Graph Vertex
        struct VertexDescription
        {
            float3 Position;
            float3 Normal;
            float3 Tangent;
        };
        
        VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
        {
            VertexDescription description = (VertexDescription)0;
            float3 _SHGTerrainToMeshCurvedWorldCustomFunction_1d12c500e42ebf8b903bf40b7a0a5e2c_vertex_0;
            float3 _SHGTerrainToMeshCurvedWorldCustomFunction_1d12c500e42ebf8b903bf40b7a0a5e2c_normal_4;
            SHG_TerrainToMeshCurvedWorld_float(IN.ObjectSpacePosition, IN.ObjectSpaceNormal, (float4(IN.ObjectSpaceTangent, 1.0)), _SHGTerrainToMeshCurvedWorldCustomFunction_1d12c500e42ebf8b903bf40b7a0a5e2c_vertex_0, _SHGTerrainToMeshCurvedWorldCustomFunction_1d12c500e42ebf8b903bf40b7a0a5e2c_normal_4);
            description.Position = _SHGTerrainToMeshCurvedWorldCustomFunction_1d12c500e42ebf8b903bf40b7a0a5e2c_vertex_0;
            description.Normal = _SHGTerrainToMeshCurvedWorldCustomFunction_1d12c500e42ebf8b903bf40b7a0a5e2c_normal_4;
            description.Tangent = IN.ObjectSpaceTangent;
            return description;
        }
        
        // Custom interpolators, pre surface
        #ifdef FEATURES_GRAPH_VERTEX
        Varyings CustomInterpolatorPassThroughFunc(inout Varyings output, VertexDescription input)
        {
        return output;
        }
        #define CUSTOMINTERPOLATOR_VARYPASSTHROUGH_FUNC
        #endif
        
        // Graph Pixel
        struct SurfaceDescription
        {
            float3 BaseColor;
        };
        
        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            float4 _UV_d56c6fdf7ac2828fa944da2372119006_Out_0 = IN.uv0;
            float3 _SHGTerrainToMeshCalculateLayersBlendCustomFunction_24112ec2b2aa8c829e8ab4bb7ea28f60_albedo_1;
            float _SHGTerrainToMeshCalculateLayersBlendCustomFunction_24112ec2b2aa8c829e8ab4bb7ea28f60_alpha_2;
            float3 _SHGTerrainToMeshCalculateLayersBlendCustomFunction_24112ec2b2aa8c829e8ab4bb7ea28f60_normal_3;
            float _SHGTerrainToMeshCalculateLayersBlendCustomFunction_24112ec2b2aa8c829e8ab4bb7ea28f60_metallic_4;
            float _SHGTerrainToMeshCalculateLayersBlendCustomFunction_24112ec2b2aa8c829e8ab4bb7ea28f60_smoothness_5;
            float _SHGTerrainToMeshCalculateLayersBlendCustomFunction_24112ec2b2aa8c829e8ab4bb7ea28f60_occlusion_6;
            SHG_TerrainToMeshCalculateLayersBlend_float(_UV_d56c6fdf7ac2828fa944da2372119006_Out_0, _SHGTerrainToMeshCalculateLayersBlendCustomFunction_24112ec2b2aa8c829e8ab4bb7ea28f60_albedo_1, _SHGTerrainToMeshCalculateLayersBlendCustomFunction_24112ec2b2aa8c829e8ab4bb7ea28f60_alpha_2, _SHGTerrainToMeshCalculateLayersBlendCustomFunction_24112ec2b2aa8c829e8ab4bb7ea28f60_normal_3, _SHGTerrainToMeshCalculateLayersBlendCustomFunction_24112ec2b2aa8c829e8ab4bb7ea28f60_metallic_4, _SHGTerrainToMeshCalculateLayersBlendCustomFunction_24112ec2b2aa8c829e8ab4bb7ea28f60_smoothness_5, _SHGTerrainToMeshCalculateLayersBlendCustomFunction_24112ec2b2aa8c829e8ab4bb7ea28f60_occlusion_6);
            surface.BaseColor = _SHGTerrainToMeshCalculateLayersBlendCustomFunction_24112ec2b2aa8c829e8ab4bb7ea28f60_albedo_1;
            return surface;
        }
        
        // --------------------------------------------------
        // Build Graph Inputs
        #ifdef HAVE_VFX_MODIFICATION
        #define VFX_SRP_ATTRIBUTES Attributes
        #define VFX_SRP_VARYINGS Varyings
        #define VFX_SRP_SURFACE_INPUTS SurfaceDescriptionInputs
        #endif
        VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
        {
            VertexDescriptionInputs output;
            ZERO_INITIALIZE(VertexDescriptionInputs, output);
        
            output.ObjectSpaceNormal =                          input.normalOS;
            output.ObjectSpaceTangent =                         input.tangentOS.xyz;
            output.ObjectSpacePosition =                        input.positionOS;
        
            return output;
        }
        SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
        {
            SurfaceDescriptionInputs output;
            ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
        
        #ifdef HAVE_VFX_MODIFICATION
            // FragInputs from VFX come from two places: Interpolator or CBuffer.
            /* WARNING: $splice Could not find named fragment 'VFXSetFragInputs' */
        
        #endif
        
            
        
        
        
        
        
        
            #if UNITY_UV_STARTS_AT_TOP
            #else
            #endif
        
        
            output.uv0 = input.texCoord0;
        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
        #else
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        #endif
        #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        
                return output;
        }
        
        // --------------------------------------------------
        // Main
        
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/PBR2DPass.hlsl"
        
        // --------------------------------------------------
        // Visual Effect Vertex Invocations
        #ifdef HAVE_VFX_MODIFICATION
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/VisualEffectVertex.hlsl"
        #endif
        
        ENDHLSL
        }
    }
    SubShader
    {
        Tags
        {
            "RenderPipeline"="UniversalPipeline"
            "RenderType"="Opaque"
            "UniversalMaterialType" = "Lit"
            "Queue"="Geometry"
            "ShaderGraphShader"="true"
            "ShaderGraphTargetId"="UniversalLitSubTarget"
        }
        Pass
        {
            Name "Universal Forward"
            Tags
            {
                "LightMode" = "UniversalForward"
            }
        
        // Render State
        Cull Back
        Blend One Zero
        ZTest LEqual
        ZWrite On
        
        // Debug
        // <None>
        
        // --------------------------------------------------
        // Pass
        
        HLSLPROGRAM
        
        // Pragmas
        #pragma target 3.5
        #pragma only_renderers gles gles3 glcore d3d11
        #pragma multi_compile_instancing
        #pragma multi_compile_fog
        #pragma instancing_options renderinglayer
        #pragma vertex vert
        #pragma fragment frag
        
        // Keywords
        #pragma multi_compile_fragment _ _SCREEN_SPACE_OCCLUSION
        #pragma multi_compile _ LIGHTMAP_ON
        #pragma multi_compile _ DYNAMICLIGHTMAP_ON
        #pragma multi_compile _ DIRLIGHTMAP_COMBINED
        #pragma multi_compile _ _MAIN_LIGHT_SHADOWS _MAIN_LIGHT_SHADOWS_CASCADE _MAIN_LIGHT_SHADOWS_SCREEN
        #pragma multi_compile _ _ADDITIONAL_LIGHTS_VERTEX _ADDITIONAL_LIGHTS
        #pragma multi_compile_fragment _ _ADDITIONAL_LIGHT_SHADOWS
        #pragma multi_compile_fragment _ _REFLECTION_PROBE_BLENDING
        #pragma multi_compile_fragment _ _REFLECTION_PROBE_BOX_PROJECTION
        #pragma multi_compile_fragment _ _SHADOWS_SOFT
        #pragma multi_compile _ LIGHTMAP_SHADOW_MIXING
        #pragma multi_compile _ SHADOWS_SHADOWMASK
        #pragma multi_compile_fragment _ _DBUFFER_MRT1 _DBUFFER_MRT2 _DBUFFER_MRT3
        #pragma multi_compile_fragment _ _LIGHT_LAYERS
        #pragma multi_compile_fragment _ DEBUG_DISPLAY
        #pragma multi_compile_fragment _ _LIGHT_COOKIES
        #pragma multi_compile _ _CLUSTERED_RENDERING
        // GraphKeywords: <None>
        
        // Defines
        
        #define _NORMALMAP 1
        #define _NORMAL_DROPOFF_TS 1
        #define ATTRIBUTES_NEED_NORMAL
        #define ATTRIBUTES_NEED_TANGENT
        #define ATTRIBUTES_NEED_TEXCOORD0
        #define ATTRIBUTES_NEED_TEXCOORD1
        #define ATTRIBUTES_NEED_TEXCOORD2
        #define VARYINGS_NEED_POSITION_WS
        #define VARYINGS_NEED_NORMAL_WS
        #define VARYINGS_NEED_TANGENT_WS
        #define VARYINGS_NEED_TEXCOORD0
        #define VARYINGS_NEED_FOG_AND_VERTEX_LIGHT
        #define VARYINGS_NEED_SHADOW_COORD
        #define FEATURES_GRAPH_VERTEX
        /* WARNING: $splice Could not find named fragment 'PassInstancing' */
        #define SHADERPASS SHADERPASS_FORWARD
        #define _FOG_FRAGMENT 1
        /* WARNING: $splice Could not find named fragment 'DotsInstancingVars' */
        
        
        // custom interpolator pre-include
        /* WARNING: $splice Could not find named fragment 'sgci_CustomInterpolatorPreInclude' */
        
        // Includes
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Shadows.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/DBuffer.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
        
        // --------------------------------------------------
        // Structs and Packing
        
        // custom interpolators pre packing
        /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPrePacking' */
        
        struct Attributes
        {
             float3 positionOS : POSITION;
             float3 normalOS : NORMAL;
             float4 tangentOS : TANGENT;
             float4 uv0 : TEXCOORD0;
             float4 uv1 : TEXCOORD1;
             float4 uv2 : TEXCOORD2;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : INSTANCEID_SEMANTIC;
            #endif
        };
        struct Varyings
        {
             float4 positionCS : SV_POSITION;
             float3 positionWS;
             float3 normalWS;
             float4 tangentWS;
             float4 texCoord0;
            #if defined(LIGHTMAP_ON)
             float2 staticLightmapUV;
            #endif
            #if defined(DYNAMICLIGHTMAP_ON)
             float2 dynamicLightmapUV;
            #endif
            #if !defined(LIGHTMAP_ON)
             float3 sh;
            #endif
             float4 fogFactorAndVertexLight;
            #if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
             float4 shadowCoord;
            #endif
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
        };
        struct SurfaceDescriptionInputs
        {
             float3 TangentSpaceNormal;
             float4 uv0;
        };
        struct VertexDescriptionInputs
        {
             float3 ObjectSpaceNormal;
             float3 ObjectSpaceTangent;
             float3 ObjectSpacePosition;
        };
        struct PackedVaryings
        {
             float4 positionCS : SV_POSITION;
             float3 interp0 : INTERP0;
             float3 interp1 : INTERP1;
             float4 interp2 : INTERP2;
             float4 interp3 : INTERP3;
             float2 interp4 : INTERP4;
             float2 interp5 : INTERP5;
             float3 interp6 : INTERP6;
             float4 interp7 : INTERP7;
             float4 interp8 : INTERP8;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
        };
        
        PackedVaryings PackVaryings (Varyings input)
        {
            PackedVaryings output;
            ZERO_INITIALIZE(PackedVaryings, output);
            output.positionCS = input.positionCS;
            output.interp0.xyz =  input.positionWS;
            output.interp1.xyz =  input.normalWS;
            output.interp2.xyzw =  input.tangentWS;
            output.interp3.xyzw =  input.texCoord0;
            #if defined(LIGHTMAP_ON)
            output.interp4.xy =  input.staticLightmapUV;
            #endif
            #if defined(DYNAMICLIGHTMAP_ON)
            output.interp5.xy =  input.dynamicLightmapUV;
            #endif
            #if !defined(LIGHTMAP_ON)
            output.interp6.xyz =  input.sh;
            #endif
            output.interp7.xyzw =  input.fogFactorAndVertexLight;
            #if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
            output.interp8.xyzw =  input.shadowCoord;
            #endif
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        
        Varyings UnpackVaryings (PackedVaryings input)
        {
            Varyings output;
            output.positionCS = input.positionCS;
            output.positionWS = input.interp0.xyz;
            output.normalWS = input.interp1.xyz;
            output.tangentWS = input.interp2.xyzw;
            output.texCoord0 = input.interp3.xyzw;
            #if defined(LIGHTMAP_ON)
            output.staticLightmapUV = input.interp4.xy;
            #endif
            #if defined(DYNAMICLIGHTMAP_ON)
            output.dynamicLightmapUV = input.interp5.xy;
            #endif
            #if !defined(LIGHTMAP_ON)
            output.sh = input.interp6.xyz;
            #endif
            output.fogFactorAndVertexLight = input.interp7.xyzw;
            #if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
            output.shadowCoord = input.interp8.xyzw;
            #endif
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        
        
        // --------------------------------------------------
        // Graph
        
        // Graph Properties
        CBUFFER_START(UnityPerMaterial)
        CBUFFER_END
        
        // Object and Global properties
        
        // Graph Includes


//Curved World
//#define CURVEDWORLD_BEND_TYPE_CLASSICRUNNER_X_POSITIVE
//#define CURVEDWORLD_BEND_ID_1
//#pragma shader_feature_local CURVEDWORLD_DISABLED_ON
//#pragma shader_feature_local CURVEDWORLD_NORMAL_TRANSFORMATION_ON
//#include "Assets/Amazing Assets/Curved World/Shaders/Core/CurvedWorldTransform.cginc"


//Terrain To Mesh Keywords//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma shader_feature_local _ _T2M_TEXTURE_SAMPLE_TYPE_ARRAY

#pragma shader_feature_local _ _T2M_LAYER_COUNT_3 _T2M_LAYER_COUNT_4 _T2M_LAYER_COUNT_5 _T2M_LAYER_COUNT_6 _T2M_LAYER_COUNT_7 _T2M_LAYER_COUNT_8 _T2M_LAYER_COUNT_9 _T2M_LAYER_COUNT_10 _T2M_LAYER_COUNT_11 _T2M_LAYER_COUNT_12 _T2M_LAYER_COUNT_13 _T2M_LAYER_COUNT_14 _T2M_LAYER_COUNT_15 _T2M_LAYER_COUNT_16
		
#pragma shader_feature_local _T2M_LAYER_0_NORMAL
#pragma shader_feature_local _T2M_LAYER_1_NORMAL
#pragma shader_feature_local _T2M_LAYER_2_NORMAL
#pragma shader_feature_local _T2M_LAYER_3_NORMAL
#pragma shader_feature_local _T2M_LAYER_4_NORMAL
#pragma shader_feature_local _T2M_LAYER_5_NORMAL
#pragma shader_feature_local _T2M_LAYER_6_NORMAL
#pragma shader_feature_local _T2M_LAYER_7_NORMAL
#pragma shader_feature_local _T2M_LAYER_8_NORMAL
#pragma shader_feature_local _T2M_LAYER_9_NORMAL
#pragma shader_feature_local _T2M_LAYER_10_NORMAL
#pragma shader_feature_local _T2M_LAYER_11_NORMAL
#pragma shader_feature_local _T2M_LAYER_12_NORMAL
#pragma shader_feature_local _T2M_LAYER_13_NORMAL
#pragma shader_feature_local _T2M_LAYER_14_NORMAL
#pragma shader_feature_local _T2M_LAYER_15_NORMAL

#pragma shader_feature_local _T2M_LAYER_0_MASK
#pragma shader_feature_local _T2M_LAYER_1_MASK
#pragma shader_feature_local _T2M_LAYER_2_MASK
#pragma shader_feature_local _T2M_LAYER_3_MASK
#pragma shader_feature_local _T2M_LAYER_4_MASK
#pragma shader_feature_local _T2M_LAYER_5_MASK
#pragma shader_feature_local _T2M_LAYER_6_MASK
#pragma shader_feature_local _T2M_LAYER_7_MASK
#pragma shader_feature_local _T2M_LAYER_8_MASK
#pragma shader_feature_local _T2M_LAYER_9_MASK
#pragma shader_feature_local _T2M_LAYER_10_MASK
#pragma shader_feature_local _T2M_LAYER_11_MASK
#pragma shader_feature_local _T2M_LAYER_12_MASK
#pragma shader_feature_local _T2M_LAYER_13_MASK
#pragma shader_feature_local _T2M_LAYER_14_MASK
#pragma shader_feature_local _T2M_LAYER_15_MASK

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


#define TERRAIN_TO_MESH_NEED_NORMAL
#define TERRAIN_TO_MESH_NEED_METALLIC_SMOOTHNESS_OCCLUSION


#include "Splatmap.cginc"
        
        // -- Property used by ScenePickingPass
        #ifdef SCENEPICKINGPASS
        float4 _SelectionID;
        #endif
        
        // -- Properties used by SceneSelectionPass
        #ifdef SCENESELECTIONPASS
        int _ObjectId;
        int _PassValue;
        #endif
        
        // Graph Functions
        // GraphFunctions: <None>
        
        // Custom interpolators pre vertex
        /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPreVertex' */
        
        // Graph Vertex
        struct VertexDescription
        {
            float3 Position;
            float3 Normal;
            float3 Tangent;
        };
        
        VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
        {
            VertexDescription description = (VertexDescription)0;
            float3 _SHGTerrainToMeshCurvedWorldCustomFunction_1d12c500e42ebf8b903bf40b7a0a5e2c_vertex_0;
            float3 _SHGTerrainToMeshCurvedWorldCustomFunction_1d12c500e42ebf8b903bf40b7a0a5e2c_normal_4;
            SHG_TerrainToMeshCurvedWorld_float(IN.ObjectSpacePosition, IN.ObjectSpaceNormal, (float4(IN.ObjectSpaceTangent, 1.0)), _SHGTerrainToMeshCurvedWorldCustomFunction_1d12c500e42ebf8b903bf40b7a0a5e2c_vertex_0, _SHGTerrainToMeshCurvedWorldCustomFunction_1d12c500e42ebf8b903bf40b7a0a5e2c_normal_4);
            description.Position = _SHGTerrainToMeshCurvedWorldCustomFunction_1d12c500e42ebf8b903bf40b7a0a5e2c_vertex_0;
            description.Normal = _SHGTerrainToMeshCurvedWorldCustomFunction_1d12c500e42ebf8b903bf40b7a0a5e2c_normal_4;
            description.Tangent = IN.ObjectSpaceTangent;
            return description;
        }
        
        // Custom interpolators, pre surface
        #ifdef FEATURES_GRAPH_VERTEX
        Varyings CustomInterpolatorPassThroughFunc(inout Varyings output, VertexDescription input)
        {
        return output;
        }
        #define CUSTOMINTERPOLATOR_VARYPASSTHROUGH_FUNC
        #endif
        
        // Graph Pixel
        struct SurfaceDescription
        {
            float3 BaseColor;
            float3 NormalTS;
            float3 Emission;
            float Metallic;
            float Smoothness;
            float Occlusion;
        };
        
        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            float4 _UV_d56c6fdf7ac2828fa944da2372119006_Out_0 = IN.uv0;
            float3 _SHGTerrainToMeshCalculateLayersBlendCustomFunction_24112ec2b2aa8c829e8ab4bb7ea28f60_albedo_1;
            float _SHGTerrainToMeshCalculateLayersBlendCustomFunction_24112ec2b2aa8c829e8ab4bb7ea28f60_alpha_2;
            float3 _SHGTerrainToMeshCalculateLayersBlendCustomFunction_24112ec2b2aa8c829e8ab4bb7ea28f60_normal_3;
            float _SHGTerrainToMeshCalculateLayersBlendCustomFunction_24112ec2b2aa8c829e8ab4bb7ea28f60_metallic_4;
            float _SHGTerrainToMeshCalculateLayersBlendCustomFunction_24112ec2b2aa8c829e8ab4bb7ea28f60_smoothness_5;
            float _SHGTerrainToMeshCalculateLayersBlendCustomFunction_24112ec2b2aa8c829e8ab4bb7ea28f60_occlusion_6;
            SHG_TerrainToMeshCalculateLayersBlend_float(_UV_d56c6fdf7ac2828fa944da2372119006_Out_0, _SHGTerrainToMeshCalculateLayersBlendCustomFunction_24112ec2b2aa8c829e8ab4bb7ea28f60_albedo_1, _SHGTerrainToMeshCalculateLayersBlendCustomFunction_24112ec2b2aa8c829e8ab4bb7ea28f60_alpha_2, _SHGTerrainToMeshCalculateLayersBlendCustomFunction_24112ec2b2aa8c829e8ab4bb7ea28f60_normal_3, _SHGTerrainToMeshCalculateLayersBlendCustomFunction_24112ec2b2aa8c829e8ab4bb7ea28f60_metallic_4, _SHGTerrainToMeshCalculateLayersBlendCustomFunction_24112ec2b2aa8c829e8ab4bb7ea28f60_smoothness_5, _SHGTerrainToMeshCalculateLayersBlendCustomFunction_24112ec2b2aa8c829e8ab4bb7ea28f60_occlusion_6);
            surface.BaseColor = _SHGTerrainToMeshCalculateLayersBlendCustomFunction_24112ec2b2aa8c829e8ab4bb7ea28f60_albedo_1;
            surface.NormalTS = _SHGTerrainToMeshCalculateLayersBlendCustomFunction_24112ec2b2aa8c829e8ab4bb7ea28f60_normal_3;
            surface.Emission = float3(0, 0, 0);
            surface.Metallic = _SHGTerrainToMeshCalculateLayersBlendCustomFunction_24112ec2b2aa8c829e8ab4bb7ea28f60_metallic_4;
            surface.Smoothness = _SHGTerrainToMeshCalculateLayersBlendCustomFunction_24112ec2b2aa8c829e8ab4bb7ea28f60_smoothness_5;
            surface.Occlusion = _SHGTerrainToMeshCalculateLayersBlendCustomFunction_24112ec2b2aa8c829e8ab4bb7ea28f60_occlusion_6;
            return surface;
        }
        
        // --------------------------------------------------
        // Build Graph Inputs
        #ifdef HAVE_VFX_MODIFICATION
        #define VFX_SRP_ATTRIBUTES Attributes
        #define VFX_SRP_VARYINGS Varyings
        #define VFX_SRP_SURFACE_INPUTS SurfaceDescriptionInputs
        #endif
        VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
        {
            VertexDescriptionInputs output;
            ZERO_INITIALIZE(VertexDescriptionInputs, output);
        
            output.ObjectSpaceNormal =                          input.normalOS;
            output.ObjectSpaceTangent =                         input.tangentOS.xyz;
            output.ObjectSpacePosition =                        input.positionOS;
        
            return output;
        }
        SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
        {
            SurfaceDescriptionInputs output;
            ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
        
        #ifdef HAVE_VFX_MODIFICATION
            // FragInputs from VFX come from two places: Interpolator or CBuffer.
            /* WARNING: $splice Could not find named fragment 'VFXSetFragInputs' */
        
        #endif
        
            
        
        
        
            output.TangentSpaceNormal = float3(0.0f, 0.0f, 1.0f);
        
        
        
            #if UNITY_UV_STARTS_AT_TOP
            #else
            #endif
        
        
            output.uv0 = input.texCoord0;
        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
        #else
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        #endif
        #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        
                return output;
        }
        
        // --------------------------------------------------
        // Main
        
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/PBRForwardPass.hlsl"
        
        // --------------------------------------------------
        // Visual Effect Vertex Invocations
        #ifdef HAVE_VFX_MODIFICATION
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/VisualEffectVertex.hlsl"
        #endif
        
        ENDHLSL
        }
        Pass
        {
            Name "ShadowCaster"
            Tags
            {
                "LightMode" = "ShadowCaster"
            }
        
        // Render State
        Cull Back
        ZTest LEqual
        ZWrite On
        ColorMask 0
        
        // Debug
        // <None>
        
        // --------------------------------------------------
        // Pass
        
        HLSLPROGRAM
        
        // Pragmas
        #pragma target 3.5
        #pragma only_renderers gles gles3 glcore d3d11
        #pragma multi_compile_instancing
        #pragma vertex vert
        #pragma fragment frag
        
        // Keywords
        #pragma multi_compile_vertex _ _CASTING_PUNCTUAL_LIGHT_SHADOW
        // GraphKeywords: <None>
        
        // Defines
        
        #define _NORMALMAP 1
        #define _NORMAL_DROPOFF_TS 1
        #define ATTRIBUTES_NEED_NORMAL
        #define ATTRIBUTES_NEED_TANGENT
        #define VARYINGS_NEED_NORMAL_WS
        #define FEATURES_GRAPH_VERTEX
        /* WARNING: $splice Could not find named fragment 'PassInstancing' */
        #define SHADERPASS SHADERPASS_SHADOWCASTER
        /* WARNING: $splice Could not find named fragment 'DotsInstancingVars' */
        
        
        // custom interpolator pre-include
        /* WARNING: $splice Could not find named fragment 'sgci_CustomInterpolatorPreInclude' */
        
        // Includes
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
        
        // --------------------------------------------------
        // Structs and Packing
        
        // custom interpolators pre packing
        /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPrePacking' */
        
        struct Attributes
        {
             float3 positionOS : POSITION;
             float3 normalOS : NORMAL;
             float4 tangentOS : TANGENT;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : INSTANCEID_SEMANTIC;
            #endif
        };
        struct Varyings
        {
             float4 positionCS : SV_POSITION;
             float3 normalWS;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
        };
        struct SurfaceDescriptionInputs
        {
        };
        struct VertexDescriptionInputs
        {
             float3 ObjectSpaceNormal;
             float3 ObjectSpaceTangent;
             float3 ObjectSpacePosition;
        };
        struct PackedVaryings
        {
             float4 positionCS : SV_POSITION;
             float3 interp0 : INTERP0;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
        };
        
        PackedVaryings PackVaryings (Varyings input)
        {
            PackedVaryings output;
            ZERO_INITIALIZE(PackedVaryings, output);
            output.positionCS = input.positionCS;
            output.interp0.xyz =  input.normalWS;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        
        Varyings UnpackVaryings (PackedVaryings input)
        {
            Varyings output;
            output.positionCS = input.positionCS;
            output.normalWS = input.interp0.xyz;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        
        
        // --------------------------------------------------
        // Graph
        
        // Graph Properties
        CBUFFER_START(UnityPerMaterial)
        CBUFFER_END
        
        // Object and Global properties
        
        // Graph Includes


//Curved World
//#define CURVEDWORLD_BEND_TYPE_CLASSICRUNNER_X_POSITIVE
//#define CURVEDWORLD_BEND_ID_1
//#pragma shader_feature_local CURVEDWORLD_DISABLED_ON
//#pragma shader_feature_local CURVEDWORLD_NORMAL_TRANSFORMATION_ON
//#include "Assets/Amazing Assets/Curved World/Shaders/Core/CurvedWorldTransform.cginc"


//Terrain To Mesh Keywords//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma shader_feature_local _ _T2M_TEXTURE_SAMPLE_TYPE_ARRAY

#pragma shader_feature_local _ _T2M_LAYER_COUNT_3 _T2M_LAYER_COUNT_4 _T2M_LAYER_COUNT_5 _T2M_LAYER_COUNT_6 _T2M_LAYER_COUNT_7 _T2M_LAYER_COUNT_8 _T2M_LAYER_COUNT_9 _T2M_LAYER_COUNT_10 _T2M_LAYER_COUNT_11 _T2M_LAYER_COUNT_12 _T2M_LAYER_COUNT_13 _T2M_LAYER_COUNT_14 _T2M_LAYER_COUNT_15 _T2M_LAYER_COUNT_16
		
#pragma shader_feature_local _T2M_LAYER_0_NORMAL
#pragma shader_feature_local _T2M_LAYER_1_NORMAL
#pragma shader_feature_local _T2M_LAYER_2_NORMAL
#pragma shader_feature_local _T2M_LAYER_3_NORMAL
#pragma shader_feature_local _T2M_LAYER_4_NORMAL
#pragma shader_feature_local _T2M_LAYER_5_NORMAL
#pragma shader_feature_local _T2M_LAYER_6_NORMAL
#pragma shader_feature_local _T2M_LAYER_7_NORMAL
#pragma shader_feature_local _T2M_LAYER_8_NORMAL
#pragma shader_feature_local _T2M_LAYER_9_NORMAL
#pragma shader_feature_local _T2M_LAYER_10_NORMAL
#pragma shader_feature_local _T2M_LAYER_11_NORMAL
#pragma shader_feature_local _T2M_LAYER_12_NORMAL
#pragma shader_feature_local _T2M_LAYER_13_NORMAL
#pragma shader_feature_local _T2M_LAYER_14_NORMAL
#pragma shader_feature_local _T2M_LAYER_15_NORMAL

#pragma shader_feature_local _T2M_LAYER_0_MASK
#pragma shader_feature_local _T2M_LAYER_1_MASK
#pragma shader_feature_local _T2M_LAYER_2_MASK
#pragma shader_feature_local _T2M_LAYER_3_MASK
#pragma shader_feature_local _T2M_LAYER_4_MASK
#pragma shader_feature_local _T2M_LAYER_5_MASK
#pragma shader_feature_local _T2M_LAYER_6_MASK
#pragma shader_feature_local _T2M_LAYER_7_MASK
#pragma shader_feature_local _T2M_LAYER_8_MASK
#pragma shader_feature_local _T2M_LAYER_9_MASK
#pragma shader_feature_local _T2M_LAYER_10_MASK
#pragma shader_feature_local _T2M_LAYER_11_MASK
#pragma shader_feature_local _T2M_LAYER_12_MASK
#pragma shader_feature_local _T2M_LAYER_13_MASK
#pragma shader_feature_local _T2M_LAYER_14_MASK
#pragma shader_feature_local _T2M_LAYER_15_MASK

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


#define TERRAIN_TO_MESH_NEED_NORMAL
#define TERRAIN_TO_MESH_NEED_METALLIC_SMOOTHNESS_OCCLUSION


#include "Splatmap.cginc"
        
        // -- Property used by ScenePickingPass
        #ifdef SCENEPICKINGPASS
        float4 _SelectionID;
        #endif
        
        // -- Properties used by SceneSelectionPass
        #ifdef SCENESELECTIONPASS
        int _ObjectId;
        int _PassValue;
        #endif
        
        // Graph Functions
        // GraphFunctions: <None>
        
        // Custom interpolators pre vertex
        /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPreVertex' */
        
        // Graph Vertex
        struct VertexDescription
        {
            float3 Position;
            float3 Normal;
            float3 Tangent;
        };
        
        VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
        {
            VertexDescription description = (VertexDescription)0;
            float3 _SHGTerrainToMeshCurvedWorldCustomFunction_1d12c500e42ebf8b903bf40b7a0a5e2c_vertex_0;
            float3 _SHGTerrainToMeshCurvedWorldCustomFunction_1d12c500e42ebf8b903bf40b7a0a5e2c_normal_4;
            SHG_TerrainToMeshCurvedWorld_float(IN.ObjectSpacePosition, IN.ObjectSpaceNormal, (float4(IN.ObjectSpaceTangent, 1.0)), _SHGTerrainToMeshCurvedWorldCustomFunction_1d12c500e42ebf8b903bf40b7a0a5e2c_vertex_0, _SHGTerrainToMeshCurvedWorldCustomFunction_1d12c500e42ebf8b903bf40b7a0a5e2c_normal_4);
            description.Position = _SHGTerrainToMeshCurvedWorldCustomFunction_1d12c500e42ebf8b903bf40b7a0a5e2c_vertex_0;
            description.Normal = _SHGTerrainToMeshCurvedWorldCustomFunction_1d12c500e42ebf8b903bf40b7a0a5e2c_normal_4;
            description.Tangent = IN.ObjectSpaceTangent;
            return description;
        }
        
        // Custom interpolators, pre surface
        #ifdef FEATURES_GRAPH_VERTEX
        Varyings CustomInterpolatorPassThroughFunc(inout Varyings output, VertexDescription input)
        {
        return output;
        }
        #define CUSTOMINTERPOLATOR_VARYPASSTHROUGH_FUNC
        #endif
        
        // Graph Pixel
        struct SurfaceDescription
        {
        };
        
        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            return surface;
        }
        
        // --------------------------------------------------
        // Build Graph Inputs
        #ifdef HAVE_VFX_MODIFICATION
        #define VFX_SRP_ATTRIBUTES Attributes
        #define VFX_SRP_VARYINGS Varyings
        #define VFX_SRP_SURFACE_INPUTS SurfaceDescriptionInputs
        #endif
        VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
        {
            VertexDescriptionInputs output;
            ZERO_INITIALIZE(VertexDescriptionInputs, output);
        
            output.ObjectSpaceNormal =                          input.normalOS;
            output.ObjectSpaceTangent =                         input.tangentOS.xyz;
            output.ObjectSpacePosition =                        input.positionOS;
        
            return output;
        }
        SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
        {
            SurfaceDescriptionInputs output;
            ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
        
        #ifdef HAVE_VFX_MODIFICATION
            // FragInputs from VFX come from two places: Interpolator or CBuffer.
            /* WARNING: $splice Could not find named fragment 'VFXSetFragInputs' */
        
        #endif
        
            
        
        
        
        
        
        
            #if UNITY_UV_STARTS_AT_TOP
            #else
            #endif
        
        
        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
        #else
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        #endif
        #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        
                return output;
        }
        
        // --------------------------------------------------
        // Main
        
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShadowCasterPass.hlsl"
        
        // --------------------------------------------------
        // Visual Effect Vertex Invocations
        #ifdef HAVE_VFX_MODIFICATION
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/VisualEffectVertex.hlsl"
        #endif
        
        ENDHLSL
        }
        Pass
        {
            Name "DepthOnly"
            Tags
            {
                "LightMode" = "DepthOnly"
            }
        
        // Render State
        Cull Back
        ZTest LEqual
        ZWrite On
        ColorMask R
        
        // Debug
        // <None>
        
        // --------------------------------------------------
        // Pass
        
        HLSLPROGRAM
        
        // Pragmas
        #pragma target 3.5
        #pragma only_renderers gles gles3 glcore d3d11
        #pragma multi_compile_instancing
        #pragma vertex vert
        #pragma fragment frag
        
        // Keywords
        // PassKeywords: <None>
        // GraphKeywords: <None>
        
        // Defines
        
        #define _NORMALMAP 1
        #define _NORMAL_DROPOFF_TS 1
        #define ATTRIBUTES_NEED_NORMAL
        #define ATTRIBUTES_NEED_TANGENT
        #define FEATURES_GRAPH_VERTEX
        /* WARNING: $splice Could not find named fragment 'PassInstancing' */
        #define SHADERPASS SHADERPASS_DEPTHONLY
        /* WARNING: $splice Could not find named fragment 'DotsInstancingVars' */
        
        
        // custom interpolator pre-include
        /* WARNING: $splice Could not find named fragment 'sgci_CustomInterpolatorPreInclude' */
        
        // Includes
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
        
        // --------------------------------------------------
        // Structs and Packing
        
        // custom interpolators pre packing
        /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPrePacking' */
        
        struct Attributes
        {
             float3 positionOS : POSITION;
             float3 normalOS : NORMAL;
             float4 tangentOS : TANGENT;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : INSTANCEID_SEMANTIC;
            #endif
        };
        struct Varyings
        {
             float4 positionCS : SV_POSITION;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
        };
        struct SurfaceDescriptionInputs
        {
        };
        struct VertexDescriptionInputs
        {
             float3 ObjectSpaceNormal;
             float3 ObjectSpaceTangent;
             float3 ObjectSpacePosition;
        };
        struct PackedVaryings
        {
             float4 positionCS : SV_POSITION;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
        };
        
        PackedVaryings PackVaryings (Varyings input)
        {
            PackedVaryings output;
            ZERO_INITIALIZE(PackedVaryings, output);
            output.positionCS = input.positionCS;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        
        Varyings UnpackVaryings (PackedVaryings input)
        {
            Varyings output;
            output.positionCS = input.positionCS;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        
        
        // --------------------------------------------------
        // Graph
        
        // Graph Properties
        CBUFFER_START(UnityPerMaterial)
        CBUFFER_END
        
        // Object and Global properties
        
        // Graph Includes


//Curved World
//#define CURVEDWORLD_BEND_TYPE_CLASSICRUNNER_X_POSITIVE
//#define CURVEDWORLD_BEND_ID_1
//#pragma shader_feature_local CURVEDWORLD_DISABLED_ON
//#pragma shader_feature_local CURVEDWORLD_NORMAL_TRANSFORMATION_ON
//#include "Assets/Amazing Assets/Curved World/Shaders/Core/CurvedWorldTransform.cginc"


//Terrain To Mesh Keywords//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma shader_feature_local _ _T2M_TEXTURE_SAMPLE_TYPE_ARRAY

#pragma shader_feature_local _ _T2M_LAYER_COUNT_3 _T2M_LAYER_COUNT_4 _T2M_LAYER_COUNT_5 _T2M_LAYER_COUNT_6 _T2M_LAYER_COUNT_7 _T2M_LAYER_COUNT_8 _T2M_LAYER_COUNT_9 _T2M_LAYER_COUNT_10 _T2M_LAYER_COUNT_11 _T2M_LAYER_COUNT_12 _T2M_LAYER_COUNT_13 _T2M_LAYER_COUNT_14 _T2M_LAYER_COUNT_15 _T2M_LAYER_COUNT_16
		
#pragma shader_feature_local _T2M_LAYER_0_NORMAL
#pragma shader_feature_local _T2M_LAYER_1_NORMAL
#pragma shader_feature_local _T2M_LAYER_2_NORMAL
#pragma shader_feature_local _T2M_LAYER_3_NORMAL
#pragma shader_feature_local _T2M_LAYER_4_NORMAL
#pragma shader_feature_local _T2M_LAYER_5_NORMAL
#pragma shader_feature_local _T2M_LAYER_6_NORMAL
#pragma shader_feature_local _T2M_LAYER_7_NORMAL
#pragma shader_feature_local _T2M_LAYER_8_NORMAL
#pragma shader_feature_local _T2M_LAYER_9_NORMAL
#pragma shader_feature_local _T2M_LAYER_10_NORMAL
#pragma shader_feature_local _T2M_LAYER_11_NORMAL
#pragma shader_feature_local _T2M_LAYER_12_NORMAL
#pragma shader_feature_local _T2M_LAYER_13_NORMAL
#pragma shader_feature_local _T2M_LAYER_14_NORMAL
#pragma shader_feature_local _T2M_LAYER_15_NORMAL

#pragma shader_feature_local _T2M_LAYER_0_MASK
#pragma shader_feature_local _T2M_LAYER_1_MASK
#pragma shader_feature_local _T2M_LAYER_2_MASK
#pragma shader_feature_local _T2M_LAYER_3_MASK
#pragma shader_feature_local _T2M_LAYER_4_MASK
#pragma shader_feature_local _T2M_LAYER_5_MASK
#pragma shader_feature_local _T2M_LAYER_6_MASK
#pragma shader_feature_local _T2M_LAYER_7_MASK
#pragma shader_feature_local _T2M_LAYER_8_MASK
#pragma shader_feature_local _T2M_LAYER_9_MASK
#pragma shader_feature_local _T2M_LAYER_10_MASK
#pragma shader_feature_local _T2M_LAYER_11_MASK
#pragma shader_feature_local _T2M_LAYER_12_MASK
#pragma shader_feature_local _T2M_LAYER_13_MASK
#pragma shader_feature_local _T2M_LAYER_14_MASK
#pragma shader_feature_local _T2M_LAYER_15_MASK

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


#define TERRAIN_TO_MESH_NEED_NORMAL
#define TERRAIN_TO_MESH_NEED_METALLIC_SMOOTHNESS_OCCLUSION


#include "Splatmap.cginc"
        
        // -- Property used by ScenePickingPass
        #ifdef SCENEPICKINGPASS
        float4 _SelectionID;
        #endif
        
        // -- Properties used by SceneSelectionPass
        #ifdef SCENESELECTIONPASS
        int _ObjectId;
        int _PassValue;
        #endif
        
        // Graph Functions
        // GraphFunctions: <None>
        
        // Custom interpolators pre vertex
        /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPreVertex' */
        
        // Graph Vertex
        struct VertexDescription
        {
            float3 Position;
            float3 Normal;
            float3 Tangent;
        };
        
        VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
        {
            VertexDescription description = (VertexDescription)0;
            float3 _SHGTerrainToMeshCurvedWorldCustomFunction_1d12c500e42ebf8b903bf40b7a0a5e2c_vertex_0;
            float3 _SHGTerrainToMeshCurvedWorldCustomFunction_1d12c500e42ebf8b903bf40b7a0a5e2c_normal_4;
            SHG_TerrainToMeshCurvedWorld_float(IN.ObjectSpacePosition, IN.ObjectSpaceNormal, (float4(IN.ObjectSpaceTangent, 1.0)), _SHGTerrainToMeshCurvedWorldCustomFunction_1d12c500e42ebf8b903bf40b7a0a5e2c_vertex_0, _SHGTerrainToMeshCurvedWorldCustomFunction_1d12c500e42ebf8b903bf40b7a0a5e2c_normal_4);
            description.Position = _SHGTerrainToMeshCurvedWorldCustomFunction_1d12c500e42ebf8b903bf40b7a0a5e2c_vertex_0;
            description.Normal = _SHGTerrainToMeshCurvedWorldCustomFunction_1d12c500e42ebf8b903bf40b7a0a5e2c_normal_4;
            description.Tangent = IN.ObjectSpaceTangent;
            return description;
        }
        
        // Custom interpolators, pre surface
        #ifdef FEATURES_GRAPH_VERTEX
        Varyings CustomInterpolatorPassThroughFunc(inout Varyings output, VertexDescription input)
        {
        return output;
        }
        #define CUSTOMINTERPOLATOR_VARYPASSTHROUGH_FUNC
        #endif
        
        // Graph Pixel
        struct SurfaceDescription
        {
        };
        
        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            return surface;
        }
        
        // --------------------------------------------------
        // Build Graph Inputs
        #ifdef HAVE_VFX_MODIFICATION
        #define VFX_SRP_ATTRIBUTES Attributes
        #define VFX_SRP_VARYINGS Varyings
        #define VFX_SRP_SURFACE_INPUTS SurfaceDescriptionInputs
        #endif
        VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
        {
            VertexDescriptionInputs output;
            ZERO_INITIALIZE(VertexDescriptionInputs, output);
        
            output.ObjectSpaceNormal =                          input.normalOS;
            output.ObjectSpaceTangent =                         input.tangentOS.xyz;
            output.ObjectSpacePosition =                        input.positionOS;
        
            return output;
        }
        SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
        {
            SurfaceDescriptionInputs output;
            ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
        
        #ifdef HAVE_VFX_MODIFICATION
            // FragInputs from VFX come from two places: Interpolator or CBuffer.
            /* WARNING: $splice Could not find named fragment 'VFXSetFragInputs' */
        
        #endif
        
            
        
        
        
        
        
        
            #if UNITY_UV_STARTS_AT_TOP
            #else
            #endif
        
        
        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
        #else
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        #endif
        #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        
                return output;
        }
        
        // --------------------------------------------------
        // Main
        
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/DepthOnlyPass.hlsl"
        
        // --------------------------------------------------
        // Visual Effect Vertex Invocations
        #ifdef HAVE_VFX_MODIFICATION
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/VisualEffectVertex.hlsl"
        #endif
        
        ENDHLSL
        }
        Pass
        {
            Name "DepthNormals"
            Tags
            {
                "LightMode" = "DepthNormals"
            }
        
        // Render State
        Cull Back
        ZTest LEqual
        ZWrite On
        
        // Debug
        // <None>
        
        // --------------------------------------------------
        // Pass
        
        HLSLPROGRAM
        
        // Pragmas
        #pragma target 3.5
        #pragma only_renderers gles gles3 glcore d3d11
        #pragma multi_compile_instancing
        #pragma vertex vert
        #pragma fragment frag
        
        // Keywords
        // PassKeywords: <None>
        // GraphKeywords: <None>
        
        // Defines
        
        #define _NORMALMAP 1
        #define _NORMAL_DROPOFF_TS 1
        #define ATTRIBUTES_NEED_NORMAL
        #define ATTRIBUTES_NEED_TANGENT
        #define ATTRIBUTES_NEED_TEXCOORD0
        #define ATTRIBUTES_NEED_TEXCOORD1
        #define VARYINGS_NEED_NORMAL_WS
        #define VARYINGS_NEED_TANGENT_WS
        #define VARYINGS_NEED_TEXCOORD0
        #define FEATURES_GRAPH_VERTEX
        /* WARNING: $splice Could not find named fragment 'PassInstancing' */
        #define SHADERPASS SHADERPASS_DEPTHNORMALS
        /* WARNING: $splice Could not find named fragment 'DotsInstancingVars' */
        
        
        // custom interpolator pre-include
        /* WARNING: $splice Could not find named fragment 'sgci_CustomInterpolatorPreInclude' */
        
        // Includes
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
        
        // --------------------------------------------------
        // Structs and Packing
        
        // custom interpolators pre packing
        /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPrePacking' */
        
        struct Attributes
        {
             float3 positionOS : POSITION;
             float3 normalOS : NORMAL;
             float4 tangentOS : TANGENT;
             float4 uv0 : TEXCOORD0;
             float4 uv1 : TEXCOORD1;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : INSTANCEID_SEMANTIC;
            #endif
        };
        struct Varyings
        {
             float4 positionCS : SV_POSITION;
             float3 normalWS;
             float4 tangentWS;
             float4 texCoord0;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
        };
        struct SurfaceDescriptionInputs
        {
             float3 TangentSpaceNormal;
             float4 uv0;
        };
        struct VertexDescriptionInputs
        {
             float3 ObjectSpaceNormal;
             float3 ObjectSpaceTangent;
             float3 ObjectSpacePosition;
        };
        struct PackedVaryings
        {
             float4 positionCS : SV_POSITION;
             float3 interp0 : INTERP0;
             float4 interp1 : INTERP1;
             float4 interp2 : INTERP2;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
        };
        
        PackedVaryings PackVaryings (Varyings input)
        {
            PackedVaryings output;
            ZERO_INITIALIZE(PackedVaryings, output);
            output.positionCS = input.positionCS;
            output.interp0.xyz =  input.normalWS;
            output.interp1.xyzw =  input.tangentWS;
            output.interp2.xyzw =  input.texCoord0;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        
        Varyings UnpackVaryings (PackedVaryings input)
        {
            Varyings output;
            output.positionCS = input.positionCS;
            output.normalWS = input.interp0.xyz;
            output.tangentWS = input.interp1.xyzw;
            output.texCoord0 = input.interp2.xyzw;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        
        
        // --------------------------------------------------
        // Graph
        
        // Graph Properties
        CBUFFER_START(UnityPerMaterial)
        CBUFFER_END
        
        // Object and Global properties
        
        // Graph Includes


//Curved World
//#define CURVEDWORLD_BEND_TYPE_CLASSICRUNNER_X_POSITIVE
//#define CURVEDWORLD_BEND_ID_1
//#pragma shader_feature_local CURVEDWORLD_DISABLED_ON
//#pragma shader_feature_local CURVEDWORLD_NORMAL_TRANSFORMATION_ON
//#include "Assets/Amazing Assets/Curved World/Shaders/Core/CurvedWorldTransform.cginc"


//Terrain To Mesh Keywords//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma shader_feature_local _ _T2M_TEXTURE_SAMPLE_TYPE_ARRAY

#pragma shader_feature_local _ _T2M_LAYER_COUNT_3 _T2M_LAYER_COUNT_4 _T2M_LAYER_COUNT_5 _T2M_LAYER_COUNT_6 _T2M_LAYER_COUNT_7 _T2M_LAYER_COUNT_8 _T2M_LAYER_COUNT_9 _T2M_LAYER_COUNT_10 _T2M_LAYER_COUNT_11 _T2M_LAYER_COUNT_12 _T2M_LAYER_COUNT_13 _T2M_LAYER_COUNT_14 _T2M_LAYER_COUNT_15 _T2M_LAYER_COUNT_16
		
#pragma shader_feature_local _T2M_LAYER_0_NORMAL
#pragma shader_feature_local _T2M_LAYER_1_NORMAL
#pragma shader_feature_local _T2M_LAYER_2_NORMAL
#pragma shader_feature_local _T2M_LAYER_3_NORMAL
#pragma shader_feature_local _T2M_LAYER_4_NORMAL
#pragma shader_feature_local _T2M_LAYER_5_NORMAL
#pragma shader_feature_local _T2M_LAYER_6_NORMAL
#pragma shader_feature_local _T2M_LAYER_7_NORMAL
#pragma shader_feature_local _T2M_LAYER_8_NORMAL
#pragma shader_feature_local _T2M_LAYER_9_NORMAL
#pragma shader_feature_local _T2M_LAYER_10_NORMAL
#pragma shader_feature_local _T2M_LAYER_11_NORMAL
#pragma shader_feature_local _T2M_LAYER_12_NORMAL
#pragma shader_feature_local _T2M_LAYER_13_NORMAL
#pragma shader_feature_local _T2M_LAYER_14_NORMAL
#pragma shader_feature_local _T2M_LAYER_15_NORMAL

#pragma shader_feature_local _T2M_LAYER_0_MASK
#pragma shader_feature_local _T2M_LAYER_1_MASK
#pragma shader_feature_local _T2M_LAYER_2_MASK
#pragma shader_feature_local _T2M_LAYER_3_MASK
#pragma shader_feature_local _T2M_LAYER_4_MASK
#pragma shader_feature_local _T2M_LAYER_5_MASK
#pragma shader_feature_local _T2M_LAYER_6_MASK
#pragma shader_feature_local _T2M_LAYER_7_MASK
#pragma shader_feature_local _T2M_LAYER_8_MASK
#pragma shader_feature_local _T2M_LAYER_9_MASK
#pragma shader_feature_local _T2M_LAYER_10_MASK
#pragma shader_feature_local _T2M_LAYER_11_MASK
#pragma shader_feature_local _T2M_LAYER_12_MASK
#pragma shader_feature_local _T2M_LAYER_13_MASK
#pragma shader_feature_local _T2M_LAYER_14_MASK
#pragma shader_feature_local _T2M_LAYER_15_MASK

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


#define TERRAIN_TO_MESH_NEED_NORMAL
#define TERRAIN_TO_MESH_NEED_METALLIC_SMOOTHNESS_OCCLUSION


#include "Splatmap.cginc"
        
        // -- Property used by ScenePickingPass
        #ifdef SCENEPICKINGPASS
        float4 _SelectionID;
        #endif
        
        // -- Properties used by SceneSelectionPass
        #ifdef SCENESELECTIONPASS
        int _ObjectId;
        int _PassValue;
        #endif
        
        // Graph Functions
        // GraphFunctions: <None>
        
        // Custom interpolators pre vertex
        /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPreVertex' */
        
        // Graph Vertex
        struct VertexDescription
        {
            float3 Position;
            float3 Normal;
            float3 Tangent;
        };
        
        VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
        {
            VertexDescription description = (VertexDescription)0;
            float3 _SHGTerrainToMeshCurvedWorldCustomFunction_1d12c500e42ebf8b903bf40b7a0a5e2c_vertex_0;
            float3 _SHGTerrainToMeshCurvedWorldCustomFunction_1d12c500e42ebf8b903bf40b7a0a5e2c_normal_4;
            SHG_TerrainToMeshCurvedWorld_float(IN.ObjectSpacePosition, IN.ObjectSpaceNormal, (float4(IN.ObjectSpaceTangent, 1.0)), _SHGTerrainToMeshCurvedWorldCustomFunction_1d12c500e42ebf8b903bf40b7a0a5e2c_vertex_0, _SHGTerrainToMeshCurvedWorldCustomFunction_1d12c500e42ebf8b903bf40b7a0a5e2c_normal_4);
            description.Position = _SHGTerrainToMeshCurvedWorldCustomFunction_1d12c500e42ebf8b903bf40b7a0a5e2c_vertex_0;
            description.Normal = _SHGTerrainToMeshCurvedWorldCustomFunction_1d12c500e42ebf8b903bf40b7a0a5e2c_normal_4;
            description.Tangent = IN.ObjectSpaceTangent;
            return description;
        }
        
        // Custom interpolators, pre surface
        #ifdef FEATURES_GRAPH_VERTEX
        Varyings CustomInterpolatorPassThroughFunc(inout Varyings output, VertexDescription input)
        {
        return output;
        }
        #define CUSTOMINTERPOLATOR_VARYPASSTHROUGH_FUNC
        #endif
        
        // Graph Pixel
        struct SurfaceDescription
        {
            float3 NormalTS;
        };
        
        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            float4 _UV_d56c6fdf7ac2828fa944da2372119006_Out_0 = IN.uv0;
            float3 _SHGTerrainToMeshCalculateLayersBlendCustomFunction_24112ec2b2aa8c829e8ab4bb7ea28f60_albedo_1;
            float _SHGTerrainToMeshCalculateLayersBlendCustomFunction_24112ec2b2aa8c829e8ab4bb7ea28f60_alpha_2;
            float3 _SHGTerrainToMeshCalculateLayersBlendCustomFunction_24112ec2b2aa8c829e8ab4bb7ea28f60_normal_3;
            float _SHGTerrainToMeshCalculateLayersBlendCustomFunction_24112ec2b2aa8c829e8ab4bb7ea28f60_metallic_4;
            float _SHGTerrainToMeshCalculateLayersBlendCustomFunction_24112ec2b2aa8c829e8ab4bb7ea28f60_smoothness_5;
            float _SHGTerrainToMeshCalculateLayersBlendCustomFunction_24112ec2b2aa8c829e8ab4bb7ea28f60_occlusion_6;
            SHG_TerrainToMeshCalculateLayersBlend_float(_UV_d56c6fdf7ac2828fa944da2372119006_Out_0, _SHGTerrainToMeshCalculateLayersBlendCustomFunction_24112ec2b2aa8c829e8ab4bb7ea28f60_albedo_1, _SHGTerrainToMeshCalculateLayersBlendCustomFunction_24112ec2b2aa8c829e8ab4bb7ea28f60_alpha_2, _SHGTerrainToMeshCalculateLayersBlendCustomFunction_24112ec2b2aa8c829e8ab4bb7ea28f60_normal_3, _SHGTerrainToMeshCalculateLayersBlendCustomFunction_24112ec2b2aa8c829e8ab4bb7ea28f60_metallic_4, _SHGTerrainToMeshCalculateLayersBlendCustomFunction_24112ec2b2aa8c829e8ab4bb7ea28f60_smoothness_5, _SHGTerrainToMeshCalculateLayersBlendCustomFunction_24112ec2b2aa8c829e8ab4bb7ea28f60_occlusion_6);
            surface.NormalTS = _SHGTerrainToMeshCalculateLayersBlendCustomFunction_24112ec2b2aa8c829e8ab4bb7ea28f60_normal_3;
            return surface;
        }
        
        // --------------------------------------------------
        // Build Graph Inputs
        #ifdef HAVE_VFX_MODIFICATION
        #define VFX_SRP_ATTRIBUTES Attributes
        #define VFX_SRP_VARYINGS Varyings
        #define VFX_SRP_SURFACE_INPUTS SurfaceDescriptionInputs
        #endif
        VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
        {
            VertexDescriptionInputs output;
            ZERO_INITIALIZE(VertexDescriptionInputs, output);
        
            output.ObjectSpaceNormal =                          input.normalOS;
            output.ObjectSpaceTangent =                         input.tangentOS.xyz;
            output.ObjectSpacePosition =                        input.positionOS;
        
            return output;
        }
        SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
        {
            SurfaceDescriptionInputs output;
            ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
        
        #ifdef HAVE_VFX_MODIFICATION
            // FragInputs from VFX come from two places: Interpolator or CBuffer.
            /* WARNING: $splice Could not find named fragment 'VFXSetFragInputs' */
        
        #endif
        
            
        
        
        
            output.TangentSpaceNormal = float3(0.0f, 0.0f, 1.0f);
        
        
        
            #if UNITY_UV_STARTS_AT_TOP
            #else
            #endif
        
        
            output.uv0 = input.texCoord0;
        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
        #else
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        #endif
        #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        
                return output;
        }
        
        // --------------------------------------------------
        // Main
        
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/DepthNormalsOnlyPass.hlsl"
        
        // --------------------------------------------------
        // Visual Effect Vertex Invocations
        #ifdef HAVE_VFX_MODIFICATION
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/VisualEffectVertex.hlsl"
        #endif
        
        ENDHLSL
        }
        Pass
        {
            Name "Meta"
            Tags
            {
                "LightMode" = "Meta"
            }
        
        // Render State
        Cull Off
        
        // Debug
        // <None>
        
        // --------------------------------------------------
        // Pass
        
        HLSLPROGRAM
        
        // Pragmas
        #pragma target 3.5
        #pragma only_renderers gles gles3 glcore d3d11
        #pragma vertex vert
        #pragma fragment frag
        
        // Keywords
        #pragma shader_feature _ EDITOR_VISUALIZATION
        // GraphKeywords: <None>
        
        // Defines
        
        #define _NORMALMAP 1
        #define _NORMAL_DROPOFF_TS 1
        #define ATTRIBUTES_NEED_NORMAL
        #define ATTRIBUTES_NEED_TANGENT
        #define ATTRIBUTES_NEED_TEXCOORD0
        #define ATTRIBUTES_NEED_TEXCOORD1
        #define ATTRIBUTES_NEED_TEXCOORD2
        #define VARYINGS_NEED_TEXCOORD0
        #define VARYINGS_NEED_TEXCOORD1
        #define VARYINGS_NEED_TEXCOORD2
        #define FEATURES_GRAPH_VERTEX
        /* WARNING: $splice Could not find named fragment 'PassInstancing' */
        #define SHADERPASS SHADERPASS_META
        #define _FOG_FRAGMENT 1
        /* WARNING: $splice Could not find named fragment 'DotsInstancingVars' */
        
        
        // custom interpolator pre-include
        /* WARNING: $splice Could not find named fragment 'sgci_CustomInterpolatorPreInclude' */
        
        // Includes
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/MetaInput.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
        
        // --------------------------------------------------
        // Structs and Packing
        
        // custom interpolators pre packing
        /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPrePacking' */
        
        struct Attributes
        {
             float3 positionOS : POSITION;
             float3 normalOS : NORMAL;
             float4 tangentOS : TANGENT;
             float4 uv0 : TEXCOORD0;
             float4 uv1 : TEXCOORD1;
             float4 uv2 : TEXCOORD2;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : INSTANCEID_SEMANTIC;
            #endif
        };
        struct Varyings
        {
             float4 positionCS : SV_POSITION;
             float4 texCoord0;
             float4 texCoord1;
             float4 texCoord2;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
        };
        struct SurfaceDescriptionInputs
        {
             float4 uv0;
        };
        struct VertexDescriptionInputs
        {
             float3 ObjectSpaceNormal;
             float3 ObjectSpaceTangent;
             float3 ObjectSpacePosition;
        };
        struct PackedVaryings
        {
             float4 positionCS : SV_POSITION;
             float4 interp0 : INTERP0;
             float4 interp1 : INTERP1;
             float4 interp2 : INTERP2;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
        };
        
        PackedVaryings PackVaryings (Varyings input)
        {
            PackedVaryings output;
            ZERO_INITIALIZE(PackedVaryings, output);
            output.positionCS = input.positionCS;
            output.interp0.xyzw =  input.texCoord0;
            output.interp1.xyzw =  input.texCoord1;
            output.interp2.xyzw =  input.texCoord2;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        
        Varyings UnpackVaryings (PackedVaryings input)
        {
            Varyings output;
            output.positionCS = input.positionCS;
            output.texCoord0 = input.interp0.xyzw;
            output.texCoord1 = input.interp1.xyzw;
            output.texCoord2 = input.interp2.xyzw;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        
        
        // --------------------------------------------------
        // Graph
        
        // Graph Properties
        CBUFFER_START(UnityPerMaterial)
        CBUFFER_END
        
        // Object and Global properties
        
        // Graph Includes


//Curved World
//#define CURVEDWORLD_BEND_TYPE_CLASSICRUNNER_X_POSITIVE
//#define CURVEDWORLD_BEND_ID_1
//#pragma shader_feature_local CURVEDWORLD_DISABLED_ON
//#pragma shader_feature_local CURVEDWORLD_NORMAL_TRANSFORMATION_ON
//#include "Assets/Amazing Assets/Curved World/Shaders/Core/CurvedWorldTransform.cginc"


//Terrain To Mesh Keywords//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma shader_feature_local _ _T2M_TEXTURE_SAMPLE_TYPE_ARRAY

#pragma shader_feature_local _ _T2M_LAYER_COUNT_3 _T2M_LAYER_COUNT_4 _T2M_LAYER_COUNT_5 _T2M_LAYER_COUNT_6 _T2M_LAYER_COUNT_7 _T2M_LAYER_COUNT_8 _T2M_LAYER_COUNT_9 _T2M_LAYER_COUNT_10 _T2M_LAYER_COUNT_11 _T2M_LAYER_COUNT_12 _T2M_LAYER_COUNT_13 _T2M_LAYER_COUNT_14 _T2M_LAYER_COUNT_15 _T2M_LAYER_COUNT_16
		
#pragma shader_feature_local _T2M_LAYER_0_NORMAL
#pragma shader_feature_local _T2M_LAYER_1_NORMAL
#pragma shader_feature_local _T2M_LAYER_2_NORMAL
#pragma shader_feature_local _T2M_LAYER_3_NORMAL
#pragma shader_feature_local _T2M_LAYER_4_NORMAL
#pragma shader_feature_local _T2M_LAYER_5_NORMAL
#pragma shader_feature_local _T2M_LAYER_6_NORMAL
#pragma shader_feature_local _T2M_LAYER_7_NORMAL
#pragma shader_feature_local _T2M_LAYER_8_NORMAL
#pragma shader_feature_local _T2M_LAYER_9_NORMAL
#pragma shader_feature_local _T2M_LAYER_10_NORMAL
#pragma shader_feature_local _T2M_LAYER_11_NORMAL
#pragma shader_feature_local _T2M_LAYER_12_NORMAL
#pragma shader_feature_local _T2M_LAYER_13_NORMAL
#pragma shader_feature_local _T2M_LAYER_14_NORMAL
#pragma shader_feature_local _T2M_LAYER_15_NORMAL

#pragma shader_feature_local _T2M_LAYER_0_MASK
#pragma shader_feature_local _T2M_LAYER_1_MASK
#pragma shader_feature_local _T2M_LAYER_2_MASK
#pragma shader_feature_local _T2M_LAYER_3_MASK
#pragma shader_feature_local _T2M_LAYER_4_MASK
#pragma shader_feature_local _T2M_LAYER_5_MASK
#pragma shader_feature_local _T2M_LAYER_6_MASK
#pragma shader_feature_local _T2M_LAYER_7_MASK
#pragma shader_feature_local _T2M_LAYER_8_MASK
#pragma shader_feature_local _T2M_LAYER_9_MASK
#pragma shader_feature_local _T2M_LAYER_10_MASK
#pragma shader_feature_local _T2M_LAYER_11_MASK
#pragma shader_feature_local _T2M_LAYER_12_MASK
#pragma shader_feature_local _T2M_LAYER_13_MASK
#pragma shader_feature_local _T2M_LAYER_14_MASK
#pragma shader_feature_local _T2M_LAYER_15_MASK

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


#define TERRAIN_TO_MESH_NEED_NORMAL
#define TERRAIN_TO_MESH_NEED_METALLIC_SMOOTHNESS_OCCLUSION


#include "Splatmap.cginc"
        
        // -- Property used by ScenePickingPass
        #ifdef SCENEPICKINGPASS
        float4 _SelectionID;
        #endif
        
        // -- Properties used by SceneSelectionPass
        #ifdef SCENESELECTIONPASS
        int _ObjectId;
        int _PassValue;
        #endif
        
        // Graph Functions
        // GraphFunctions: <None>
        
        // Custom interpolators pre vertex
        /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPreVertex' */
        
        // Graph Vertex
        struct VertexDescription
        {
            float3 Position;
            float3 Normal;
            float3 Tangent;
        };
        
        VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
        {
            VertexDescription description = (VertexDescription)0;
            float3 _SHGTerrainToMeshCurvedWorldCustomFunction_1d12c500e42ebf8b903bf40b7a0a5e2c_vertex_0;
            float3 _SHGTerrainToMeshCurvedWorldCustomFunction_1d12c500e42ebf8b903bf40b7a0a5e2c_normal_4;
            SHG_TerrainToMeshCurvedWorld_float(IN.ObjectSpacePosition, IN.ObjectSpaceNormal, (float4(IN.ObjectSpaceTangent, 1.0)), _SHGTerrainToMeshCurvedWorldCustomFunction_1d12c500e42ebf8b903bf40b7a0a5e2c_vertex_0, _SHGTerrainToMeshCurvedWorldCustomFunction_1d12c500e42ebf8b903bf40b7a0a5e2c_normal_4);
            description.Position = _SHGTerrainToMeshCurvedWorldCustomFunction_1d12c500e42ebf8b903bf40b7a0a5e2c_vertex_0;
            description.Normal = _SHGTerrainToMeshCurvedWorldCustomFunction_1d12c500e42ebf8b903bf40b7a0a5e2c_normal_4;
            description.Tangent = IN.ObjectSpaceTangent;
            return description;
        }
        
        // Custom interpolators, pre surface
        #ifdef FEATURES_GRAPH_VERTEX
        Varyings CustomInterpolatorPassThroughFunc(inout Varyings output, VertexDescription input)
        {
        return output;
        }
        #define CUSTOMINTERPOLATOR_VARYPASSTHROUGH_FUNC
        #endif
        
        // Graph Pixel
        struct SurfaceDescription
        {
            float3 BaseColor;
            float3 Emission;
        };
        
        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            float4 _UV_d56c6fdf7ac2828fa944da2372119006_Out_0 = IN.uv0;
            float3 _SHGTerrainToMeshCalculateLayersBlendCustomFunction_24112ec2b2aa8c829e8ab4bb7ea28f60_albedo_1;
            float _SHGTerrainToMeshCalculateLayersBlendCustomFunction_24112ec2b2aa8c829e8ab4bb7ea28f60_alpha_2;
            float3 _SHGTerrainToMeshCalculateLayersBlendCustomFunction_24112ec2b2aa8c829e8ab4bb7ea28f60_normal_3;
            float _SHGTerrainToMeshCalculateLayersBlendCustomFunction_24112ec2b2aa8c829e8ab4bb7ea28f60_metallic_4;
            float _SHGTerrainToMeshCalculateLayersBlendCustomFunction_24112ec2b2aa8c829e8ab4bb7ea28f60_smoothness_5;
            float _SHGTerrainToMeshCalculateLayersBlendCustomFunction_24112ec2b2aa8c829e8ab4bb7ea28f60_occlusion_6;
            SHG_TerrainToMeshCalculateLayersBlend_float(_UV_d56c6fdf7ac2828fa944da2372119006_Out_0, _SHGTerrainToMeshCalculateLayersBlendCustomFunction_24112ec2b2aa8c829e8ab4bb7ea28f60_albedo_1, _SHGTerrainToMeshCalculateLayersBlendCustomFunction_24112ec2b2aa8c829e8ab4bb7ea28f60_alpha_2, _SHGTerrainToMeshCalculateLayersBlendCustomFunction_24112ec2b2aa8c829e8ab4bb7ea28f60_normal_3, _SHGTerrainToMeshCalculateLayersBlendCustomFunction_24112ec2b2aa8c829e8ab4bb7ea28f60_metallic_4, _SHGTerrainToMeshCalculateLayersBlendCustomFunction_24112ec2b2aa8c829e8ab4bb7ea28f60_smoothness_5, _SHGTerrainToMeshCalculateLayersBlendCustomFunction_24112ec2b2aa8c829e8ab4bb7ea28f60_occlusion_6);
            surface.BaseColor = _SHGTerrainToMeshCalculateLayersBlendCustomFunction_24112ec2b2aa8c829e8ab4bb7ea28f60_albedo_1;
            surface.Emission = float3(0, 0, 0);
            return surface;
        }
        
        // --------------------------------------------------
        // Build Graph Inputs
        #ifdef HAVE_VFX_MODIFICATION
        #define VFX_SRP_ATTRIBUTES Attributes
        #define VFX_SRP_VARYINGS Varyings
        #define VFX_SRP_SURFACE_INPUTS SurfaceDescriptionInputs
        #endif
        VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
        {
            VertexDescriptionInputs output;
            ZERO_INITIALIZE(VertexDescriptionInputs, output);
        
            output.ObjectSpaceNormal =                          input.normalOS;
            output.ObjectSpaceTangent =                         input.tangentOS.xyz;
            output.ObjectSpacePosition =                        input.positionOS;
        
            return output;
        }
        SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
        {
            SurfaceDescriptionInputs output;
            ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
        
        #ifdef HAVE_VFX_MODIFICATION
            // FragInputs from VFX come from two places: Interpolator or CBuffer.
            /* WARNING: $splice Could not find named fragment 'VFXSetFragInputs' */
        
        #endif
        
            
        
        
        
        
        
        
            #if UNITY_UV_STARTS_AT_TOP
            #else
            #endif
        
        
            output.uv0 = input.texCoord0;
        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
        #else
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        #endif
        #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        
                return output;
        }
        
        // --------------------------------------------------
        // Main
        
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/LightingMetaPass.hlsl"
        
        // --------------------------------------------------
        // Visual Effect Vertex Invocations
        #ifdef HAVE_VFX_MODIFICATION
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/VisualEffectVertex.hlsl"
        #endif
        
        ENDHLSL
        }
        Pass
        {
            Name "SceneSelectionPass"
            Tags
            {
                "LightMode" = "SceneSelectionPass"
            }
        
        // Render State
        Cull Off
        
        // Debug
        // <None>
        
        // --------------------------------------------------
        // Pass
        
        HLSLPROGRAM
        
        // Pragmas
        #pragma target 3.5
        #pragma only_renderers gles gles3 glcore d3d11
        #pragma multi_compile_instancing
        #pragma vertex vert
        #pragma fragment frag
        
        // Keywords
        // PassKeywords: <None>
        // GraphKeywords: <None>
        
        // Defines
        
        #define _NORMALMAP 1
        #define _NORMAL_DROPOFF_TS 1
        #define ATTRIBUTES_NEED_NORMAL
        #define ATTRIBUTES_NEED_TANGENT
        #define FEATURES_GRAPH_VERTEX
        /* WARNING: $splice Could not find named fragment 'PassInstancing' */
        #define SHADERPASS SHADERPASS_DEPTHONLY
        #define SCENESELECTIONPASS 1
        #define ALPHA_CLIP_THRESHOLD 1
        /* WARNING: $splice Could not find named fragment 'DotsInstancingVars' */
        
        
        // custom interpolator pre-include
        /* WARNING: $splice Could not find named fragment 'sgci_CustomInterpolatorPreInclude' */
        
        // Includes
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
        
        // --------------------------------------------------
        // Structs and Packing
        
        // custom interpolators pre packing
        /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPrePacking' */
        
        struct Attributes
        {
             float3 positionOS : POSITION;
             float3 normalOS : NORMAL;
             float4 tangentOS : TANGENT;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : INSTANCEID_SEMANTIC;
            #endif
        };
        struct Varyings
        {
             float4 positionCS : SV_POSITION;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
        };
        struct SurfaceDescriptionInputs
        {
        };
        struct VertexDescriptionInputs
        {
             float3 ObjectSpaceNormal;
             float3 ObjectSpaceTangent;
             float3 ObjectSpacePosition;
        };
        struct PackedVaryings
        {
             float4 positionCS : SV_POSITION;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
        };
        
        PackedVaryings PackVaryings (Varyings input)
        {
            PackedVaryings output;
            ZERO_INITIALIZE(PackedVaryings, output);
            output.positionCS = input.positionCS;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        
        Varyings UnpackVaryings (PackedVaryings input)
        {
            Varyings output;
            output.positionCS = input.positionCS;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        
        
        // --------------------------------------------------
        // Graph
        
        // Graph Properties
        CBUFFER_START(UnityPerMaterial)
        CBUFFER_END
        
        // Object and Global properties
        
        // Graph Includes


//Curved World
//#define CURVEDWORLD_BEND_TYPE_CLASSICRUNNER_X_POSITIVE
//#define CURVEDWORLD_BEND_ID_1
//#pragma shader_feature_local CURVEDWORLD_DISABLED_ON
//#pragma shader_feature_local CURVEDWORLD_NORMAL_TRANSFORMATION_ON
//#include "Assets/Amazing Assets/Curved World/Shaders/Core/CurvedWorldTransform.cginc"


//Terrain To Mesh Keywords//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma shader_feature_local _ _T2M_TEXTURE_SAMPLE_TYPE_ARRAY

#pragma shader_feature_local _ _T2M_LAYER_COUNT_3 _T2M_LAYER_COUNT_4 _T2M_LAYER_COUNT_5 _T2M_LAYER_COUNT_6 _T2M_LAYER_COUNT_7 _T2M_LAYER_COUNT_8 _T2M_LAYER_COUNT_9 _T2M_LAYER_COUNT_10 _T2M_LAYER_COUNT_11 _T2M_LAYER_COUNT_12 _T2M_LAYER_COUNT_13 _T2M_LAYER_COUNT_14 _T2M_LAYER_COUNT_15 _T2M_LAYER_COUNT_16
		
#pragma shader_feature_local _T2M_LAYER_0_NORMAL
#pragma shader_feature_local _T2M_LAYER_1_NORMAL
#pragma shader_feature_local _T2M_LAYER_2_NORMAL
#pragma shader_feature_local _T2M_LAYER_3_NORMAL
#pragma shader_feature_local _T2M_LAYER_4_NORMAL
#pragma shader_feature_local _T2M_LAYER_5_NORMAL
#pragma shader_feature_local _T2M_LAYER_6_NORMAL
#pragma shader_feature_local _T2M_LAYER_7_NORMAL
#pragma shader_feature_local _T2M_LAYER_8_NORMAL
#pragma shader_feature_local _T2M_LAYER_9_NORMAL
#pragma shader_feature_local _T2M_LAYER_10_NORMAL
#pragma shader_feature_local _T2M_LAYER_11_NORMAL
#pragma shader_feature_local _T2M_LAYER_12_NORMAL
#pragma shader_feature_local _T2M_LAYER_13_NORMAL
#pragma shader_feature_local _T2M_LAYER_14_NORMAL
#pragma shader_feature_local _T2M_LAYER_15_NORMAL

#pragma shader_feature_local _T2M_LAYER_0_MASK
#pragma shader_feature_local _T2M_LAYER_1_MASK
#pragma shader_feature_local _T2M_LAYER_2_MASK
#pragma shader_feature_local _T2M_LAYER_3_MASK
#pragma shader_feature_local _T2M_LAYER_4_MASK
#pragma shader_feature_local _T2M_LAYER_5_MASK
#pragma shader_feature_local _T2M_LAYER_6_MASK
#pragma shader_feature_local _T2M_LAYER_7_MASK
#pragma shader_feature_local _T2M_LAYER_8_MASK
#pragma shader_feature_local _T2M_LAYER_9_MASK
#pragma shader_feature_local _T2M_LAYER_10_MASK
#pragma shader_feature_local _T2M_LAYER_11_MASK
#pragma shader_feature_local _T2M_LAYER_12_MASK
#pragma shader_feature_local _T2M_LAYER_13_MASK
#pragma shader_feature_local _T2M_LAYER_14_MASK
#pragma shader_feature_local _T2M_LAYER_15_MASK

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


#define TERRAIN_TO_MESH_NEED_NORMAL
#define TERRAIN_TO_MESH_NEED_METALLIC_SMOOTHNESS_OCCLUSION


#include "Splatmap.cginc"
        
        // -- Property used by ScenePickingPass
        #ifdef SCENEPICKINGPASS
        float4 _SelectionID;
        #endif
        
        // -- Properties used by SceneSelectionPass
        #ifdef SCENESELECTIONPASS
        int _ObjectId;
        int _PassValue;
        #endif
        
        // Graph Functions
        // GraphFunctions: <None>
        
        // Custom interpolators pre vertex
        /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPreVertex' */
        
        // Graph Vertex
        struct VertexDescription
        {
            float3 Position;
            float3 Normal;
            float3 Tangent;
        };
        
        VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
        {
            VertexDescription description = (VertexDescription)0;
            float3 _SHGTerrainToMeshCurvedWorldCustomFunction_1d12c500e42ebf8b903bf40b7a0a5e2c_vertex_0;
            float3 _SHGTerrainToMeshCurvedWorldCustomFunction_1d12c500e42ebf8b903bf40b7a0a5e2c_normal_4;
            SHG_TerrainToMeshCurvedWorld_float(IN.ObjectSpacePosition, IN.ObjectSpaceNormal, (float4(IN.ObjectSpaceTangent, 1.0)), _SHGTerrainToMeshCurvedWorldCustomFunction_1d12c500e42ebf8b903bf40b7a0a5e2c_vertex_0, _SHGTerrainToMeshCurvedWorldCustomFunction_1d12c500e42ebf8b903bf40b7a0a5e2c_normal_4);
            description.Position = _SHGTerrainToMeshCurvedWorldCustomFunction_1d12c500e42ebf8b903bf40b7a0a5e2c_vertex_0;
            description.Normal = _SHGTerrainToMeshCurvedWorldCustomFunction_1d12c500e42ebf8b903bf40b7a0a5e2c_normal_4;
            description.Tangent = IN.ObjectSpaceTangent;
            return description;
        }
        
        // Custom interpolators, pre surface
        #ifdef FEATURES_GRAPH_VERTEX
        Varyings CustomInterpolatorPassThroughFunc(inout Varyings output, VertexDescription input)
        {
        return output;
        }
        #define CUSTOMINTERPOLATOR_VARYPASSTHROUGH_FUNC
        #endif
        
        // Graph Pixel
        struct SurfaceDescription
        {
        };
        
        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            return surface;
        }
        
        // --------------------------------------------------
        // Build Graph Inputs
        #ifdef HAVE_VFX_MODIFICATION
        #define VFX_SRP_ATTRIBUTES Attributes
        #define VFX_SRP_VARYINGS Varyings
        #define VFX_SRP_SURFACE_INPUTS SurfaceDescriptionInputs
        #endif
        VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
        {
            VertexDescriptionInputs output;
            ZERO_INITIALIZE(VertexDescriptionInputs, output);
        
            output.ObjectSpaceNormal =                          input.normalOS;
            output.ObjectSpaceTangent =                         input.tangentOS.xyz;
            output.ObjectSpacePosition =                        input.positionOS;
        
            return output;
        }
        SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
        {
            SurfaceDescriptionInputs output;
            ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
        
        #ifdef HAVE_VFX_MODIFICATION
            // FragInputs from VFX come from two places: Interpolator or CBuffer.
            /* WARNING: $splice Could not find named fragment 'VFXSetFragInputs' */
        
        #endif
        
            
        
        
        
        
        
        
            #if UNITY_UV_STARTS_AT_TOP
            #else
            #endif
        
        
        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
        #else
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        #endif
        #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        
                return output;
        }
        
        // --------------------------------------------------
        // Main
        
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/SelectionPickingPass.hlsl"
        
        // --------------------------------------------------
        // Visual Effect Vertex Invocations
        #ifdef HAVE_VFX_MODIFICATION
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/VisualEffectVertex.hlsl"
        #endif
        
        ENDHLSL
        }
        Pass
        {
            Name "ScenePickingPass"
            Tags
            {
                "LightMode" = "Picking"
            }
        
        // Render State
        Cull Back
        
        // Debug
        // <None>
        
        // --------------------------------------------------
        // Pass
        
        HLSLPROGRAM
        
        // Pragmas
        #pragma target 3.5
        #pragma only_renderers gles gles3 glcore d3d11
        #pragma multi_compile_instancing
        #pragma vertex vert
        #pragma fragment frag
        
        // Keywords
        // PassKeywords: <None>
        // GraphKeywords: <None>
        
        // Defines
        
        #define _NORMALMAP 1
        #define _NORMAL_DROPOFF_TS 1
        #define ATTRIBUTES_NEED_NORMAL
        #define ATTRIBUTES_NEED_TANGENT
        #define FEATURES_GRAPH_VERTEX
        /* WARNING: $splice Could not find named fragment 'PassInstancing' */
        #define SHADERPASS SHADERPASS_DEPTHONLY
        #define SCENEPICKINGPASS 1
        #define ALPHA_CLIP_THRESHOLD 1
        /* WARNING: $splice Could not find named fragment 'DotsInstancingVars' */
        
        
        // custom interpolator pre-include
        /* WARNING: $splice Could not find named fragment 'sgci_CustomInterpolatorPreInclude' */
        
        // Includes
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
        
        // --------------------------------------------------
        // Structs and Packing
        
        // custom interpolators pre packing
        /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPrePacking' */
        
        struct Attributes
        {
             float3 positionOS : POSITION;
             float3 normalOS : NORMAL;
             float4 tangentOS : TANGENT;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : INSTANCEID_SEMANTIC;
            #endif
        };
        struct Varyings
        {
             float4 positionCS : SV_POSITION;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
        };
        struct SurfaceDescriptionInputs
        {
        };
        struct VertexDescriptionInputs
        {
             float3 ObjectSpaceNormal;
             float3 ObjectSpaceTangent;
             float3 ObjectSpacePosition;
        };
        struct PackedVaryings
        {
             float4 positionCS : SV_POSITION;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
        };
        
        PackedVaryings PackVaryings (Varyings input)
        {
            PackedVaryings output;
            ZERO_INITIALIZE(PackedVaryings, output);
            output.positionCS = input.positionCS;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        
        Varyings UnpackVaryings (PackedVaryings input)
        {
            Varyings output;
            output.positionCS = input.positionCS;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        
        
        // --------------------------------------------------
        // Graph
        
        // Graph Properties
        CBUFFER_START(UnityPerMaterial)
        CBUFFER_END
        
        // Object and Global properties
        
        // Graph Includes


//Curved World
//#define CURVEDWORLD_BEND_TYPE_CLASSICRUNNER_X_POSITIVE
//#define CURVEDWORLD_BEND_ID_1
//#pragma shader_feature_local CURVEDWORLD_DISABLED_ON
//#pragma shader_feature_local CURVEDWORLD_NORMAL_TRANSFORMATION_ON
//#include "Assets/Amazing Assets/Curved World/Shaders/Core/CurvedWorldTransform.cginc"


//Terrain To Mesh Keywords//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma shader_feature_local _ _T2M_TEXTURE_SAMPLE_TYPE_ARRAY

#pragma shader_feature_local _ _T2M_LAYER_COUNT_3 _T2M_LAYER_COUNT_4 _T2M_LAYER_COUNT_5 _T2M_LAYER_COUNT_6 _T2M_LAYER_COUNT_7 _T2M_LAYER_COUNT_8 _T2M_LAYER_COUNT_9 _T2M_LAYER_COUNT_10 _T2M_LAYER_COUNT_11 _T2M_LAYER_COUNT_12 _T2M_LAYER_COUNT_13 _T2M_LAYER_COUNT_14 _T2M_LAYER_COUNT_15 _T2M_LAYER_COUNT_16
		
#pragma shader_feature_local _T2M_LAYER_0_NORMAL
#pragma shader_feature_local _T2M_LAYER_1_NORMAL
#pragma shader_feature_local _T2M_LAYER_2_NORMAL
#pragma shader_feature_local _T2M_LAYER_3_NORMAL
#pragma shader_feature_local _T2M_LAYER_4_NORMAL
#pragma shader_feature_local _T2M_LAYER_5_NORMAL
#pragma shader_feature_local _T2M_LAYER_6_NORMAL
#pragma shader_feature_local _T2M_LAYER_7_NORMAL
#pragma shader_feature_local _T2M_LAYER_8_NORMAL
#pragma shader_feature_local _T2M_LAYER_9_NORMAL
#pragma shader_feature_local _T2M_LAYER_10_NORMAL
#pragma shader_feature_local _T2M_LAYER_11_NORMAL
#pragma shader_feature_local _T2M_LAYER_12_NORMAL
#pragma shader_feature_local _T2M_LAYER_13_NORMAL
#pragma shader_feature_local _T2M_LAYER_14_NORMAL
#pragma shader_feature_local _T2M_LAYER_15_NORMAL

#pragma shader_feature_local _T2M_LAYER_0_MASK
#pragma shader_feature_local _T2M_LAYER_1_MASK
#pragma shader_feature_local _T2M_LAYER_2_MASK
#pragma shader_feature_local _T2M_LAYER_3_MASK
#pragma shader_feature_local _T2M_LAYER_4_MASK
#pragma shader_feature_local _T2M_LAYER_5_MASK
#pragma shader_feature_local _T2M_LAYER_6_MASK
#pragma shader_feature_local _T2M_LAYER_7_MASK
#pragma shader_feature_local _T2M_LAYER_8_MASK
#pragma shader_feature_local _T2M_LAYER_9_MASK
#pragma shader_feature_local _T2M_LAYER_10_MASK
#pragma shader_feature_local _T2M_LAYER_11_MASK
#pragma shader_feature_local _T2M_LAYER_12_MASK
#pragma shader_feature_local _T2M_LAYER_13_MASK
#pragma shader_feature_local _T2M_LAYER_14_MASK
#pragma shader_feature_local _T2M_LAYER_15_MASK

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


#define TERRAIN_TO_MESH_NEED_NORMAL
#define TERRAIN_TO_MESH_NEED_METALLIC_SMOOTHNESS_OCCLUSION


#include "Splatmap.cginc"
        
        // -- Property used by ScenePickingPass
        #ifdef SCENEPICKINGPASS
        float4 _SelectionID;
        #endif
        
        // -- Properties used by SceneSelectionPass
        #ifdef SCENESELECTIONPASS
        int _ObjectId;
        int _PassValue;
        #endif
        
        // Graph Functions
        // GraphFunctions: <None>
        
        // Custom interpolators pre vertex
        /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPreVertex' */
        
        // Graph Vertex
        struct VertexDescription
        {
            float3 Position;
            float3 Normal;
            float3 Tangent;
        };
        
        VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
        {
            VertexDescription description = (VertexDescription)0;
            float3 _SHGTerrainToMeshCurvedWorldCustomFunction_1d12c500e42ebf8b903bf40b7a0a5e2c_vertex_0;
            float3 _SHGTerrainToMeshCurvedWorldCustomFunction_1d12c500e42ebf8b903bf40b7a0a5e2c_normal_4;
            SHG_TerrainToMeshCurvedWorld_float(IN.ObjectSpacePosition, IN.ObjectSpaceNormal, (float4(IN.ObjectSpaceTangent, 1.0)), _SHGTerrainToMeshCurvedWorldCustomFunction_1d12c500e42ebf8b903bf40b7a0a5e2c_vertex_0, _SHGTerrainToMeshCurvedWorldCustomFunction_1d12c500e42ebf8b903bf40b7a0a5e2c_normal_4);
            description.Position = _SHGTerrainToMeshCurvedWorldCustomFunction_1d12c500e42ebf8b903bf40b7a0a5e2c_vertex_0;
            description.Normal = _SHGTerrainToMeshCurvedWorldCustomFunction_1d12c500e42ebf8b903bf40b7a0a5e2c_normal_4;
            description.Tangent = IN.ObjectSpaceTangent;
            return description;
        }
        
        // Custom interpolators, pre surface
        #ifdef FEATURES_GRAPH_VERTEX
        Varyings CustomInterpolatorPassThroughFunc(inout Varyings output, VertexDescription input)
        {
        return output;
        }
        #define CUSTOMINTERPOLATOR_VARYPASSTHROUGH_FUNC
        #endif
        
        // Graph Pixel
        struct SurfaceDescription
        {
        };
        
        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            return surface;
        }
        
        // --------------------------------------------------
        // Build Graph Inputs
        #ifdef HAVE_VFX_MODIFICATION
        #define VFX_SRP_ATTRIBUTES Attributes
        #define VFX_SRP_VARYINGS Varyings
        #define VFX_SRP_SURFACE_INPUTS SurfaceDescriptionInputs
        #endif
        VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
        {
            VertexDescriptionInputs output;
            ZERO_INITIALIZE(VertexDescriptionInputs, output);
        
            output.ObjectSpaceNormal =                          input.normalOS;
            output.ObjectSpaceTangent =                         input.tangentOS.xyz;
            output.ObjectSpacePosition =                        input.positionOS;
        
            return output;
        }
        SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
        {
            SurfaceDescriptionInputs output;
            ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
        
        #ifdef HAVE_VFX_MODIFICATION
            // FragInputs from VFX come from two places: Interpolator or CBuffer.
            /* WARNING: $splice Could not find named fragment 'VFXSetFragInputs' */
        
        #endif
        
            
        
        
        
        
        
        
            #if UNITY_UV_STARTS_AT_TOP
            #else
            #endif
        
        
        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
        #else
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        #endif
        #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        
                return output;
        }
        
        // --------------------------------------------------
        // Main
        
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/SelectionPickingPass.hlsl"
        
        // --------------------------------------------------
        // Visual Effect Vertex Invocations
        #ifdef HAVE_VFX_MODIFICATION
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/VisualEffectVertex.hlsl"
        #endif
        
        ENDHLSL
        }
        Pass
        {
            // Name: <None>
            Tags
            {
                "LightMode" = "Universal2D"
            }
        
        // Render State
        Cull Back
        Blend One Zero
        ZTest LEqual
        ZWrite On
        
        // Debug
        // <None>
        
        // --------------------------------------------------
        // Pass
        
        HLSLPROGRAM
        
        // Pragmas
        #pragma target 3.5
        #pragma only_renderers gles gles3 glcore d3d11
        #pragma multi_compile_instancing
        #pragma vertex vert
        #pragma fragment frag
        
        // Keywords
        // PassKeywords: <None>
        // GraphKeywords: <None>
        
        // Defines
        
        #define _NORMALMAP 1
        #define _NORMAL_DROPOFF_TS 1
        #define ATTRIBUTES_NEED_NORMAL
        #define ATTRIBUTES_NEED_TANGENT
        #define ATTRIBUTES_NEED_TEXCOORD0
        #define VARYINGS_NEED_TEXCOORD0
        #define FEATURES_GRAPH_VERTEX
        /* WARNING: $splice Could not find named fragment 'PassInstancing' */
        #define SHADERPASS SHADERPASS_2D
        /* WARNING: $splice Could not find named fragment 'DotsInstancingVars' */
        
        
        // custom interpolator pre-include
        /* WARNING: $splice Could not find named fragment 'sgci_CustomInterpolatorPreInclude' */
        
        // Includes
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
        
        // --------------------------------------------------
        // Structs and Packing
        
        // custom interpolators pre packing
        /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPrePacking' */
        
        struct Attributes
        {
             float3 positionOS : POSITION;
             float3 normalOS : NORMAL;
             float4 tangentOS : TANGENT;
             float4 uv0 : TEXCOORD0;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : INSTANCEID_SEMANTIC;
            #endif
        };
        struct Varyings
        {
             float4 positionCS : SV_POSITION;
             float4 texCoord0;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
        };
        struct SurfaceDescriptionInputs
        {
             float4 uv0;
        };
        struct VertexDescriptionInputs
        {
             float3 ObjectSpaceNormal;
             float3 ObjectSpaceTangent;
             float3 ObjectSpacePosition;
        };
        struct PackedVaryings
        {
             float4 positionCS : SV_POSITION;
             float4 interp0 : INTERP0;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
        };
        
        PackedVaryings PackVaryings (Varyings input)
        {
            PackedVaryings output;
            ZERO_INITIALIZE(PackedVaryings, output);
            output.positionCS = input.positionCS;
            output.interp0.xyzw =  input.texCoord0;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        
        Varyings UnpackVaryings (PackedVaryings input)
        {
            Varyings output;
            output.positionCS = input.positionCS;
            output.texCoord0 = input.interp0.xyzw;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        
        
        // --------------------------------------------------
        // Graph
        
        // Graph Properties
        CBUFFER_START(UnityPerMaterial)
        CBUFFER_END
        
        // Object and Global properties
        
        // Graph Includes


//Curved World
//#define CURVEDWORLD_BEND_TYPE_CLASSICRUNNER_X_POSITIVE
//#define CURVEDWORLD_BEND_ID_1
//#pragma shader_feature_local CURVEDWORLD_DISABLED_ON
//#pragma shader_feature_local CURVEDWORLD_NORMAL_TRANSFORMATION_ON
//#include "Assets/Amazing Assets/Curved World/Shaders/Core/CurvedWorldTransform.cginc"


//Terrain To Mesh Keywords//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma shader_feature_local _ _T2M_TEXTURE_SAMPLE_TYPE_ARRAY

#pragma shader_feature_local _ _T2M_LAYER_COUNT_3 _T2M_LAYER_COUNT_4 _T2M_LAYER_COUNT_5 _T2M_LAYER_COUNT_6 _T2M_LAYER_COUNT_7 _T2M_LAYER_COUNT_8 _T2M_LAYER_COUNT_9 _T2M_LAYER_COUNT_10 _T2M_LAYER_COUNT_11 _T2M_LAYER_COUNT_12 _T2M_LAYER_COUNT_13 _T2M_LAYER_COUNT_14 _T2M_LAYER_COUNT_15 _T2M_LAYER_COUNT_16
		
#pragma shader_feature_local _T2M_LAYER_0_NORMAL
#pragma shader_feature_local _T2M_LAYER_1_NORMAL
#pragma shader_feature_local _T2M_LAYER_2_NORMAL
#pragma shader_feature_local _T2M_LAYER_3_NORMAL
#pragma shader_feature_local _T2M_LAYER_4_NORMAL
#pragma shader_feature_local _T2M_LAYER_5_NORMAL
#pragma shader_feature_local _T2M_LAYER_6_NORMAL
#pragma shader_feature_local _T2M_LAYER_7_NORMAL
#pragma shader_feature_local _T2M_LAYER_8_NORMAL
#pragma shader_feature_local _T2M_LAYER_9_NORMAL
#pragma shader_feature_local _T2M_LAYER_10_NORMAL
#pragma shader_feature_local _T2M_LAYER_11_NORMAL
#pragma shader_feature_local _T2M_LAYER_12_NORMAL
#pragma shader_feature_local _T2M_LAYER_13_NORMAL
#pragma shader_feature_local _T2M_LAYER_14_NORMAL
#pragma shader_feature_local _T2M_LAYER_15_NORMAL

#pragma shader_feature_local _T2M_LAYER_0_MASK
#pragma shader_feature_local _T2M_LAYER_1_MASK
#pragma shader_feature_local _T2M_LAYER_2_MASK
#pragma shader_feature_local _T2M_LAYER_3_MASK
#pragma shader_feature_local _T2M_LAYER_4_MASK
#pragma shader_feature_local _T2M_LAYER_5_MASK
#pragma shader_feature_local _T2M_LAYER_6_MASK
#pragma shader_feature_local _T2M_LAYER_7_MASK
#pragma shader_feature_local _T2M_LAYER_8_MASK
#pragma shader_feature_local _T2M_LAYER_9_MASK
#pragma shader_feature_local _T2M_LAYER_10_MASK
#pragma shader_feature_local _T2M_LAYER_11_MASK
#pragma shader_feature_local _T2M_LAYER_12_MASK
#pragma shader_feature_local _T2M_LAYER_13_MASK
#pragma shader_feature_local _T2M_LAYER_14_MASK
#pragma shader_feature_local _T2M_LAYER_15_MASK

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


#define TERRAIN_TO_MESH_NEED_NORMAL
#define TERRAIN_TO_MESH_NEED_METALLIC_SMOOTHNESS_OCCLUSION


#include "Splatmap.cginc"
        
        // -- Property used by ScenePickingPass
        #ifdef SCENEPICKINGPASS
        float4 _SelectionID;
        #endif
        
        // -- Properties used by SceneSelectionPass
        #ifdef SCENESELECTIONPASS
        int _ObjectId;
        int _PassValue;
        #endif
        
        // Graph Functions
        // GraphFunctions: <None>
        
        // Custom interpolators pre vertex
        /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPreVertex' */
        
        // Graph Vertex
        struct VertexDescription
        {
            float3 Position;
            float3 Normal;
            float3 Tangent;
        };
        
        VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
        {
            VertexDescription description = (VertexDescription)0;
            float3 _SHGTerrainToMeshCurvedWorldCustomFunction_1d12c500e42ebf8b903bf40b7a0a5e2c_vertex_0;
            float3 _SHGTerrainToMeshCurvedWorldCustomFunction_1d12c500e42ebf8b903bf40b7a0a5e2c_normal_4;
            SHG_TerrainToMeshCurvedWorld_float(IN.ObjectSpacePosition, IN.ObjectSpaceNormal, (float4(IN.ObjectSpaceTangent, 1.0)), _SHGTerrainToMeshCurvedWorldCustomFunction_1d12c500e42ebf8b903bf40b7a0a5e2c_vertex_0, _SHGTerrainToMeshCurvedWorldCustomFunction_1d12c500e42ebf8b903bf40b7a0a5e2c_normal_4);
            description.Position = _SHGTerrainToMeshCurvedWorldCustomFunction_1d12c500e42ebf8b903bf40b7a0a5e2c_vertex_0;
            description.Normal = _SHGTerrainToMeshCurvedWorldCustomFunction_1d12c500e42ebf8b903bf40b7a0a5e2c_normal_4;
            description.Tangent = IN.ObjectSpaceTangent;
            return description;
        }
        
        // Custom interpolators, pre surface
        #ifdef FEATURES_GRAPH_VERTEX
        Varyings CustomInterpolatorPassThroughFunc(inout Varyings output, VertexDescription input)
        {
        return output;
        }
        #define CUSTOMINTERPOLATOR_VARYPASSTHROUGH_FUNC
        #endif
        
        // Graph Pixel
        struct SurfaceDescription
        {
            float3 BaseColor;
        };
        
        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            float4 _UV_d56c6fdf7ac2828fa944da2372119006_Out_0 = IN.uv0;
            float3 _SHGTerrainToMeshCalculateLayersBlendCustomFunction_24112ec2b2aa8c829e8ab4bb7ea28f60_albedo_1;
            float _SHGTerrainToMeshCalculateLayersBlendCustomFunction_24112ec2b2aa8c829e8ab4bb7ea28f60_alpha_2;
            float3 _SHGTerrainToMeshCalculateLayersBlendCustomFunction_24112ec2b2aa8c829e8ab4bb7ea28f60_normal_3;
            float _SHGTerrainToMeshCalculateLayersBlendCustomFunction_24112ec2b2aa8c829e8ab4bb7ea28f60_metallic_4;
            float _SHGTerrainToMeshCalculateLayersBlendCustomFunction_24112ec2b2aa8c829e8ab4bb7ea28f60_smoothness_5;
            float _SHGTerrainToMeshCalculateLayersBlendCustomFunction_24112ec2b2aa8c829e8ab4bb7ea28f60_occlusion_6;
            SHG_TerrainToMeshCalculateLayersBlend_float(_UV_d56c6fdf7ac2828fa944da2372119006_Out_0, _SHGTerrainToMeshCalculateLayersBlendCustomFunction_24112ec2b2aa8c829e8ab4bb7ea28f60_albedo_1, _SHGTerrainToMeshCalculateLayersBlendCustomFunction_24112ec2b2aa8c829e8ab4bb7ea28f60_alpha_2, _SHGTerrainToMeshCalculateLayersBlendCustomFunction_24112ec2b2aa8c829e8ab4bb7ea28f60_normal_3, _SHGTerrainToMeshCalculateLayersBlendCustomFunction_24112ec2b2aa8c829e8ab4bb7ea28f60_metallic_4, _SHGTerrainToMeshCalculateLayersBlendCustomFunction_24112ec2b2aa8c829e8ab4bb7ea28f60_smoothness_5, _SHGTerrainToMeshCalculateLayersBlendCustomFunction_24112ec2b2aa8c829e8ab4bb7ea28f60_occlusion_6);
            surface.BaseColor = _SHGTerrainToMeshCalculateLayersBlendCustomFunction_24112ec2b2aa8c829e8ab4bb7ea28f60_albedo_1;
            return surface;
        }
        
        // --------------------------------------------------
        // Build Graph Inputs
        #ifdef HAVE_VFX_MODIFICATION
        #define VFX_SRP_ATTRIBUTES Attributes
        #define VFX_SRP_VARYINGS Varyings
        #define VFX_SRP_SURFACE_INPUTS SurfaceDescriptionInputs
        #endif
        VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
        {
            VertexDescriptionInputs output;
            ZERO_INITIALIZE(VertexDescriptionInputs, output);
        
            output.ObjectSpaceNormal =                          input.normalOS;
            output.ObjectSpaceTangent =                         input.tangentOS.xyz;
            output.ObjectSpacePosition =                        input.positionOS;
        
            return output;
        }
        SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
        {
            SurfaceDescriptionInputs output;
            ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
        
        #ifdef HAVE_VFX_MODIFICATION
            // FragInputs from VFX come from two places: Interpolator or CBuffer.
            /* WARNING: $splice Could not find named fragment 'VFXSetFragInputs' */
        
        #endif
        
            
        
        
        
        
        
        
            #if UNITY_UV_STARTS_AT_TOP
            #else
            #endif
        
        
            output.uv0 = input.texCoord0;
        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
        #else
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        #endif
        #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        
                return output;
        }
        
        // --------------------------------------------------
        // Main
        
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/PBR2DPass.hlsl"
        
        // --------------------------------------------------
        // Visual Effect Vertex Invocations
        #ifdef HAVE_VFX_MODIFICATION
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/VisualEffectVertex.hlsl"
        #endif
        
        ENDHLSL
        }
    }
    CustomEditorForRenderPipeline "AmazingAssets.TerrainToMeshEditor.SplatmapShaderGUI" "UnityEngine.Rendering.Universal.UniversalRenderPipelineAsset"
    CustomEditor "UnityEditor.ShaderGraph.GenericShaderGraphMaterialGUI"
FallBack "Hidden/Amazing Assets/Terrain To Mesh/Fallback/Splatmap"
}
