Shader "Particles/Additive Displacement" {
Properties {
	_TintColor ("Tint Color", Color) = (0.5,0.5,0.5,0.5)
	_MainTex ("Particle Texture", 2D) = "white" {}
}

	SubShader {

		Tags { "Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent" "PreviewType"="Plane" }
		ColorMask RGB
		Blend SrcAlpha OneMinusSrcAlpha
		Cull Off Lighting Off ZWrite Off

		Pass {
		
			HLSLPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 2.0

			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/DeclareOpaqueTexture.hlsl"

			sampler2D _MainTex;
			half4 _TintColor;
			
			struct appdata_t {
				float4 vertex : POSITION;
				half4 color : COLOR;
				float2 texcoord : TEXCOORD0;
                UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct v2f {
				float4 pos : SV_POSITION;
				half4 color : COLOR;
				float2 texcoord : TEXCOORD0;
				float4 projPos : TEXCOORD2;
                UNITY_VERTEX_OUTPUT_STEREO
			};
			
			float4 _MainTex_ST;

			v2f vert (appdata_t v)
			{
				v2f o;
                UNITY_SETUP_INSTANCE_ID(v);
                UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

				VertexPositionInputs vertexInput = GetVertexPositionInputs(v.vertex.xyz);
				o.pos = vertexInput.positionCS;
				o.projPos = ComputeScreenPos (o.pos);
				o.color = v.color;
				o.texcoord = TRANSFORM_TEX(v.texcoord,_MainTex);
				return o;
			}

			half4 frag (v2f i) : SV_Target
			{
				half4 col = i.color * _TintColor * tex2D(_MainTex, i.texcoord);
				float2 disp = (i.texcoord-0.5) * 0.04 * col.a;
				half3 bgColor = SampleSceneColor(i.projPos.xy / i.projPos.w + disp);
				col.rgb = lerp(bgColor, col.rgb, col.a);
				col.rgb += 0.1;
				return col;
			}
			ENDHLSL 
		}
	}	

}
