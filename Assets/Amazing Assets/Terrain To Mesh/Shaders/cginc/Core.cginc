#ifndef TERRAIN_TO_MESH_CORE_CGINC
#define TERRAIN_TO_MESH_CORE_CGINC



#include "Variables.cginc"


float4 TerrainToMeshRemap(float4 value, float4 outMin, float4 outMax)
{ 
    return outMin + value * (outMax - outMin);
} 

//Unity_NormalStrength_float
float3 TerrainToMeshNormalStrength(float3 In, float Strength)
{
	return float3(In.rg * Strength, lerp(1, In.b, saturate(Strength)));
}

#if defined(_T2M_TEXTURE_SAMPLE_TYPE_ARRAY)
	
	#define T2M_UNPACK_SPLATMAP(uv,index)            SAMPLE_TEXTURE2D_ARRAY(_T2M_SplatMaps2DArray, sampler_T2M_SplatMaps2DArray, uv, index);
	#define T2M_UNPACK_PAINTMAP(uv,index,sum,splat)	 float4 paintColor##index = (_T2M_Layer_##index##_MapsUsage.x > 0.5 ? SAMPLE_TEXTURE2D_ARRAY(_T2M_DiffuseMaps2DArray, sampler_T2M_DiffuseMaps2DArray, uv * _T2M_Layer_##index##_uvScaleOffset, paintMapUsageIndex) : float4(1, 1, 1, 1));  paintMapUsageIndex += _T2M_Layer_##index##_MapsUsage.x > 0.5 ? 1 : 0;  sum += paintColor##index * _T2M_Layer_##index##_ColorTint * splat;

	#define T2M_UNPACK_NORMAL_MAP(index,uv,sum,splat) sum += TerrainToMeshNormalStrength(UnpackNormal(SAMPLE_TEXTURE2D_ARRAY(_T2M_NormalMaps2DArray, sampler_T2M_NormalMaps2DArray, uv * _T2M_Layer_##index##_uvScaleOffset, normalMapUsageIndex)), _T2M_Layer_##index##_NormalScale) * splat;	normalMapUsageIndex += 1;
	#define T2M_UNPACK_MASK(index,uv,sum,splat)       sum += TerrainToMeshRemap(SAMPLE_TEXTURE2D_ARRAY(_T2M_MaskMaps2DArray, sampler_T2M_MaskMaps2DArray, uv * _T2M_Layer_##index##_uvScaleOffset, maskMapUsageIndex), _T2M_Layer_##index##_MaskMapRemapMin, _T2M_Layer_##index##_MaskMapRemapMax) * splat; maskMapUsageIndex += 1;
#else

	#define T2M_UNPACK_SPLATMAP(uv,index)            SAMPLE_TEXTURE2D(_T2M_SplatMap_##index, sampler_T2M_SplatMap_0, uv);
	#define T2M_UNPACK_PAINTMAP(uv,index,sum,splat)	 float4 paintColor##index = SAMPLE_TEXTURE2D(_T2M_Layer_##index##_Diffuse, sampler_T2M_Layer_0_Diffuse, uv * _T2M_Layer_##index##_uvScaleOffset);	sum += paintColor##index * _T2M_Layer_##index##_ColorTint * splat;

	#define T2M_UNPACK_NORMAL_MAP(index,uv,sum,splat) sum += TerrainToMeshNormalStrength(UnpackNormal(SAMPLE_TEXTURE2D(_T2M_Layer_##index##_NormalMap, sampler_T2M_Layer_0_Diffuse, uv * _T2M_Layer_##index##_uvScaleOffset)), _T2M_Layer_##index##_NormalScale) * splat;
	#define T2M_UNPACK_MASK(index,uv,sum,splat)       sum += TerrainToMeshRemap(SAMPLE_TEXTURE2D(_T2M_Layer_##index##_Mask, sampler_T2M_Layer_0_Diffuse, uv * _T2M_Layer_##index##_uvScaleOffset), _T2M_Layer_##index##_MaskMapRemapMin, _T2M_Layer_##index##_MaskMapRemapMax) * splat;
#endif

#define T2M_UNPACK_METALLIC_OCCLUSION_SMOOTHNESS(index,sum,splat)   sum += float4(_T2M_Layer_##index##_MetallicOcclusionSmoothness.rgb, lerp(_T2M_Layer_##index##_MetallicOcclusionSmoothness.a, paintColor##index.a, _T2M_Layer_##index##_SmoothnessFromDiffuseAlpha)) * splat;




float TerrainToMeshCalculateClipValue(float2 uv)
{
	#if defined(_ALPHATEST_ON)

		float4 holesmap = SAMPLE_TEXTURE2D(_T2M_HolesMap, sampler_T2M_HolesMap, uv);
		return holesmap.r;

	#else 
		
		return 1;

	#endif
}


void TerrainToMeshCalculateLayersBlend(float2 uv, out float3 albedoValue, out float alphaValue, out float3 normalValue, out float metallicValue, out float smoothnessValue, out float occlusionValue)
{
	//Splatmaps//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	float4 splatmap0 = T2M_UNPACK_SPLATMAP(uv, 0);

	#if defined(NEED_SPLAT_MAP_1)
		float4 splatmap1 = T2M_UNPACK_SPLATMAP(uv, 1);
    #endif

	#if defined(NEED_SPLAT_MAP_2)
		float4 splatmap2 = T2M_UNPACK_SPLATMAP(uv, 2);
    #endif

	#if defined(NEED_SPLAT_MAP_3)
		float4 splatmap3 = T2M_UNPACK_SPLATMAP(uv, 3);
	#endif


	//Paint Textures////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	float4 paintColorSum = 0;


	#if defined(_T2M_TEXTURE_SAMPLE_TYPE_ARRAY)
		int paintMapUsageIndex = 0;
	#endif


	T2M_UNPACK_PAINTMAP(uv, 0, paintColorSum, splatmap0.r);
    T2M_UNPACK_PAINTMAP(uv, 1, paintColorSum, splatmap0.g);

	#if defined(NEED_PAINT_MAP_2)
		T2M_UNPACK_PAINTMAP(uv, 2, paintColorSum, splatmap0.b);
	#endif

	#if defined(NEED_PAINT_MAP_3)
		T2M_UNPACK_PAINTMAP(uv, 3, paintColorSum, splatmap0.a);
	#endif

	#if defined(NEED_SPLAT_MAP_1)
		#if defined(NEED_PAINT_MAP_4)
			T2M_UNPACK_PAINTMAP(uv, 4, paintColorSum, splatmap1.r);
		#endif

		#if defined(NEED_PAINT_MAP_5)
			T2M_UNPACK_PAINTMAP(uv, 5, paintColorSum, splatmap1.g);
		#endif

		#if defined(NEED_PAINT_MAP_6)
			T2M_UNPACK_PAINTMAP(uv, 6, paintColorSum, splatmap1.b);
		#endif

		#if defined(NEED_PAINT_MAP_7)
			T2M_UNPACK_PAINTMAP(uv, 7, paintColorSum, splatmap1.a);
		#endif
	#endif

	#if defined(NEED_SPLAT_MAP_2)
		#if defined(NEED_PAINT_MAP_8)
			T2M_UNPACK_PAINTMAP(uv, 8, paintColorSum, splatmap2.r);
		#endif

		#if defined(NEED_PAINT_MAP_9)
			T2M_UNPACK_PAINTMAP(uv, 9, paintColorSum, splatmap2.g);
		#endif

		#if defined(NEED_PAINT_MAP_10)
			T2M_UNPACK_PAINTMAP(uv, 10, paintColorSum, splatmap2.b);
		#endif

		#if defined(NEED_PAINT_MAP_11)
			T2M_UNPACK_PAINTMAP(uv, 11, paintColorSum, splatmap2.a);
		#endif
	#endif

	#if defined(NEED_SPLAT_MAP_3)
		#if defined(NEED_PAINT_MAP_12)
			T2M_UNPACK_PAINTMAP(uv, 12, paintColorSum, splatmap3.r);
		#endif

		#if defined(NEED_PAINT_MAP_13)
			T2M_UNPACK_PAINTMAP(uv, 13, paintColorSum, splatmap3.g);
		#endif

		#if defined(NEED_PAINT_MAP_14)
			T2M_UNPACK_PAINTMAP(uv, 14, paintColorSum, splatmap3.b);
		#endif

		#if defined(NEED_PAINT_MAP_15)
			T2M_UNPACK_PAINTMAP(uv, 15, paintColorSum, splatmap3.a);
		#endif
	#endif


	albedoValue = paintColorSum.rgb;
	alphaValue = paintColorSum.a;



	//Normal//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	#ifdef TERRAIN_TO_MESH_NEED_NORMAL

		float3 emptyNormal = float3(0, 0, 1);
		normalValue = 0;

		#if defined(_T2M_TEXTURE_SAMPLE_TYPE_ARRAY)
			int normalMapUsageIndex = 0;
		#endif


		#if defined(_T2M_LAYER_0_NORMAL)
			T2M_UNPACK_NORMAL_MAP(0, uv, normalValue, splatmap0.r);
		#else 
			normalValue += splatmap0.r * emptyNormal;
		#endif

		#if defined(_T2M_LAYER_1_NORMAL)
			T2M_UNPACK_NORMAL_MAP(1, uv, normalValue, splatmap0.g);
		#else 
			normalValue += splatmap0.g * emptyNormal;
		#endif

		#ifdef NEED_PAINT_MAP_2
			#if defined(_T2M_LAYER_2_NORMAL)
				T2M_UNPACK_NORMAL_MAP(2, uv, normalValue, splatmap0.b);
			#else 
				normalValue += splatmap0.b * emptyNormal;
			#endif
		#endif

		#ifdef NEED_PAINT_MAP_3
			#if defined(_T2M_LAYER_3_NORMAL)
				T2M_UNPACK_NORMAL_MAP(3, uv, normalValue, splatmap0.a);
			#else 
				normalValue += splatmap0.a * emptyNormal;
			#endif
		#endif

		#if defined(NEED_SPLAT_MAP_1)
			#ifdef NEED_PAINT_MAP_4
				#if defined(_T2M_LAYER_4_NORMAL)
					T2M_UNPACK_NORMAL_MAP(4, uv, normalValue, splatmap1.r);
				#else 
					normalValue += splatmap1.r * emptyNormal;
				#endif
			#endif

			#ifdef NEED_PAINT_MAP_5
				#if defined(_T2M_LAYER_5_NORMAL)
					T2M_UNPACK_NORMAL_MAP(5, uv, normalValue, splatmap1.g);
				#else 
					normalValue += splatmap1.g * emptyNormal;
				#endif
			#endif

			#ifdef NEED_PAINT_MAP_6
				#if defined(_T2M_LAYER_6_NORMAL)
					T2M_UNPACK_NORMAL_MAP(6, uv, normalValue, splatmap1.b);
				#else 
					normalValue += splatmap1.b * emptyNormal;
				#endif
			#endif

			#ifdef NEED_PAINT_MAP_7
				#if defined(_T2M_LAYER_7_NORMAL)
					T2M_UNPACK_NORMAL_MAP(7, uv, normalValue, splatmap1.a);
				#else 
					normalValue += splatmap1.a * emptyNormal;
				#endif
			#endif
		#endif

		#if defined(NEED_SPLAT_MAP_2)
			#ifdef NEED_PAINT_MAP_8
				#if defined(_T2M_LAYER_8_NORMAL)
					T2M_UNPACK_NORMAL_MAP(8, uv, normalValue, splatmap2.r);
				#else 
					normalValue += splatmap2.r * emptyNormal;
				#endif
			#endif

			#ifdef NEED_PAINT_MAP_9
				#if defined(_T2M_LAYER_9_NORMAL)
					T2M_UNPACK_NORMAL_MAP(9, uv, normalValue, splatmap2.g);
				#else 
					normalValue += splatmap2.g * emptyNormal;
				#endif
			#endif

			#ifdef NEED_PAINT_MAP_10
				#if defined(_T2M_LAYER_10_NORMAL)
					T2M_UNPACK_NORMAL_MAP(10, uv, normalValue, splatmap2.b);
				#else 
					normalValue += splatmap2.b * emptyNormal;
				#endif
			#endif

			#ifdef NEED_PAINT_MAP_11
				#if defined(_T2M_LAYER_11_NORMAL)
					T2M_UNPACK_NORMAL_MAP(11, uv, normalValue, splatmap2.a);
				#else 
					normalValue += splatmap2.a * emptyNormal;
				#endif
			#endif
		#endif

		#if defined(NEED_SPLAT_MAP_3)
			#ifdef NEED_PAINT_MAP_12
				#if defined(_T2M_LAYER_12_NORMAL)
					T2M_UNPACK_NORMAL_MAP(12, uv, normalValue, splatmap3.r);
				#else 
					normalValue += splatmap3.r * emptyNormal;
				#endif
			#endif

			#ifdef NEED_PAINT_MAP_13
				#if defined(_T2M_LAYER_13_NORMAL)
					T2M_UNPACK_NORMAL_MAP(13, uv, normalValue, splatmap3.g);
				#else 
					normalValue += splatmap3.g * emptyNormal;
				#endif
			#endif

			#ifdef NEED_PAINT_MAP_14
				#if defined(_T2M_LAYER_14_NORMAL)
					T2M_UNPACK_NORMAL_MAP(14, uv, normalValue, splatmap3.b);
				#else 
					normalValue += splatmap3.b * emptyNormal;
				#endif
			#endif

			#ifdef NEED_PAINT_MAP_15
				#if defined(_T2M_LAYER_15_NORMAL)
					T2M_UNPACK_NORMAL_MAP(15, uv, normalValue, splatmap3.a);
				#else 
					normalValue += splatmap3.a * emptyNormal;
				#endif
			#endif
		#endif

	#else

		normalValue = float3(0, 0, 1);

	#endif



	//Metallic, Occlusion, Smoothness////////////////////////////////////////////////////////////////////////////////////////////////////////
	#ifdef TERRAIN_TO_MESH_NEED_METALLIC_SMOOTHNESS_OCCLUSION

		float4 metallicSmoothnessOcclusion = 0;

		#if defined(_T2M_TEXTURE_SAMPLE_TYPE_ARRAY)
			int maskMapUsageIndex = 0;
		#endif


		#if defined(_T2M_LAYER_0_MASK)
			T2M_UNPACK_MASK(0, uv, metallicSmoothnessOcclusion, splatmap0.r);
		#else			
			T2M_UNPACK_METALLIC_OCCLUSION_SMOOTHNESS(0, metallicSmoothnessOcclusion, splatmap0.r);
		#endif

		#if defined(_T2M_LAYER_1_MASK)
			T2M_UNPACK_MASK(1, uv, metallicSmoothnessOcclusion, splatmap0.g);
		#else
			T2M_UNPACK_METALLIC_OCCLUSION_SMOOTHNESS(1, metallicSmoothnessOcclusion, splatmap0.g);
		#endif

		#if defined(NEED_PAINT_MAP_2)
			#if defined(_T2M_LAYER_2_MASK)
				T2M_UNPACK_MASK(2, uv, metallicSmoothnessOcclusion, splatmap0.b);
			#else
				T2M_UNPACK_METALLIC_OCCLUSION_SMOOTHNESS(2, metallicSmoothnessOcclusion, splatmap0.b);
			#endif
		#endif

		#if defined(NEED_PAINT_MAP_3)
			#if defined(_T2M_LAYER_3_MASK)
				T2M_UNPACK_MASK(3, uv, metallicSmoothnessOcclusion, splatmap0.a);
			#else
				T2M_UNPACK_METALLIC_OCCLUSION_SMOOTHNESS(3, metallicSmoothnessOcclusion, splatmap0.a);
			#endif
		#endif


		#if defined(NEED_SPLAT_MAP_1)
			#if defined(NEED_PAINT_MAP_4)
				#if defined(_T2M_LAYER_4_MASK)
					T2M_UNPACK_MASK(4, uv, metallicSmoothnessOcclusion, splatmap1.r);
				#else
					T2M_UNPACK_METALLIC_OCCLUSION_SMOOTHNESS(4, metallicSmoothnessOcclusion, splatmap1.r);
				#endif
			#endif

			#if defined(NEED_PAINT_MAP_5)
				#if defined(_T2M_LAYER_5_MASK)
					T2M_UNPACK_MASK(5, uv, metallicSmoothnessOcclusion, splatmap1.g);
				#else
					T2M_UNPACK_METALLIC_OCCLUSION_SMOOTHNESS(5, metallicSmoothnessOcclusion, splatmap1.g);
				#endif
			#endif

			#if defined(NEED_PAINT_MAP_6)
				#if defined(_T2M_LAYER_6_MASK)
					T2M_UNPACK_MASK(6, uv, metallicSmoothnessOcclusion, splatmap1.b);
				#else
					T2M_UNPACK_METALLIC_OCCLUSION_SMOOTHNESS(6, metallicSmoothnessOcclusion, splatmap1.b);
				#endif
			#endif

			#if defined(NEED_PAINT_MAP_7)
				#if defined(_T2M_LAYER_7_MASK)
					T2M_UNPACK_MASK(7, uv, metallicSmoothnessOcclusion, splatmap1.a);
				#else
					T2M_UNPACK_METALLIC_OCCLUSION_SMOOTHNESS(7, metallicSmoothnessOcclusion, splatmap1.a);
				#endif
			#endif
		#endif

		#if defined(NEED_SPLAT_MAP_2)
			#if defined(NEED_PAINT_MAP_8)
				#if defined(_T2M_LAYER_8_MASK)
					T2M_UNPACK_MASK(8, uv, metallicSmoothnessOcclusion, splatmap2.r);
				#else
					T2M_UNPACK_METALLIC_OCCLUSION_SMOOTHNESS(8, metallicSmoothnessOcclusion, splatmap2.r);
				#endif
			#endif

			#if defined(NEED_PAINT_MAP_9)
				#if defined(_T2M_LAYER_9_MASK)
					T2M_UNPACK_MASK(9, uv, metallicSmoothnessOcclusion, splatmap2.g);
				#else
					T2M_UNPACK_METALLIC_OCCLUSION_SMOOTHNESS(9, metallicSmoothnessOcclusion, splatmap2.g);
				#endif
			#endif

			#if defined(NEED_PAINT_MAP_10)
				#if defined(_T2M_LAYER_10_MASK)
					T2M_UNPACK_MASK(10, uv, metallicSmoothnessOcclusion, splatmap2.b);
				#else
					T2M_UNPACK_METALLIC_OCCLUSION_SMOOTHNESS(10, metallicSmoothnessOcclusion, splatmap2.b);
				#endif
			#endif

			#if defined(NEED_PAINT_MAP_11)
				#if defined(_T2M_LAYER_11_MASK)
					T2M_UNPACK_MASK(11, uv, metallicSmoothnessOcclusion, splatmap2.a);
				#else
					T2M_UNPACK_METALLIC_OCCLUSION_SMOOTHNESS(11, metallicSmoothnessOcclusion, splatmap2.a);
				#endif
			#endif
		#endif

		#if defined(NEED_SPLAT_MAP_3)
			#if defined(NEED_PAINT_MAP_12)
				#if defined(_T2M_LAYER_12_MASK)
					T2M_UNPACK_MASK(12, uv, metallicSmoothnessOcclusion, splatmap3.r);
				#else
					T2M_UNPACK_METALLIC_OCCLUSION_SMOOTHNESS(12, metallicSmoothnessOcclusion, splatmap3.r);
				#endif
			#endif

			#if defined(NEED_PAINT_MAP_13)
				#if defined(_T2M_LAYER_13_MASK)
					T2M_UNPACK_MASK(13, uv, metallicSmoothnessOcclusion, splatmap3.g);
				#else
					T2M_UNPACK_METALLIC_OCCLUSION_SMOOTHNESS(13, metallicSmoothnessOcclusion, splatmap3.g);
				#endif
			#endif

			#if defined(NEED_PAINT_MAP_14)
				#if defined(_T2M_LAYER_14_MASK)
					T2M_UNPACK_MASK(14, uv, metallicSmoothnessOcclusion, splatmap3.b);
				#else
					T2M_UNPACK_METALLIC_OCCLUSION_SMOOTHNESS(14, metallicSmoothnessOcclusion, splatmap3.b);
				#endif
			#endif

			#if defined(NEED_PAINT_MAP_15)
				#if defined(_T2M_LAYER_15_MASK)
					T2M_UNPACK_MASK(15, uv, metallicSmoothnessOcclusion, splatmap3.a);
				#else
					T2M_UNPACK_METALLIC_OCCLUSION_SMOOTHNESS(15, metallicSmoothnessOcclusion, splatmap3.a);
				#endif
			#endif
		#endif



		metallicSmoothnessOcclusion = saturate(metallicSmoothnessOcclusion);

		metallicValue  = metallicSmoothnessOcclusion.r;
		smoothnessValue = metallicSmoothnessOcclusion.a;
		occlusionValue = metallicSmoothnessOcclusion.g;

	#else

		metallicValue = 0;
		smoothnessValue = 0;
		occlusionValue = 1;

	#endif
}

#endif
 