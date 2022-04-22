Shader "LiquidVolume/DepthPrePass" {
	Properties {
		_Color ("Color", Color) = (0,0,1,1)
	}
	SubShader {

	CGINCLUDE

		#include "UnityCG.cginc"

		float _FlaskThickness;

		struct v2f {
			float4 pos: SV_POSITION;
            float3 worldPos: TEXCOORD0;
			UNITY_VERTEX_INPUT_INSTANCE_ID
            UNITY_VERTEX_OUTPUT_STEREO
		};
		
		v2f vert(appdata_base v) {
    		v2f o;
			UNITY_SETUP_INSTANCE_ID(v);
			UNITY_INITIALIZE_OUTPUT(v2f, o);
            UNITY_TRANSFER_INSTANCE_ID(v, o);
			UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
            o.pos = UnityObjectToClipPos(v.vertex);
            o.worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
    		return o;
		}
		
		v2f vertBack(appdata_base v) {
    		v2f o;
			UNITY_SETUP_INSTANCE_ID(v);
			UNITY_INITIALIZE_OUTPUT(v2f, o);
            UNITY_TRANSFER_INSTANCE_ID(v, o);
			UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
			v.vertex.xyz *= _FlaskThickness;
            o.pos = UnityObjectToClipPos(v.vertex);
            o.worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
    		return o;
		}

		inline float3 ProjectOnPlane(float3 v, float3 planeNormal) {
			float sqrMag = dot(planeNormal, planeNormal);
			float dt = dot(v, planeNormal);
			return v - planeNormal * dt / sqrMag;
		}

		float4 frag (v2f i) : SV_Target {
            UNITY_SETUP_INSTANCE_ID(i);
            UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(i);

            float distPersp = distance(_WorldSpaceCameraPos, i.worldPos);

			float3 cameraForward = UNITY_MATRIX_V[2].xyz;
			float3 orthoCameraPos = ProjectOnPlane(i.worldPos - _WorldSpaceCameraPos, cameraForward) + _WorldSpaceCameraPos;
			float distOrtho = distance(orthoCameraPos, i.worldPos);

			float dist = lerp(distPersp, distOrtho, unity_OrthoParams.w);

            #if LIQUID_VOLUME_FP_RENDER_TEXTURES
				return dist;
			#else
				return EncodeFloatRGBA( 1.0 / (1.0 + dist) );
			#endif
		}

	ENDCG

	Pass {	
        Cull Front
        ZWrite Off
		//ZTest Always
		CGPROGRAM
		#pragma vertex vert
		#pragma fragment frag
        #pragma fragmentoption ARB_precision_hint_fastest
        #pragma multi_compile _ LIQUID_VOLUME_FP_RENDER_TEXTURES
		ENDCG
	}

	Pass {	
        Cull Front
        ZWrite Off
		ZTest Greater
		CGPROGRAM
		#pragma vertex vertBack
		#pragma fragment frag
        #pragma fragmentoption ARB_precision_hint_fastest
        #pragma multi_compile _ LIQUID_VOLUME_FP_RENDER_TEXTURES
		ENDCG
	} 	

}
}

    