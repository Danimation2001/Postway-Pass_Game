// Set by the asset automatically
#define FORCE_GLES_COMPATIBILITY 0
#define LIQUID_VOLUME_SCATTERING
#define LIQUID_VOLUME_SMOKE
#define LIQUID_VOLUME_BUBBLES
#define LIQUID_VOLUME_FP_RENDER_TEXTURES
//#define LIQUID_VOLUME_ORTHO
#define LIQUID_VOLUME_USE_NOISE3D

#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/DeclareDepthTexture.hlsl"
#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/DeclareOpaqueTexture.hlsl"


		struct appdata_base {
			float4 vertex		: POSITION;
		    float3 normalOS		: NORMAL;
			float4 tangentOS    : TANGENT;
			float4 texcoord		: TEXCOORD0;
			UNITY_VERTEX_INPUT_INSTANCE_ID
		};

		struct Input {
			float4 positionCS	: SV_POSITION;
			float3 realPos		: TEXCOORD0;
			float4 vertex		: TEXCOORD1;
			float3 camPos		: TEXCOORD2;
			float4 screenPos	: TEXCOORD3;
			float3 normalWS     : TEXCOORD5;
			UNITY_VERTEX_INPUT_INSTANCE_ID
			UNITY_VERTEX_OUTPUT_STEREO
		};

		struct SurfaceOutput {
		    half3 Albedo;  // diffuse color
			half3 Normal;  // tangent space normal, if written
			half3 Emission;
			half Specular;  // specular power in 0..1 range
			half Gloss;    // specular intensity
			half Alpha;    // alpha for transparencies
		};

		sampler2D _NoiseTex2D;
		float _DepthAwareOffset;

		#if LIQUID_VOLUME_DEPTH_AWARE_PASS
			TEXTURE2D_X_FLOAT(_VLFrontBufferTexture);
		#endif
		
		#if LIQUID_VOLUME_IRREGULAR
			TEXTURE2D_X_FLOAT(_VLBackBufferTexture);
		#endif

        float3 _VertexOffset;
		half4 _Color1;
		half4 _Color2;
		half4 _FoamColor;
		float _FoamMaxPos;
		int _FoamRaySteps;
		float _FoamDensity;
		float _FoamBottom;
		float _FoamTurbulence;
		float _LevelPos;
		float3 _FlaskThickness;
		float4 _Size;
		float3 _Center;
		float _Muddy;
		float4 _Turbulence;
		float _DeepAtten;
		half4 _SmokeColor;
		float _SmokeAtten;
		int _SmokeRaySteps;
		float _SmokeSpeed;
		float _SmokeHeightAtten;
		int _LiquidRaySteps;
		half4 _GlossinessInt;
		float _FoamWeight;
		float4 _Scale;
		float _UpperLimit;
		float _LowerLimit;
		float3 wsCameraPos;
		half3	_EmissionColor;
		float _DoubleSidedBias;
        float _BackDepthBias;

        float4x4 _Rot;
        float _TurbulenceSpeed;

		float _FlaskBlurIntensity;

		half _Glossiness;
		half4 _FlaskTint;
		half4 _FlaskColor;
		half3 _LightColor;

#if defined(LIQUID_VOLUME_SCATTERING)
    float4 _PointLightPosition[6];
    half4 _PointLightColor[6];
    float _PointLightInsideAtten;
	int _PointLightCount;
#endif

int _LVForcedInvisible;

 // Open GL 2.0 / WebGL support
#if SHADER_API_GLES || FORCE_GLES_COMPATIBILITY
	#define WEBGL_OR_LEGACY
#endif

 #if defined(WEBGL_OR_LEGACY)
        sampler2D _Noise2Tex;

        inline float noise3D(float3 x) {
            x *= 100.0;
            float3 f = frac(x);
            float3 p = x - f;
            f = f*f*(3.0-2.0*f);
            float4 xy = float4(p.xy + float2(37.0,17.0)*p.z + f.xy, 0, 0);
            xy.xy = (xy.xy + 0.5) / 256.0;
            float2 zz = tex2Dlod(_Noise2Tex, xy).yx;
            return lerp( zz.x, zz.y, f.z );
        }
        #define SAMPLE_NOISE_3D(tex,pos) noise3D( (pos).xyz)
        #define BEGIN_LOOP(k,iterations,defaultIterations) for(int k=0;k<defaultIterations;k++) if (k<iterations) {
        #define END_LOOP }
#else
        sampler3D _NoiseTex;
        #define SAMPLE_NOISE_3D(tex,pos) tex3Dlod(tex,pos)
        #define BEGIN_LOOP(k,iterations,defaultIterations) for(int k=0;k<iterations;k++) {
        #define END_LOOP }
#endif

#if !defined(LIQUID_VOLUME_USE_NOISE3D)
	#undef SAMPLE_NOISE_3D
	#define SAMPLE_NOISE_3D(x,y) 0.5
#endif

#if LIQUID_VOLUME_USE_REFRACTION
		half4 LightingWrappedSpecular (SurfaceOutput s, half3 lightDir, half3 viewDir, half atten) {
			half diff = saturate(lightDir.y * 2.0);
    	    half3 h = normalize (lightDir + viewDir);
	        half nh = saturate (dot (s.Normal, h));
    	    half spec = pow (nh, _GlossinessInt.x);
	        half4 c;

       	    // apply light scattering
       	    #if defined(LIQUID_VOLUME_SCATTERING)
       			half sunDiffIntensity = pow( max( dot( viewDir, -lightDir), 0.0 ), _GlossinessInt.y) * _GlossinessInt.z;
				diff += sunDiffIntensity;
       	    #endif

		    half fresnelTerm = Pow4(1.0 - saturate(dot(s.Normal, viewDir)));
			spec += fresnelTerm * _GlossinessInt.w;

			half3 ambient = SampleSH(s.Normal);

    	    c.rgb = (s.Albedo * _LightColor * diff + _LightColor * spec * diff + ambient * fresnelTerm) * atten + s.Emission;
        	c.a = s.Alpha;
        	return c;
    	}
#else
		half4 LightingWrappedSpecular (SurfaceOutput s, half3 lightDir, half3 viewDir, half atten) {
			half diff = saturate(lightDir.y * 2.0);
	        half4 c;

       	    // apply light scattering
       	    #if defined(LIQUID_VOLUME_SCATTERING)
       			half sunDiffIntensity = pow( max( dot( viewDir, -lightDir), 0.0 ), _GlossinessInt.y) * _GlossinessInt.z;
				diff += sunDiffIntensity;
       	    #endif

		    half fresnelTerm = Pow4(1.0 - saturate(dot(s.Normal, viewDir)));
			half3 ambient = SampleSH(s.Normal);

    	    c.rgb = (s.Albedo * _LightColor * diff + ambient * fresnelTerm) * atten + s.Emission;
        	c.a = s.Alpha;
        	return c;
    	}
#endif

		half4 LightingSimple (SurfaceOutput s, half3 lightDir, half3 viewDir, half atten) {
	        half4 c;
    	    c.rgb = s.Albedo * _LightColor * atten + s.Emission;
        	c.a = s.Alpha;
        	return c;
    	}
		
		void intSphere(float3 rd, out float t0, out float t1) {
			float3  d = wsCameraPos - _Center;
		    float   b = dot(rd, d);
    		float   c = dot(d,d) - _Size.w * _Size.w;
    		float   t = sqrt(b*b - c);
	        t0 = -b-t;
			t1 = -b+t;
	    }
	    
	    void intCylinder(float3 rd, out float t0, out float t1) {
			#if LIQUID_VOLUME_NON_AABB
   			rd = mul((float3x3)_Rot, rd);
   			#endif
			float3  d = wsCameraPos - _Center;
	    	#if LIQUID_VOLUME_NON_AABB
			d = mul((float3x3)_Rot, d);
   			#endif
			float   a = dot(rd.xz, rd.xz);
			float   b = dot(rd.xz, d.xz);
			float   c = dot(d.xz,d.xz) - _Size.w * _Size.w;
			float   t = sqrt(max(b*b-a*c,0)); // max prevents artifacts with MSAA
	        t0 = (-b-t)/a;
			t1 = (-b+t)/a;
			
			// cylinder cap
			float sy = _Size.y * 0.5 * _FlaskThickness.y;
			float h = abs(d.y) - sy;
			if (h>0) {
				float rdl = dot(rd.xz / rd.y, rd.xz / rd.y);
				float tc = h * sqrt (1.0 + rdl);
				t0 = max(t0, tc);
			}
			
			h = sign(rd.y) * -d.y + sy;
			if (h>0) {
				float rdl = dot(rd.xz / rd.y, rd.xz / rd.y);
				float tc = h * sqrt (1.0 + rdl);
				t1 = min(t1, tc);
			}
		}
		
		void intBox(float3 rd, out float t0, out float t1) {
	    	#if LIQUID_VOLUME_NON_AABB
			rd = mul((float3x3)_Rot, rd);
			#endif
			float3 ro = wsCameraPos - _Center;
	    	#if LIQUID_VOLUME_NON_AABB
			ro = mul((float3x3)_Rot, ro);
			#endif

		    float3 invR   = 1.0 / rd;
		    float3 boxmin = - _Size.w;
		    float3 boxmax = + _Size.w;
    		float3 tbot   = invR * (boxmin - ro);
    		float3 ttop   = invR * (boxmax - ro);
			float3 tmin   = min (ttop, tbot);
			float3 tmax   = max (ttop, tbot);
			float2 tt0    = max (tmin.xx, tmin.yz);
			t0  = max(tt0.x, tt0.y);
			tt0 = min (tmax.xx, tmax.yz);
			t1  = min(tt0.x, tt0.y);	
		}
  	    
  	    
		void vert(appdata_base v, out Input o) {
			o = (Input)0;

		    UNITY_SETUP_INSTANCE_ID(v);
			UNITY_TRANSFER_INSTANCE_ID(v, o);
			UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

			o.vertex = v.vertex;
			o.vertex.w = dot(o.vertex.xz, _Turbulence.zw) + _TurbulenceSpeed;
			o.vertex.xz *= 0.1.xx * _Turbulence.xx;	// extracted from frag
			o.vertex.xz += _Time.xx;
			v.vertex.xyz *= _FlaskThickness;

			VertexPositionInputs vertexInput = GetVertexPositionInputs(v.vertex.xyz);
			VertexNormalInputs normalInput = GetVertexNormalInputs(v.normalOS, v.tangentOS);
			o.normalWS = normalInput.normalWS;
			o.realPos = vertexInput.positionWS;
	        #if LIQUID_VOLUME_IGNORE_GRAVITY
   				o.realPos = mul((float3x3)_Rot, o.realPos - _Center) + _Center;
				o.camPos = mul((float3x3)_Rot, _WorldSpaceCameraPos - _Center) + _Center;
			#else
				o.camPos = _WorldSpaceCameraPos;
   			#endif

			o.positionCS = vertexInput.positionCS;

			#if LIQUID_VOLUME_IRREGULAR
				if (_LVForcedInvisible == 1) {
					o.positionCS.xy = -10000;
                }
			#endif

			o.screenPos = ComputeScreenPos(o.positionCS);
		}
		
		half4 raymarch(float4 vertex, float3 rd, float t0, float t1); // forward declaration

		SAMPLER(sampler_point_clamp);
		#if defined(LIQUID_VOLUME_FP_RENDER_TEXTURES)
			#define texDistance(tex, uv) SAMPLE_TEXTURE2D_X(tex, sampler_point_clamp, uv).r
		#else

			inline float DecodeFloatRGBA( float4 enc ) {
			    float4 kDecodeDot = float4(1.0, 1/255.0, 1/65025.0, 1/16581375.0);
				return dot( enc, kDecodeDot );
			}

			#define texDistance(tex, uv) ( (1.0 / DecodeFloatRGBA(SAMPLE_TEXTURE2D_X(tex, sampler_point_clamp, uv))) - 1.0 )
		#endif


	 	float minimum_distance_sqr(float rayLengthSqr, float3 w, float3 p) {
     		// Return minimum distance between line segment vw and point p
     		float t = saturate(dot(p, w) / rayLengthSqr);
     		float3 projection = t * w;
     		return dot(p - projection, p - projection);
 		}

		inline float3 ProjectOnPlane(float3 v, float3 planeNormal) {
			float sqrMag = dot(planeNormal, planeNormal);
			float dt = dot(v, planeNormal);
			return v - planeNormal * dt / sqrMag;
		}

		float GetLightAttenuation(float3 wpos) {
			float4 shadowCoord = TransformWorldToShadowCoord(wpos);
			float atten = MainLightRealtimeShadow(shadowCoord);
			return atten;
		}


		float3 SampleSceneColorLOD(float2 uv) {
			return SAMPLE_TEXTURE2D_X_LOD(_CameraOpaqueTexture, sampler_CameraOpaqueTexture, UnityStereoTransformScreenSpaceTex(uv), 0).rgb;
		}

		half3 boxBlur(float2 uv) {
			const int BOXRADIUS = 3;    
			const float SPREAD = 3;

			float2 spreadFactor = SPREAD / _ScreenParams.xy;
			half3 color = 0.0.xxx;
			for (int ry = -BOXRADIUS; ry <= BOXRADIUS; ++ry) {
				for (int rx = -BOXRADIUS; rx <= BOXRADIUS; ++rx) {
    				color += SampleSceneColorLOD(uv + float2(rx,ry) * spreadFactor);
				}
			}
    
			half  w = (BOXRADIUS * 2 + 1) * (BOXRADIUS * 2 + 1);
			return (color/w);
		}


		half4 frag (Input IN) : SV_Target {

		    UNITY_SETUP_INSTANCE_ID(IN);
			UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(IN);

	        if (IN.vertex.y > _UpperLimit || IN.vertex.y < _LowerLimit) return 0.0.xxxx;

			wsCameraPos = IN.camPos;

			#if defined(LIQUID_VOLUME_ORTHO)
				float3 cameraForward = UNITY_MATRIX_V[2].xyz;
				float3 orthoCameraPos = ProjectOnPlane(IN.realPos - wsCameraPos, cameraForward) + wsCameraPos;
				wsCameraPos = lerp(wsCameraPos, orthoCameraPos, unity_OrthoParams.w);
			#endif

			float t0, t1;
			float3 rd = IN.realPos - wsCameraPos;
			float dist = length(rd);
			rd /= dist;

			#if LIQUID_VOLUME_SPHERE
				intSphere(rd, t0, t1);
			#elif LIQUID_VOLUME_CUBE
				intBox(rd, t0, t1);			
			#elif LIQUID_VOLUME_CYLINDER
				intCylinder(rd, t0, t1);
			#else
				t0 = dist;
				t1 = dist + _Size.x + _BackDepthBias;
			#endif
			
			t0 = max(0,t0);	// needed if camera is inside container

			#if LIQUID_VOLUME_DEPTH_AWARE || LIQUID_VOLUME_DEPTH_AWARE_PASS || LIQUID_VOLUME_IRREGULAR
				float2 uv = IN.screenPos.xy / IN.screenPos.w;
			#endif

			#if LIQUID_VOLUME_DEPTH_AWARE
				#if defined(LIQUID_VOLUME_ORTHO)
					float  vz = SampleSceneDepth(uv);
					#if UNITY_REVERSED_Z
						vz = 1.0 - vz;
					#endif
					float z = vz * _ProjectionParams.z;
				#else
					float depth  = SampleSceneDepth(uv);
					float4 raw   = mul(UNITY_MATRIX_I_VP, float4(uv * 2.0 - 1.0, depth, 1.0));
					float3 wpos  = raw.xyz / raw.w;
					float z = distance(wsCameraPos, wpos.xyz) + _DepthAwareOffset;
				#endif
				t1 = min(t1, z);
			#endif

			#if LIQUID_VOLUME_DEPTH_AWARE_PASS
				float frontDist = texDistance(_VLFrontBufferTexture, UnityStereoTransformScreenSpaceTex(uv));
				t1 = min(t1, frontDist);
			#endif
			
			#if LIQUID_VOLUME_IRREGULAR
				float backDist = texDistance(_VLBackBufferTexture, UnityStereoTransformScreenSpaceTex(uv));
				t1 = min(t1, backDist);
				clip(t1-t0-_DoubleSidedBias);
			#endif

			half4 co = raymarch(IN.vertex,rd,t0,t1);

			#if defined(LIQUID_VOLUME_SCATTERING)
				float3 rayStart = wsCameraPos + rd * t0;
				float rayLength = t1 - t0;
         		rayStart += rd * _PointLightInsideAtten;
         		rayLength -= _PointLightInsideAtten;
         		float3 ray = rd * rayLength;
         		float rayLengthSqr = rayLength * rayLength;
         		for (int k=0;k<_PointLightCount;k++) {
             		half pointLightInfluence = minimum_distance_sqr(rayLengthSqr, ray, _PointLightPosition[k].xyz - rayStart) / _PointLightColor[k].w;
             		co.rgb += _PointLightColor[k].rgb * (co.a / (1.0 + pointLightInfluence));
         		}
         	#endif

			SurfaceOutput s = (SurfaceOutput)0;
			s.Albedo = co.rgb;
			s.Emission = co.rgb * _EmissionColor;
			s.Alpha = co.a;
			s.Normal = IN.normalWS;

			half atten = 1.0; //GetLightAttenuation(IN.realPos); // uncomment if shadow support is required
			co = LIGHTING(s, _MainLightPosition.xyz, -rd, atten);

			#if !UNITY_COLORSPACE_GAMMA
				co.rgb = SRGBToLinear(co.rgb);
			#endif

			#if LIQUID_VOLUME_USE_REFRACTION
				float4 uvgrab = IN.screenPos;
				half4 bgColor = half4(boxBlur(uvgrab.xy/uvgrab.w), _FlaskBlurIntensity);
				co = lerp(bgColor, co, co.a);
			#endif

			return co;

		}
