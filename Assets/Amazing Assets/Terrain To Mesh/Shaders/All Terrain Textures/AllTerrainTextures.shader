
Shader "Hidden/Amazing Assets/Terrain To Mesh/AllTerrainTextures"
{
	Properties 
	{
		_Color("", Color) = (1, 1, 1, 1)
		_MainTex("", 2D) = "white" {}
			
		_ControlMap ("", 2D) = "black" {}
		_ChannelIndex ("", float) = 4

		_PaintDiffuseMap ("", 2D) = "white" {}
		_PaintNormalMap ("", 2D) = "bump" {}
		_PaintNormalScale("", float) = 1

		_PaintMaskMap ("", 2D) = "white" {}

		_PaintSpecular("", Color) = (1, 1, 1, 1)
		_PaintMetallic("", float) = 0
		_PaintSmoothness("", float) = 1
		_PaintSmoothnessFromDiffuseAlpha("", float) = 0

		_PaintUVScaleOffset("", vector) = (1, 1, 0, 0)
		_PaintSplitUVOffset("", vector) = (1, 1, 0, 0)
	}
	 


	CGINCLUDE

	#include "UnityCG.cginc"


	float4 _Color;

	sampler2D _MainTex;
	float4 _MainTex_TexelSize; 

	sampler2D _ControlMap;
	float _ChannelIndex;

	sampler2D _PaintDiffuseMap;
	sampler2D _PaintNormalMap;
	float _PaintNormalClear;
	float _PaintNormalScale;	

	sampler2D _PaintMaskMap;
	float4 _PaintSpecular;
	float _PaintMetallic;
	float _PaintSmoothness; 
	int _PaintSmoothnessFromDiffuseAlpha;
	float _PaintOccclusion;

	float4 _MaskRemapMin;
	float4 _MaskRemapMax;	

	float4 _PaintUVScaleOffset;
	float4 _PaintSplitUVOffset;

	float _FlipNormal;
	float _WorldSpaceUV;
	float2 _Remap01;

	float _RotationDegree;
	float _GammaToLinear;


	float ControlValue(float2 uv)
	{
		if(_ChannelIndex < 0.5)
			return tex2D (_ControlMap, uv).r;
		else if(_ChannelIndex < 1.5)
			return tex2D (_ControlMap, uv).g;
		else if(_ChannelIndex < 2.5)
			return tex2D (_ControlMap, uv).b;
		else 
			return tex2D (_ControlMap, uv).a;		
	}

	void TerrainToWorldUV(float2 uv, out float2 mapUV, out float2 controlUV)
	{
		_PaintUVScaleOffset.zw += _PaintUVScaleOffset.xy * _PaintSplitUVOffset.zw;
		_PaintUVScaleOffset.xy *= _PaintSplitUVOffset.xy;

		mapUV     = float2(uv * _PaintUVScaleOffset.xy + _PaintUVScaleOffset.zw);		
		controlUV = float2(uv * _PaintSplitUVOffset.xy + _PaintSplitUVOffset.zw);
								
		mapUV     = lerp(mapUV, 1 - mapUV, _WorldSpaceUV);
		controlUV = lerp(controlUV, 1 - controlUV, _WorldSpaceUV);
	}

	float2 RotateUV(float2 uv)
	{									   
		uv -= 0.5;
		float s = sin(_RotationDegree);
		float c = cos(_RotationDegree);
		float2x2 rMatrix = float2x2(c, -s, s, c);
		rMatrix *= 0.5;
		rMatrix += 0.5;
		rMatrix = rMatrix * 2 - 1;
		uv.xy = mul(uv.xy, rMatrix);
		uv += 0.5;

		return uv;
	}

	float Remap01(float value)
	{
		value = (value - _Remap01.x) * (1.0 / (_Remap01.y - _Remap01.x));

		return saturate(value);
	}

	float4 RemapMin01Max01(float4 value, float4 outMin, float4 outMax)
	{ 
		return outMin + value * (outMax - outMin);
	} 

	float3 HeightToNormal(float2 uv)
	{
    	float2 uvOffset = _MainTex_TexelSize * 1;


        float K1 = Remap01(tex2D(_MainTex, uv + float2( uvOffset.x * -1, uvOffset.y)).r);
        float K2 = Remap01(tex2D(_MainTex, uv + float2(               0, uvOffset.y)).r);
        float K3 = Remap01(tex2D(_MainTex, uv + float2(      uvOffset.x, uvOffset.y)).r);

        float K4 = Remap01(tex2D(_MainTex, uv + float2( uvOffset.x * -1, 0)).r);
        float K5 = Remap01(tex2D(_MainTex, uv + float2(               0, 0)).r);
        float K6 = Remap01(tex2D(_MainTex, uv + float2(      uvOffset.x, 0)).r);

        float K7 = Remap01(tex2D(_MainTex, uv + float2( uvOffset.x * -1, uvOffset.y * -1)).r);
        float K8 = Remap01(tex2D(_MainTex, uv + float2(               0, uvOffset.y * -1)).r);
        float K9 = Remap01(tex2D(_MainTex, uv + float2(      uvOffset.x, uvOffset.y * -1)).r);




        float3 n;
        n.x = 60 * (K9 - K7 + 2 * (K6 - K4) + K3 - K1) * -1;
        n.y = 60 * (K1 - K7 + 2 * (K2 - K8) + K3 - K9) * -1;
        n.z = 1.0;

		if(_RotationDegree > 1)
			n.xy *= -1;

        n = normalize(n);
			
		return n;
    }

	float4 fragBasemapDiffuse(v2f_img i) : SV_Target 
	{
		float2 mapUV, controlUV;
		TerrainToWorldUV(i.uv, mapUV, controlUV);
		

		float4 c = tex2D(_MainTex, i.uv) + tex2D (_PaintDiffuseMap, mapUV) * _Color * float4(1, 1, 1, _PaintSmoothness) * ControlValue(controlUV);

		return c;
	} 

	float4 fragBasemapNormal(v2f_img i) : SV_Target
	{
		float2 mapUV, controlUV;
		TerrainToWorldUV(i.uv, mapUV, controlUV);
		

		float4 normal = tex2D (_PaintNormalMap, mapUV);	
		if(_PaintNormalClear > 0.5)	
			normal = float4(0.5f, 0.5f, 1, 1);
		

		//[-1, 1]
		normal = normal * 2 - 1;

		//Flip normal 
		normal.yw *= _PaintNormalScale * lerp(1, -1, _FlipNormal);

		//[0, 1]
		normal = (normal + 1) / 2;


		float4 c = tex2D(_MainTex, i.uv) + normal * ControlValue(controlUV);

		return c;
	}

	float4 fragBasemapNormalUnpacked(v2f_img i) : SV_Target
	{
		float4 c = tex2D(_MainTex, i.uv);

		c.rgb = UnpackNormal(c) * 0.5 + 0.5;		

		c.rgb = lerp(c.rgb, 1 - c.rgb, _WorldSpaceUV);


		c.b = 1;
		c.a = 1;

		return c;
	}

	float4 fragBasemapMask(v2f_img i) : SV_Target 
	{
		float2 mapUV, controlUV;
		TerrainToWorldUV(i.uv, mapUV, controlUV);
		
		float smoothnessValue = lerp(_PaintSmoothness, tex2D (_PaintDiffuseMap, mapUV).a, _PaintSmoothnessFromDiffuseAlpha);

		float4 c = tex2D(_MainTex, i.uv) + RemapMin01Max01(tex2D (_PaintMaskMap, mapUV) * float4(_PaintMetallic, _PaintOccclusion, 0, smoothnessValue), _MaskRemapMin, _MaskRemapMax) * ControlValue(controlUV);


		return c;
	} 

	float4 fragBasemapSpecular(v2f_img i) : SV_Target 
	{
		float2 mapUV, controlUV;
		TerrainToWorldUV(i.uv, mapUV, controlUV);
		

		float4 c = tex2D(_MainTex, i.uv) + float4(_PaintSpecular.rgb, 1) * float4(1, 1, 1, tex2D (_PaintDiffuseMap, mapUV).a * _PaintSmoothness) * ControlValue(controlUV);

		return c;
	} 

	float4 fragBasemapMetallic(v2f_img i) : SV_Target 
	{
		float2 mapUV, controlUV;
		TerrainToWorldUV(i.uv, mapUV, controlUV);


		float4 c = tex2D(_MainTex, i.uv) + float4(_PaintMetallic, 0, 0, tex2D (_PaintDiffuseMap, mapUV).a * _PaintSmoothness) * ControlValue(controlUV);

		return c;
	} 

	float4 fragBasemapSmoothness(v2f_img i) : SV_Target 
	{
		float2 mapUV, controlUV;
		TerrainToWorldUV(i.uv, mapUV, controlUV);


		float4 c = tex2D(_MainTex, i.uv) + float4(1, 0, 0, 1) * _PaintSmoothness * tex2D (_PaintDiffuseMap, mapUV).a * ControlValue(controlUV);

		return c;
	} 

	float4 fragBasemapOcclusion(v2f_img i) : SV_Target 
	{
		float2 mapUV, controlUV;
		TerrainToWorldUV(i.uv, mapUV, controlUV);


		float4 c = tex2D(_MainTex, i.uv) + float4(RemapMin01Max01(tex2D (_PaintMaskMap, mapUV) * float4(0, _PaintOccclusion, 0, 0), _MaskRemapMin, _MaskRemapMax).ggg, 1) * ControlValue(controlUV);

		return c;
	} 

	float4 fragGeneric(v2f_img i) : SV_Target 
	{
		i.uv = RotateUV(i.uv);

		float4 c = tex2D(_MainTex, i.uv);
		
		return c;
	} 

	float4 fragGenericHolesmap(v2f_img i) : SV_Target 
	{
		i.uv = RotateUV(i.uv);

		float4 c = tex2D(_MainTex, i.uv);

		return float4(c.xxx, 1);
	} 

	float4 fragGenericHeightmap(v2f_img i) : SV_Target 
	{
		i.uv = RotateUV(i.uv);

		float c = tex2D(_MainTex, i.uv);


		//Remap
		c.r = Remap01(c.r);


		if(_GammaToLinear > 0.5)
			c = GammaToLinearSpaceExact(c);

		return c;
	} 

	float4 fragGenericHeightmapNormal(v2f_img i) : SV_Target 
	{
		i.uv = RotateUV(i.uv);

		float3 c = HeightToNormal(i.uv);

		c.rgb = (c) * 0.5 + 0.5;		

		return float4(c, 1);
	} 

	float4 fragHolesToBasemap(v2f_img i) : SV_Target 
	{
		float4 c = tex2D(_MainTex, i.uv);
		float4 holes = tex2D(_ControlMap, i.uv);

		c.a = holes.r;
		
		return c;
	} 

	ENDCG 
	

	SubShader    
	{				    
		Pass	//0
	    {
			ZTest Always Cull Off ZWrite Off

			CGPROGRAM
			#pragma vertex vert_img
	    	#pragma fragment fragBasemapDiffuse
			ENDCG

		} //Pass
		
		Pass	//1
	    {
			ZTest Always Cull Off ZWrite Off

			CGPROGRAM
			#pragma vertex vert_img 
	    	#pragma fragment fragBasemapNormal
			ENDCG

		} //Pass

		Pass	//2
	    {
			ZTest Always Cull Off ZWrite Off

			CGPROGRAM
			#pragma vertex vert_img
	    	#pragma fragment fragBasemapNormalUnpacked
			ENDCG

		} //Pass

		Pass	//3
	    {
			ZTest Always Cull Off ZWrite Off

			CGPROGRAM
			#pragma vertex vert_img
	    	#pragma fragment fragBasemapMask
			ENDCG

		} //Pass

		Pass	//4
	    {
			ZTest Always Cull Off ZWrite Off

			CGPROGRAM
			#pragma vertex vert_img
	    	#pragma fragment fragBasemapSpecular
			ENDCG

		} //Pass

		Pass	//5
	    {
			ZTest Always Cull Off ZWrite Off

			CGPROGRAM
			#pragma vertex vert_img
	    	#pragma fragment fragBasemapMetallic
			ENDCG

		} //Pass

		Pass	//6
	    {
			ZTest Always Cull Off ZWrite Off

			CGPROGRAM
			#pragma vertex vert_img
	    	#pragma fragment fragBasemapSmoothness
			ENDCG

		} //Pass

		Pass	//7
	    {
			ZTest Always Cull Off ZWrite Off

			CGPROGRAM
			#pragma vertex vert_img
	    	#pragma fragment fragBasemapOcclusion
			ENDCG

		} //Pass

		Pass	//8
	    {
			ZTest Always Cull Off ZWrite Off

			CGPROGRAM
			#pragma vertex vert_img
	    	#pragma fragment fragGeneric
			ENDCG

		} //Pass

		Pass	//9
	    {
			ZTest Always Cull Off ZWrite Off

			CGPROGRAM
			#pragma vertex vert_img
	    	#pragma fragment fragGenericHolesmap
			ENDCG

		} //Pass

		Pass	//10
	    {
			ZTest Always Cull Off ZWrite Off

			CGPROGRAM
			#pragma vertex vert_img
	    	#pragma fragment fragGenericHeightmap
			ENDCG

		} //Pass

		Pass	//11
	    {
			ZTest Always Cull Off ZWrite Off

			CGPROGRAM
			#pragma vertex vert_img
	    	#pragma fragment fragGenericHeightmapNormal
			ENDCG

		} //Pass

		Pass	//12
	    {
			ZTest Always Cull Off ZWrite Off

			CGPROGRAM
			#pragma vertex vert_img
	    	#pragma fragment fragHolesToBasemap
			ENDCG

		} //Pass

	} //SubShader
	 
} //Shader
