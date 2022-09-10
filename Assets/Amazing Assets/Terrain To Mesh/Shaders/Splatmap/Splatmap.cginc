#ifndef VACUUM_SHADERS_T2M_DEFERRED_CGINC
#define VACUUM_SHADERS_T2M_DEFERRED_CGINC


#define TERRAIN_TO_MESH_RP_UNIVERSAL


#include "../cginc/Core.cginc"


#if defined(TERRAIN_TO_MESH_FALLBACK)
    TEXTURE2D(_BaseMap); SAMPLER(sampler_BaseMap);
    TEXTURE2D(_BumpMap);
#endif



//Curved World//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void SHG_TerrainToMeshCurvedWorld_float(float3 inVertex, float3 inNormal, float4 inTangent, out float3 outVertex, out float3 outNormal)
{
    float4 vertex = float4(inVertex, 1);
    float3 normal = inNormal;
    float4 tangent =  inTangent;

    //Curved World
    #if defined(CURVEDWORLD_IS_INSTALLED) && !defined(CURVEDWORLD_DISABLED_ON)
        #ifdef CURVEDWORLD_NORMAL_TRANSFORMATION_ON            
            CURVEDWORLD_TRANSFORM_VERTEX_AND_NORMAL(vertex, normal, tangent)
        #else
            CURVEDWORLD_TRANSFORM_VERTEX(vertex)
        #endif
    #endif


    outVertex = vertex.xyz;
    outNormal = normal.xyz;
}

void SHG_TerrainToMeshCurvedWorld_half(float3 inVertex, float3 inNormal, float4 inTangent, out float3 outVertex, out float3 outNormal)
{
    SHG_TerrainToMeshCurvedWorld_float(inVertex, inNormal, inTangent, outVertex, outNormal);
}


//Holes//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void SHG_TerrainToMeshCalculateClipValue_float(float4 uv, out float clipValue)
{
     clipValue = TerrainToMeshCalculateClipValue(uv.xy);	
}

void SHG_TerrainToMeshCalculateClipValue_half(float4 uv, out float clipValue)
{
     SHG_TerrainToMeshCalculateClipValue_float(uv, clipValue);	
} 


//Layers//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void SHG_TerrainToMeshCalculateLayersBlend_float(float4 uv, out float3 albedoValue, out float alphaValue, out float3 normalValue, out float metallicValue, out float smoothnessValue, out float occlusionValue)
{
    #if defined(TERRAIN_TO_MESH_FALLBACK)

        float4 baseColor = SAMPLE_TEXTURE2D(_BaseMap, sampler_BaseMap, uv.xy);
        albedoValue = baseColor.rgb;
        alphaValue = baseColor.a;

        //Unpack normal
        float4 bumpMap = SAMPLE_TEXTURE2D(_BumpMap, sampler_BaseMap, uv.xy);
        normalValue.rgb = UnpackNormal(bumpMap);

        //
        metallicValue = 0;
        smoothnessValue = 0;
        occlusionValue = 1;

    #elif defined(SHADERPASS_SHADOWCASTER) || defined(SHADERPASS_DEPTHONLY)

        albedoValue = 0;
        alphaValue = 1;
        normalValue = float3(0, 0, 1);
        metallicValue = 0;
        smoothnessValue = 0;
        occlusionValue = 0;

    #else

        TerrainToMeshCalculateLayersBlend(uv.xy, albedoValue, alphaValue, normalValue, metallicValue, smoothnessValue, occlusionValue);	

    #endif
}

void SHG_TerrainToMeshCalculateLayersBlend_half(float4 uv, inout float3 albedoValue, inout float alphaValue, inout float3 normalValue, inout float metallicValue, inout float smoothnessValue, out float occlusionValue)
{
    SHG_TerrainToMeshCalculateLayersBlend_float(uv, albedoValue, alphaValue, normalValue, metallicValue, smoothnessValue, occlusionValue);	
}

 
#endif   