#include "UnityCG.cginc"

		float _LevelPos;
		float3 _FlaskThickness;
		sampler2D _NoiseTex2D;
		float4 _Turbulence;
		float _AlphaCombined;
		float3 _Size;
		float _FoamTurbulence;
		float _TurbulenceSpeed;


		struct v2f {
		    V2F_SHADOW_CASTER;
		    float3 worldPos: TEXCOORD1;
		    float4 vertex: TEXCOORD2;
			UNITY_VERTEX_INPUT_INSTANCE_ID
			UNITY_VERTEX_OUTPUT_STEREO
		};

		v2f vert(appdata_base v) {
    		v2f o;

		    UNITY_SETUP_INSTANCE_ID(v);
			UNITY_TRANSFER_INSTANCE_ID(v, o);
			UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

			o.vertex = v.vertex;
			o.vertex.w = dot(o.vertex.xz, _Turbulence.zw) + _TurbulenceSpeed;
			o.vertex.xz *= 0.1.xx * _Turbulence.xx;
			o.vertex.xz += _Time.xx;
			v.vertex.xyz *= _FlaskThickness;
           	o.worldPos = mul(unity_ObjectToWorld, float4(v.vertex.xyz, 1.0)).xyz;
           	TRANSFER_SHADOW_CASTER_NORMALOFFSET(o)
    		return o;
		}

		float4 frag (v2f i) : SV_Target {
            UNITY_SETUP_INSTANCE_ID(i);
            UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(i);

			float h = tex2D(_NoiseTex2D, i.vertex.xz).g;
			float turbulence = (h - 0.5) * _Turbulence.x + sin(i.vertex.w) * _Turbulence.y;
			turbulence *= 0.05 * _Size.y * _FoamTurbulence;
			_LevelPos += turbulence;
			
			clip(_LevelPos - i.worldPos.y);
			
			float2 dither  = dot(float2(171.0, 231.0), (i.worldPos.xz + i.worldPos.yz + h.xx * 0.0001) * _ScreenParams.xy).xx;
      		dither     = frac(dither / float2(103.0, 71.0));
      		
			clip (_AlphaCombined - ((dither.x + dither.y) * 0.35 + 0.25));

			SHADOW_CASTER_FRAGMENT(i)
		}

	