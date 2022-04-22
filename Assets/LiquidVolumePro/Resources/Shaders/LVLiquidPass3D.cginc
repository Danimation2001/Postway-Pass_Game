#include "LVLiquidPassBase.cginc"

        float _SparklingIntensity, _SparklingThreshold;

		half4 raymarch(float4 vertex, float3 rd, float t0, float t1) {

	        float3 wpos = wsCameraPos + rd * t0;

			float turbulence = (tex2D(_NoiseTex2D, vertex.xz).g - 0.5) * _Turbulence.x;
			turbulence += sin(vertex.w) * _Turbulence.y;
			turbulence *= 0.05 * _Size.y * _FoamTurbulence;
			_LevelPos += turbulence;
			_FoamMaxPos += turbulence;

            // compute surface dist (t2)
            float t2 = (_LevelPos - wsCameraPos.y) / rd.y;
            t2 = clamp(t2, t0, t1);
						
			// compute foam level (t3)
            float t3 = (_FoamMaxPos - wsCameraPos.y) / rd.y;
            t3 = clamp(t3, t0, t1);

			// ray-march smoke
			float tmin, tmax;
			#if defined(LIQUID_VOLUME_SMOKE)
			half4 sumSmoke = half4(0,0,0,0);
			if (wpos.y > _LevelPos) {
				tmin = t0;
				tmax = rd.y<0 ? min(t2,t1) : t1;
				float stepSize = (tmax - tmin) / (float)_SmokeRaySteps;
				float4 dir  = float4(rd * stepSize, 0);
				float4 rpos = float4(wsCameraPos + rd * tmin, 0);
				float4 disp = float4(0, _Time.x * _Turbulence.x * _Size.y * _SmokeSpeed, 0, 0);
                BEGIN_LOOP(k,_SmokeRaySteps,5)
					half n = SAMPLE_NOISE_3D(_NoiseTex, (rpos - disp) * _Scale.x).r;
					float py = (_LevelPos - rpos.y)/_Size.y;
					n = saturate(n + py * _SmokeHeightAtten);
					half4 lc  = half4(_SmokeColor.rgb, n * _SmokeColor.a);
					lc.rgb *= lc.aaa;
					half deep = exp(py * _SmokeAtten);
					lc *= deep;
					sumSmoke += lc * (1.0-sumSmoke.a);
                    rpos += dir;
                END_LOOP  
			}
			#endif
			
			// ray-march foam
			tmax = min(t3,t1), tmin = t0;
			float sy = sign(rd.y);
			if (wpos.y > _FoamMaxPos) {
				tmin = tmax;
				tmax = min(t2, t1) * -sy;
			} else if (wpos.y < _LevelPos) {
				tmin  = min(t2,t1);
				tmax *= _FoamBottom * sy;
			} else if (rd.y<0) {
				tmax = min(t2, t1);
			}
			half4 sumFoam  = half4(0,0,0,0);
			if (tmax>tmin) {
				float stepSize = (tmax - tmin) / (float)_FoamRaySteps;
				float4 dir  = float4(rd * stepSize, 0);
				float4 rpos = float4(wsCameraPos + rd * tmin, 0);
				rpos.y -= _LevelPos;
				float foamThickness = _FoamMaxPos - _LevelPos;
				float4 disp = float4(_Time.x, 0, _Time.x, 0) * _Turbulence.x * _Size.w * _FoamTurbulence;
                BEGIN_LOOP(k,_FoamRaySteps,7)
					float h = saturate( rpos.y / foamThickness );
					float n = saturate(SAMPLE_NOISE_3D(_NoiseTex, (rpos - disp) * _Scale.y ).r + _FoamDensity);
					if (n>h) {
						half4 lc  = half4(_FoamColor.rgb, n-h);
						lc.a   *= _FoamColor.a;
						lc.rgb *= lc.aaa;
						half deep = saturate(rpos.y * _FoamWeight / foamThickness);
						lc *= deep;

						sumFoam += lc * (1.0 - sumFoam.a);
					}
                    rpos += dir;
				END_LOOP
				sumFoam *= 1.0 + _FoamDensity;
			}	

			// ray-march liquid
			if (wpos.y > _LevelPos) {
				tmin = t2;
				tmax = t1 * -sy;
			} else {
				tmin = t0;
				tmax = t1; // for raymarching texture we can ignore the fact that t2 could be nearer than t1 when viewed from below ( was min(t2,t1) )
			}
			half4 sum = half4(0,0,0,0);
			if (tmax>tmin) {
				float stepSize = (tmax-tmin) / (float)_LiquidRaySteps;
				float4 dir   = float4(rd * stepSize, 0);
				float4 rpos  = float4(wsCameraPos + rd * tmin, 0);	// does not matter to move to level pos
				rpos.y -= _LevelPos;
				float4 disp  = float4(_Time.x * _Turbulence.y, _Time.x * 1.5, _Time.x * _Turbulence.y, 0) * (_Turbulence.y + _Turbulence.x) * _Size.y;
				float4 disp2 = float4(0,_Time.x*5.0* (_Turbulence.y + _Turbulence.x) * _Size.y,0,0);
                BEGIN_LOOP(k,_LiquidRaySteps,10)
					half deep = exp((rpos.y/_Size.y) * _DeepAtten);
					half n = SAMPLE_NOISE_3D(_NoiseTex, (rpos - disp) * _Scale.z).r;
					half4 lc  = half4(_Color1.rgb, (1.0 - _Muddy) + n * _Muddy);
					lc.a *= _Color1.a;
					lc.rgb *= lc.aaa;
					lc.rgb *= deep;
					sum += lc * (1.0-sum.a);
					
					n =  SAMPLE_NOISE_3D(_NoiseTex, (rpos - disp2) * _Scale.w ).r;
					lc  = half4(_Color2.rgb + max(n-_SparklingThreshold, 0) * _SparklingIntensity, (1.0 - _Muddy) + n * _Muddy);
					lc.a *= _Color2.a;
					lc.rgb *= lc.aaa;
					lc.rgb *= deep;
					sum += lc * (1.0-sum.a);

                    rpos += dir;
				END_LOOP
			}

			// Final blend
			if (wpos.y>_LevelPos) {
				#if defined(LIQUID_VOLUME_SMOKE)
				half4 lfoam = sumFoam * (1.0 - sumSmoke.a);
				half4 liquid = sum * (1.0 - lfoam.a) * (1.0 - sumSmoke.a);
				sum = sumSmoke + lfoam + liquid;
				#else
				half4 liquid = sum * (1.0 - sumFoam.a);
				sum = sumFoam + liquid;
				#endif
			} else {
				half4 lfoam = sumFoam * (1.0 - sum.a);
				sum = sum + lfoam;
			}
			return sum;
		}
