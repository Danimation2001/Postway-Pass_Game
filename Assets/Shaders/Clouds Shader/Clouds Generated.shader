Shader "Cloud Shader"
{
    Properties
    {
        _Rotate_Projection("Rotate Projection", Vector) = (1, 0, 0, 0)
        _Noise_Scale("Noise Scale", Float) = 10
        _Noise_Speed("Noise Speed", Float) = 0.1
        _Noise_Height("Noise Height", Float) = 100
        _Noise_Remap("Noise Remap", Vector) = (0, 1, -1, 1)
        _Colour_Peak("Colour Peak", Color) = (1, 1, 1, 0)
        _Colour_Valley("Colour Valley", Color) = (0, 0, 0, 0)
        _Noise_Edge_1("Noise Edge 1", Float) = 0
        _Noise_Edge_2("Noise Edge 2", Float) = 1
        _Noise_Power("Noise Power", Float) = 2
        _Base_Scale("Base Scale", Float) = 5
        _Base_Speed("Base Speed", Float) = 0.2
        _Base_Strength("Base Strength", Float) = 2
        _Emission("Emission", Float) = 2
        _Curvature_Radius("Curvature Radius", Float) = 1
        _Fresnel_Power("Fresnel Power", Float) = 1
        _Fresnel_opacity("Fresnel opacity", Float) = 1
        _Fade_Depth("Fade Depth", Float) = 100
        [HideInInspector]_CastShadows("_CastShadows", Float) = 1
        [HideInInspector]_Surface("_Surface", Float) = 1
        [HideInInspector]_Blend("_Blend", Float) = 0
        [HideInInspector]_AlphaClip("_AlphaClip", Float) = 0
        [HideInInspector]_SrcBlend("_SrcBlend", Float) = 1
        [HideInInspector]_DstBlend("_DstBlend", Float) = 0
        [HideInInspector][ToggleUI]_ZWrite("_ZWrite", Float) = 0
        [HideInInspector]_ZWriteControl("_ZWriteControl", Float) = 0
        [HideInInspector]_ZTest("_ZTest", Float) = 4
        [HideInInspector]_Cull("_Cull", Float) = 0
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
            "RenderType"="Transparent"
            "UniversalMaterialType" = "Unlit"
            "Queue"="Transparent"
            "ShaderGraphShader"="true"
            "ShaderGraphTargetId"="UniversalUnlitSubTarget"
        }
        Pass
        {
            Name "Universal Forward"
            Tags
            {
                // LightMode: <None>
            }
        
        // Render State
        Cull [_Cull]
        Blend [_SrcBlend] [_DstBlend]
        ZTest [_ZTest]
        //ZWrite [_ZWrite]
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
        
        // DotsInstancingOptions: <None>
        // HybridV1InjectedBuiltinProperties: <None>
        
        // Keywords
        #pragma multi_compile _ LIGHTMAP_ON
        #pragma multi_compile _ DIRLIGHTMAP_COMBINED
        #pragma shader_feature _ _SAMPLE_GI
        #pragma multi_compile _ _DBUFFER_MRT1 _DBUFFER_MRT2 _DBUFFER_MRT3
        #pragma multi_compile _ DEBUG_DISPLAY
        #pragma shader_feature_fragment _ _SURFACE_TYPE_TRANSPARENT
        #pragma shader_feature_local_fragment _ _ALPHAPREMULTIPLY_ON
        #pragma shader_feature_local_fragment _ _ALPHATEST_ON
        // GraphKeywords: <None>
        
        // Defines
        
        #define ATTRIBUTES_NEED_NORMAL
        #define ATTRIBUTES_NEED_TANGENT
        #define VARYINGS_NEED_POSITION_WS
        #define VARYINGS_NEED_NORMAL_WS
        #define VARYINGS_NEED_VIEWDIRECTION_WS
        #define FEATURES_GRAPH_VERTEX
        /* WARNING: $splice Could not find named fragment 'PassInstancing' */
        #define SHADERPASS SHADERPASS_UNLIT
        #define _FOG_FRAGMENT 1
        #define REQUIRE_DEPTH_TEXTURE
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
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : INSTANCEID_SEMANTIC;
            #endif
        };
        struct Varyings
        {
             float4 positionCS : SV_POSITION;
             float3 positionWS;
             float3 normalWS;
             float3 viewDirectionWS;
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
             float3 WorldSpaceNormal;
             float3 WorldSpaceViewDirection;
             float3 WorldSpacePosition;
             float4 ScreenPosition;
             float3 TimeParameters;
        };
        struct VertexDescriptionInputs
        {
             float3 ObjectSpaceNormal;
             float3 WorldSpaceNormal;
             float3 ObjectSpaceTangent;
             float3 ObjectSpacePosition;
             float3 WorldSpacePosition;
             float3 TimeParameters;
        };
        struct PackedVaryings
        {
             float4 positionCS : SV_POSITION;
             float3 interp0 : INTERP0;
             float3 interp1 : INTERP1;
             float3 interp2 : INTERP2;
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
            output.interp2.xyz =  input.viewDirectionWS;
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
            output.viewDirectionWS = input.interp2.xyz;
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
        float4 _Rotate_Projection;
        float _Noise_Scale;
        float _Noise_Speed;
        float _Noise_Height;
        float4 _Noise_Remap;
        float4 _Colour_Peak;
        float4 _Colour_Valley;
        float _Noise_Edge_1;
        float _Noise_Edge_2;
        float _Noise_Power;
        float _Base_Scale;
        float _Base_Speed;
        float _Base_Strength;
        float _Emission;
        float _Curvature_Radius;
        float _Fresnel_Power;
        float _Fresnel_opacity;
        float _Fade_Depth;
        CBUFFER_END
        
        // Object and Global properties
        
        // Graph Includes
        // GraphIncludes: <None>
        
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
        
        void Unity_Distance_float3(float3 A, float3 B, out float Out)
        {
            Out = distance(A, B);
        }
        
        void Unity_Divide_float(float A, float B, out float Out)
        {
            Out = A / B;
        }
        
        void Unity_Power_float(float A, float B, out float Out)
        {
            Out = pow(A, B);
        }
        
        void Unity_Multiply_float3_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A * B;
        }
        
        void Unity_Rotate_About_Axis_Degrees_float(float3 In, float3 Axis, float Rotation, out float3 Out)
        {
            Rotation = radians(Rotation);
        
            float s = sin(Rotation);
            float c = cos(Rotation);
            float one_minus_c = 1.0 - c;
        
            Axis = normalize(Axis);
        
            float3x3 rot_mat = { one_minus_c * Axis.x * Axis.x + c,            one_minus_c * Axis.x * Axis.y - Axis.z * s,     one_minus_c * Axis.z * Axis.x + Axis.y * s,
                                      one_minus_c * Axis.x * Axis.y + Axis.z * s,   one_minus_c * Axis.y * Axis.y + c,              one_minus_c * Axis.y * Axis.z - Axis.x * s,
                                      one_minus_c * Axis.z * Axis.x - Axis.y * s,   one_minus_c * Axis.y * Axis.z + Axis.x * s,     one_minus_c * Axis.z * Axis.z + c
                                    };
        
            Out = mul(rot_mat,  In);
        }
        
        void Unity_Multiply_float_float(float A, float B, out float Out)
        {
            Out = A * B;
        }
        
        void Unity_TilingAndOffset_float(float2 UV, float2 Tiling, float2 Offset, out float2 Out)
        {
            Out = UV * Tiling + Offset;
        }
        
        
        float2 Unity_GradientNoise_Dir_float(float2 p)
        {
            // Permutation and hashing used in webgl-nosie goo.gl/pX7HtC
            p = p % 289;
            // need full precision, otherwise half overflows when p > 1
            float x = float(34 * p.x + 1) * p.x % 289 + p.y;
            x = (34 * x + 1) * x % 289;
            x = frac(x / 41) * 2 - 1;
            return normalize(float2(x - floor(x + 0.5), abs(x) - 0.5));
        }
        
        void Unity_GradientNoise_float(float2 UV, float Scale, out float Out)
        {
            float2 p = UV * Scale;
            float2 ip = floor(p);
            float2 fp = frac(p);
            float d00 = dot(Unity_GradientNoise_Dir_float(ip), fp);
            float d01 = dot(Unity_GradientNoise_Dir_float(ip + float2(0, 1)), fp - float2(0, 1));
            float d10 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 0)), fp - float2(1, 0));
            float d11 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 1)), fp - float2(1, 1));
            fp = fp * fp * fp * (fp * (fp * 6 - 15) + 10);
            Out = lerp(lerp(d00, d01, fp.y), lerp(d10, d11, fp.y), fp.x) + 0.5;
        }
        
        void Unity_Add_float(float A, float B, out float Out)
        {
            Out = A + B;
        }
        
        void Unity_Saturate_float(float In, out float Out)
        {
            Out = saturate(In);
        }
        
        void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
        {
            RGBA = float4(R, G, B, A);
            RGB = float3(R, G, B);
            RG = float2(R, G);
        }
        
        void Unity_Remap_float(float In, float2 InMinMax, float2 OutMinMax, out float Out)
        {
            Out = OutMinMax.x + (In - InMinMax.x) * (OutMinMax.y - OutMinMax.x) / (InMinMax.y - InMinMax.x);
        }
        
        void Unity_Absolute_float(float In, out float Out)
        {
            Out = abs(In);
        }
        
        void Unity_Smoothstep_float(float Edge1, float Edge2, float In, out float Out)
        {
            Out = smoothstep(Edge1, Edge2, In);
        }
        
        void Unity_Add_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A + B;
        }
        
        void Unity_Lerp_float4(float4 A, float4 B, float4 T, out float4 Out)
        {
            Out = lerp(A, B, T);
        }
        
        void Unity_FresnelEffect_float(float3 Normal, float3 ViewDir, float Power, out float Out)
        {
            Out = pow((1.0 - saturate(dot(normalize(Normal), normalize(ViewDir)))), Power);
        }
        
        void Unity_Add_float4(float4 A, float4 B, out float4 Out)
        {
            Out = A + B;
        }
        
        void Unity_SceneDepth_Eye_float(float4 UV, out float Out)
        {
            if (unity_OrthoParams.w == 1.0)
            {
                Out = LinearEyeDepth(ComputeWorldSpacePosition(UV.xy, SHADERGRAPH_SAMPLE_SCENE_DEPTH(UV.xy), UNITY_MATRIX_I_VP), UNITY_MATRIX_V);
            }
            else
            {
                Out = LinearEyeDepth(SHADERGRAPH_SAMPLE_SCENE_DEPTH(UV.xy), _ZBufferParams);
            }
        }
        
        void Unity_Subtract_float(float A, float B, out float Out)
        {
            Out = A - B;
        }
        
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
            float _Distance_c01ba79505ea4a8891c3da5756fe9e5a_Out_2;
            Unity_Distance_float3(SHADERGRAPH_OBJECT_POSITION, IN.WorldSpacePosition, _Distance_c01ba79505ea4a8891c3da5756fe9e5a_Out_2);
            float _Property_d1be4d71eb4e4aae9337b9b402f45d63_Out_0 = _Curvature_Radius;
            float _Divide_03646e2359744ec38397913fc1d7c270_Out_2;
            Unity_Divide_float(_Distance_c01ba79505ea4a8891c3da5756fe9e5a_Out_2, _Property_d1be4d71eb4e4aae9337b9b402f45d63_Out_0, _Divide_03646e2359744ec38397913fc1d7c270_Out_2);
            float _Power_07f0eac51f1244fbb5c4966f586ac4dc_Out_2;
            Unity_Power_float(_Divide_03646e2359744ec38397913fc1d7c270_Out_2, 3, _Power_07f0eac51f1244fbb5c4966f586ac4dc_Out_2);
            float3 _Multiply_5ca41a1165784fbe980a8c3177fad7e1_Out_2;
            Unity_Multiply_float3_float3(IN.WorldSpaceNormal, (_Power_07f0eac51f1244fbb5c4966f586ac4dc_Out_2.xxx), _Multiply_5ca41a1165784fbe980a8c3177fad7e1_Out_2);
            float _Property_ef386ec2d5f4434a8a5f934ff230322f_Out_0 = _Noise_Edge_1;
            float _Property_147f1a2515e04a399eed34de35cf1107_Out_0 = _Noise_Edge_2;
            float4 _Property_b84368a6bae8433994c8bf5d771c01f4_Out_0 = _Rotate_Projection;
            float _Split_31db8d949ab24fd1b5ded76e6ecb6868_R_1 = _Property_b84368a6bae8433994c8bf5d771c01f4_Out_0[0];
            float _Split_31db8d949ab24fd1b5ded76e6ecb6868_G_2 = _Property_b84368a6bae8433994c8bf5d771c01f4_Out_0[1];
            float _Split_31db8d949ab24fd1b5ded76e6ecb6868_B_3 = _Property_b84368a6bae8433994c8bf5d771c01f4_Out_0[2];
            float _Split_31db8d949ab24fd1b5ded76e6ecb6868_A_4 = _Property_b84368a6bae8433994c8bf5d771c01f4_Out_0[3];
            float3 _RotateAboutAxis_6e7d2784bd02405faeb7bacb567d0731_Out_3;
            Unity_Rotate_About_Axis_Degrees_float(IN.WorldSpacePosition, (_Property_b84368a6bae8433994c8bf5d771c01f4_Out_0.xyz), _Split_31db8d949ab24fd1b5ded76e6ecb6868_A_4, _RotateAboutAxis_6e7d2784bd02405faeb7bacb567d0731_Out_3);
            float _Property_1b5acb9aca4b4c1ca8150917cb29e38d_Out_0 = _Noise_Speed;
            float _Multiply_a1f01de168c5412e848fa5a9a4f633d8_Out_2;
            Unity_Multiply_float_float(IN.TimeParameters.x, _Property_1b5acb9aca4b4c1ca8150917cb29e38d_Out_0, _Multiply_a1f01de168c5412e848fa5a9a4f633d8_Out_2);
            float2 _TilingAndOffset_3a22eccd71474e639594fce72cde2d02_Out_3;
            Unity_TilingAndOffset_float((_RotateAboutAxis_6e7d2784bd02405faeb7bacb567d0731_Out_3.xy), float2 (1, 1), (_Multiply_a1f01de168c5412e848fa5a9a4f633d8_Out_2.xx), _TilingAndOffset_3a22eccd71474e639594fce72cde2d02_Out_3);
            float _Property_e34f89cb08684afb94f0ac41ba675b11_Out_0 = _Noise_Scale;
            float _GradientNoise_71dea3d8ca7f493a820838ec4624d407_Out_2;
            Unity_GradientNoise_float(_TilingAndOffset_3a22eccd71474e639594fce72cde2d02_Out_3, _Property_e34f89cb08684afb94f0ac41ba675b11_Out_0, _GradientNoise_71dea3d8ca7f493a820838ec4624d407_Out_2);
            float2 _TilingAndOffset_b402f80311694eb4b5a4c3d07e71c615_Out_3;
            Unity_TilingAndOffset_float((_RotateAboutAxis_6e7d2784bd02405faeb7bacb567d0731_Out_3.xy), float2 (1, 1), float2 (0, 0), _TilingAndOffset_b402f80311694eb4b5a4c3d07e71c615_Out_3);
            float _GradientNoise_7cfc31faa781410090b11ae418c9e103_Out_2;
            Unity_GradientNoise_float(_TilingAndOffset_b402f80311694eb4b5a4c3d07e71c615_Out_3, _Property_e34f89cb08684afb94f0ac41ba675b11_Out_0, _GradientNoise_7cfc31faa781410090b11ae418c9e103_Out_2);
            float _Add_8d3a946d8f7848c0a6a4ee9e280c511d_Out_2;
            Unity_Add_float(_GradientNoise_71dea3d8ca7f493a820838ec4624d407_Out_2, _GradientNoise_7cfc31faa781410090b11ae418c9e103_Out_2, _Add_8d3a946d8f7848c0a6a4ee9e280c511d_Out_2);
            float _Divide_883697060c4b42898d76bc5325a5b568_Out_2;
            Unity_Divide_float(_Add_8d3a946d8f7848c0a6a4ee9e280c511d_Out_2, 2, _Divide_883697060c4b42898d76bc5325a5b568_Out_2);
            float _Saturate_c96331ef3b2642d39a446bce3d43f560_Out_1;
            Unity_Saturate_float(_Divide_883697060c4b42898d76bc5325a5b568_Out_2, _Saturate_c96331ef3b2642d39a446bce3d43f560_Out_1);
            float _Property_a5e2c659762f49e2826023553b233885_Out_0 = _Noise_Power;
            float _Power_fe5fa4a062ff4bac868501be2a7f055c_Out_2;
            Unity_Power_float(_Saturate_c96331ef3b2642d39a446bce3d43f560_Out_1, _Property_a5e2c659762f49e2826023553b233885_Out_0, _Power_fe5fa4a062ff4bac868501be2a7f055c_Out_2);
            float4 _Property_f466dd4679cc4567b14cecb45e839124_Out_0 = _Noise_Remap;
            float _Split_cfe4e3a30c93414694a4d7e49c708985_R_1 = _Property_f466dd4679cc4567b14cecb45e839124_Out_0[0];
            float _Split_cfe4e3a30c93414694a4d7e49c708985_G_2 = _Property_f466dd4679cc4567b14cecb45e839124_Out_0[1];
            float _Split_cfe4e3a30c93414694a4d7e49c708985_B_3 = _Property_f466dd4679cc4567b14cecb45e839124_Out_0[2];
            float _Split_cfe4e3a30c93414694a4d7e49c708985_A_4 = _Property_f466dd4679cc4567b14cecb45e839124_Out_0[3];
            float4 _Combine_c045c4c659354461848cd6c7d61e4be5_RGBA_4;
            float3 _Combine_c045c4c659354461848cd6c7d61e4be5_RGB_5;
            float2 _Combine_c045c4c659354461848cd6c7d61e4be5_RG_6;
            Unity_Combine_float(_Split_cfe4e3a30c93414694a4d7e49c708985_R_1, _Split_cfe4e3a30c93414694a4d7e49c708985_G_2, 0, 0, _Combine_c045c4c659354461848cd6c7d61e4be5_RGBA_4, _Combine_c045c4c659354461848cd6c7d61e4be5_RGB_5, _Combine_c045c4c659354461848cd6c7d61e4be5_RG_6);
            float4 _Combine_6de15c52675e489b874b27eaf16323df_RGBA_4;
            float3 _Combine_6de15c52675e489b874b27eaf16323df_RGB_5;
            float2 _Combine_6de15c52675e489b874b27eaf16323df_RG_6;
            Unity_Combine_float(_Split_cfe4e3a30c93414694a4d7e49c708985_B_3, _Split_cfe4e3a30c93414694a4d7e49c708985_A_4, 0, 0, _Combine_6de15c52675e489b874b27eaf16323df_RGBA_4, _Combine_6de15c52675e489b874b27eaf16323df_RGB_5, _Combine_6de15c52675e489b874b27eaf16323df_RG_6);
            float _Remap_192e92b0649c4e009e825f27b2499763_Out_3;
            Unity_Remap_float(_Power_fe5fa4a062ff4bac868501be2a7f055c_Out_2, _Combine_c045c4c659354461848cd6c7d61e4be5_RG_6, _Combine_6de15c52675e489b874b27eaf16323df_RG_6, _Remap_192e92b0649c4e009e825f27b2499763_Out_3);
            float _Absolute_d5fceabb74744431b85e0fdda3c8cf5c_Out_1;
            Unity_Absolute_float(_Remap_192e92b0649c4e009e825f27b2499763_Out_3, _Absolute_d5fceabb74744431b85e0fdda3c8cf5c_Out_1);
            float _Smoothstep_5b3511aa53f74a73b9b9614372a6af74_Out_3;
            Unity_Smoothstep_float(_Property_ef386ec2d5f4434a8a5f934ff230322f_Out_0, _Property_147f1a2515e04a399eed34de35cf1107_Out_0, _Absolute_d5fceabb74744431b85e0fdda3c8cf5c_Out_1, _Smoothstep_5b3511aa53f74a73b9b9614372a6af74_Out_3);
            float _Property_8fb0c3dbf4a84403a6068e70183a7ea4_Out_0 = _Base_Speed;
            float _Multiply_774f493cd66541e7ba6553802a499b79_Out_2;
            Unity_Multiply_float_float(IN.TimeParameters.x, _Property_8fb0c3dbf4a84403a6068e70183a7ea4_Out_0, _Multiply_774f493cd66541e7ba6553802a499b79_Out_2);
            float2 _TilingAndOffset_969b7b642fd04ed7b2592123a03eca18_Out_3;
            Unity_TilingAndOffset_float((_RotateAboutAxis_6e7d2784bd02405faeb7bacb567d0731_Out_3.xy), float2 (1, 1), (_Multiply_774f493cd66541e7ba6553802a499b79_Out_2.xx), _TilingAndOffset_969b7b642fd04ed7b2592123a03eca18_Out_3);
            float _Property_e3b00c3a5e804e14a1e03e69aac49211_Out_0 = _Base_Scale;
            float _GradientNoise_04262dfbc1b540b1a9d9b997627f189b_Out_2;
            Unity_GradientNoise_float(_TilingAndOffset_969b7b642fd04ed7b2592123a03eca18_Out_3, _Property_e3b00c3a5e804e14a1e03e69aac49211_Out_0, _GradientNoise_04262dfbc1b540b1a9d9b997627f189b_Out_2);
            float _Property_17938a6d7e2f40dd8d0f1b984a9fbb59_Out_0 = _Base_Strength;
            float _Multiply_0854b1bc83aa4170a68f058b8cb96ff7_Out_2;
            Unity_Multiply_float_float(_GradientNoise_04262dfbc1b540b1a9d9b997627f189b_Out_2, _Property_17938a6d7e2f40dd8d0f1b984a9fbb59_Out_0, _Multiply_0854b1bc83aa4170a68f058b8cb96ff7_Out_2);
            float _Add_f82d9f056cbf456f911125a9574d865f_Out_2;
            Unity_Add_float(_Smoothstep_5b3511aa53f74a73b9b9614372a6af74_Out_3, _Multiply_0854b1bc83aa4170a68f058b8cb96ff7_Out_2, _Add_f82d9f056cbf456f911125a9574d865f_Out_2);
            float _Add_df54866b810e4151a1fde09a51f17b65_Out_2;
            Unity_Add_float(1, _Property_17938a6d7e2f40dd8d0f1b984a9fbb59_Out_0, _Add_df54866b810e4151a1fde09a51f17b65_Out_2);
            float _Divide_b2c87465e89040e4940d7d7f42943c3f_Out_2;
            Unity_Divide_float(_Add_f82d9f056cbf456f911125a9574d865f_Out_2, _Add_df54866b810e4151a1fde09a51f17b65_Out_2, _Divide_b2c87465e89040e4940d7d7f42943c3f_Out_2);
            float3 _Multiply_cc4eb1139ae74d4c85067f5171acc955_Out_2;
            Unity_Multiply_float3_float3(IN.ObjectSpaceNormal, (_Divide_b2c87465e89040e4940d7d7f42943c3f_Out_2.xxx), _Multiply_cc4eb1139ae74d4c85067f5171acc955_Out_2);
            float _Property_611696cf692e4bb19aaf7739c57cdd44_Out_0 = _Noise_Height;
            float3 _Multiply_da4791b114e34eceac3bacbb1043285e_Out_2;
            Unity_Multiply_float3_float3(_Multiply_cc4eb1139ae74d4c85067f5171acc955_Out_2, (_Property_611696cf692e4bb19aaf7739c57cdd44_Out_0.xxx), _Multiply_da4791b114e34eceac3bacbb1043285e_Out_2);
            float3 _Add_1af6468ff1e344348b74bd929f252cbf_Out_2;
            Unity_Add_float3(IN.ObjectSpacePosition, _Multiply_da4791b114e34eceac3bacbb1043285e_Out_2, _Add_1af6468ff1e344348b74bd929f252cbf_Out_2);
            float3 _Add_c7842509b95b4858bfbf1f91fea0a4c3_Out_2;
            Unity_Add_float3(_Multiply_5ca41a1165784fbe980a8c3177fad7e1_Out_2, _Add_1af6468ff1e344348b74bd929f252cbf_Out_2, _Add_c7842509b95b4858bfbf1f91fea0a4c3_Out_2);
            description.Position = _Add_c7842509b95b4858bfbf1f91fea0a4c3_Out_2;
            description.Normal = IN.ObjectSpaceNormal;
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
            float Alpha;
            float AlphaClipThreshold;
        };
        
        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            float4 _Property_f70ef70650bc4abe8a4358f10ab5f59a_Out_0 = _Colour_Peak;
            float4 _Property_cf745efc5da64fe1acadd633d86b5954_Out_0 = _Colour_Valley;
            float _Property_ef386ec2d5f4434a8a5f934ff230322f_Out_0 = _Noise_Edge_1;
            float _Property_147f1a2515e04a399eed34de35cf1107_Out_0 = _Noise_Edge_2;
            float4 _Property_b84368a6bae8433994c8bf5d771c01f4_Out_0 = _Rotate_Projection;
            float _Split_31db8d949ab24fd1b5ded76e6ecb6868_R_1 = _Property_b84368a6bae8433994c8bf5d771c01f4_Out_0[0];
            float _Split_31db8d949ab24fd1b5ded76e6ecb6868_G_2 = _Property_b84368a6bae8433994c8bf5d771c01f4_Out_0[1];
            float _Split_31db8d949ab24fd1b5ded76e6ecb6868_B_3 = _Property_b84368a6bae8433994c8bf5d771c01f4_Out_0[2];
            float _Split_31db8d949ab24fd1b5ded76e6ecb6868_A_4 = _Property_b84368a6bae8433994c8bf5d771c01f4_Out_0[3];
            float3 _RotateAboutAxis_6e7d2784bd02405faeb7bacb567d0731_Out_3;
            Unity_Rotate_About_Axis_Degrees_float(IN.WorldSpacePosition, (_Property_b84368a6bae8433994c8bf5d771c01f4_Out_0.xyz), _Split_31db8d949ab24fd1b5ded76e6ecb6868_A_4, _RotateAboutAxis_6e7d2784bd02405faeb7bacb567d0731_Out_3);
            float _Property_1b5acb9aca4b4c1ca8150917cb29e38d_Out_0 = _Noise_Speed;
            float _Multiply_a1f01de168c5412e848fa5a9a4f633d8_Out_2;
            Unity_Multiply_float_float(IN.TimeParameters.x, _Property_1b5acb9aca4b4c1ca8150917cb29e38d_Out_0, _Multiply_a1f01de168c5412e848fa5a9a4f633d8_Out_2);
            float2 _TilingAndOffset_3a22eccd71474e639594fce72cde2d02_Out_3;
            Unity_TilingAndOffset_float((_RotateAboutAxis_6e7d2784bd02405faeb7bacb567d0731_Out_3.xy), float2 (1, 1), (_Multiply_a1f01de168c5412e848fa5a9a4f633d8_Out_2.xx), _TilingAndOffset_3a22eccd71474e639594fce72cde2d02_Out_3);
            float _Property_e34f89cb08684afb94f0ac41ba675b11_Out_0 = _Noise_Scale;
            float _GradientNoise_71dea3d8ca7f493a820838ec4624d407_Out_2;
            Unity_GradientNoise_float(_TilingAndOffset_3a22eccd71474e639594fce72cde2d02_Out_3, _Property_e34f89cb08684afb94f0ac41ba675b11_Out_0, _GradientNoise_71dea3d8ca7f493a820838ec4624d407_Out_2);
            float2 _TilingAndOffset_b402f80311694eb4b5a4c3d07e71c615_Out_3;
            Unity_TilingAndOffset_float((_RotateAboutAxis_6e7d2784bd02405faeb7bacb567d0731_Out_3.xy), float2 (1, 1), float2 (0, 0), _TilingAndOffset_b402f80311694eb4b5a4c3d07e71c615_Out_3);
            float _GradientNoise_7cfc31faa781410090b11ae418c9e103_Out_2;
            Unity_GradientNoise_float(_TilingAndOffset_b402f80311694eb4b5a4c3d07e71c615_Out_3, _Property_e34f89cb08684afb94f0ac41ba675b11_Out_0, _GradientNoise_7cfc31faa781410090b11ae418c9e103_Out_2);
            float _Add_8d3a946d8f7848c0a6a4ee9e280c511d_Out_2;
            Unity_Add_float(_GradientNoise_71dea3d8ca7f493a820838ec4624d407_Out_2, _GradientNoise_7cfc31faa781410090b11ae418c9e103_Out_2, _Add_8d3a946d8f7848c0a6a4ee9e280c511d_Out_2);
            float _Divide_883697060c4b42898d76bc5325a5b568_Out_2;
            Unity_Divide_float(_Add_8d3a946d8f7848c0a6a4ee9e280c511d_Out_2, 2, _Divide_883697060c4b42898d76bc5325a5b568_Out_2);
            float _Saturate_c96331ef3b2642d39a446bce3d43f560_Out_1;
            Unity_Saturate_float(_Divide_883697060c4b42898d76bc5325a5b568_Out_2, _Saturate_c96331ef3b2642d39a446bce3d43f560_Out_1);
            float _Property_a5e2c659762f49e2826023553b233885_Out_0 = _Noise_Power;
            float _Power_fe5fa4a062ff4bac868501be2a7f055c_Out_2;
            Unity_Power_float(_Saturate_c96331ef3b2642d39a446bce3d43f560_Out_1, _Property_a5e2c659762f49e2826023553b233885_Out_0, _Power_fe5fa4a062ff4bac868501be2a7f055c_Out_2);
            float4 _Property_f466dd4679cc4567b14cecb45e839124_Out_0 = _Noise_Remap;
            float _Split_cfe4e3a30c93414694a4d7e49c708985_R_1 = _Property_f466dd4679cc4567b14cecb45e839124_Out_0[0];
            float _Split_cfe4e3a30c93414694a4d7e49c708985_G_2 = _Property_f466dd4679cc4567b14cecb45e839124_Out_0[1];
            float _Split_cfe4e3a30c93414694a4d7e49c708985_B_3 = _Property_f466dd4679cc4567b14cecb45e839124_Out_0[2];
            float _Split_cfe4e3a30c93414694a4d7e49c708985_A_4 = _Property_f466dd4679cc4567b14cecb45e839124_Out_0[3];
            float4 _Combine_c045c4c659354461848cd6c7d61e4be5_RGBA_4;
            float3 _Combine_c045c4c659354461848cd6c7d61e4be5_RGB_5;
            float2 _Combine_c045c4c659354461848cd6c7d61e4be5_RG_6;
            Unity_Combine_float(_Split_cfe4e3a30c93414694a4d7e49c708985_R_1, _Split_cfe4e3a30c93414694a4d7e49c708985_G_2, 0, 0, _Combine_c045c4c659354461848cd6c7d61e4be5_RGBA_4, _Combine_c045c4c659354461848cd6c7d61e4be5_RGB_5, _Combine_c045c4c659354461848cd6c7d61e4be5_RG_6);
            float4 _Combine_6de15c52675e489b874b27eaf16323df_RGBA_4;
            float3 _Combine_6de15c52675e489b874b27eaf16323df_RGB_5;
            float2 _Combine_6de15c52675e489b874b27eaf16323df_RG_6;
            Unity_Combine_float(_Split_cfe4e3a30c93414694a4d7e49c708985_B_3, _Split_cfe4e3a30c93414694a4d7e49c708985_A_4, 0, 0, _Combine_6de15c52675e489b874b27eaf16323df_RGBA_4, _Combine_6de15c52675e489b874b27eaf16323df_RGB_5, _Combine_6de15c52675e489b874b27eaf16323df_RG_6);
            float _Remap_192e92b0649c4e009e825f27b2499763_Out_3;
            Unity_Remap_float(_Power_fe5fa4a062ff4bac868501be2a7f055c_Out_2, _Combine_c045c4c659354461848cd6c7d61e4be5_RG_6, _Combine_6de15c52675e489b874b27eaf16323df_RG_6, _Remap_192e92b0649c4e009e825f27b2499763_Out_3);
            float _Absolute_d5fceabb74744431b85e0fdda3c8cf5c_Out_1;
            Unity_Absolute_float(_Remap_192e92b0649c4e009e825f27b2499763_Out_3, _Absolute_d5fceabb74744431b85e0fdda3c8cf5c_Out_1);
            float _Smoothstep_5b3511aa53f74a73b9b9614372a6af74_Out_3;
            Unity_Smoothstep_float(_Property_ef386ec2d5f4434a8a5f934ff230322f_Out_0, _Property_147f1a2515e04a399eed34de35cf1107_Out_0, _Absolute_d5fceabb74744431b85e0fdda3c8cf5c_Out_1, _Smoothstep_5b3511aa53f74a73b9b9614372a6af74_Out_3);
            float _Property_8fb0c3dbf4a84403a6068e70183a7ea4_Out_0 = _Base_Speed;
            float _Multiply_774f493cd66541e7ba6553802a499b79_Out_2;
            Unity_Multiply_float_float(IN.TimeParameters.x, _Property_8fb0c3dbf4a84403a6068e70183a7ea4_Out_0, _Multiply_774f493cd66541e7ba6553802a499b79_Out_2);
            float2 _TilingAndOffset_969b7b642fd04ed7b2592123a03eca18_Out_3;
            Unity_TilingAndOffset_float((_RotateAboutAxis_6e7d2784bd02405faeb7bacb567d0731_Out_3.xy), float2 (1, 1), (_Multiply_774f493cd66541e7ba6553802a499b79_Out_2.xx), _TilingAndOffset_969b7b642fd04ed7b2592123a03eca18_Out_3);
            float _Property_e3b00c3a5e804e14a1e03e69aac49211_Out_0 = _Base_Scale;
            float _GradientNoise_04262dfbc1b540b1a9d9b997627f189b_Out_2;
            Unity_GradientNoise_float(_TilingAndOffset_969b7b642fd04ed7b2592123a03eca18_Out_3, _Property_e3b00c3a5e804e14a1e03e69aac49211_Out_0, _GradientNoise_04262dfbc1b540b1a9d9b997627f189b_Out_2);
            float _Property_17938a6d7e2f40dd8d0f1b984a9fbb59_Out_0 = _Base_Strength;
            float _Multiply_0854b1bc83aa4170a68f058b8cb96ff7_Out_2;
            Unity_Multiply_float_float(_GradientNoise_04262dfbc1b540b1a9d9b997627f189b_Out_2, _Property_17938a6d7e2f40dd8d0f1b984a9fbb59_Out_0, _Multiply_0854b1bc83aa4170a68f058b8cb96ff7_Out_2);
            float _Add_f82d9f056cbf456f911125a9574d865f_Out_2;
            Unity_Add_float(_Smoothstep_5b3511aa53f74a73b9b9614372a6af74_Out_3, _Multiply_0854b1bc83aa4170a68f058b8cb96ff7_Out_2, _Add_f82d9f056cbf456f911125a9574d865f_Out_2);
            float _Add_df54866b810e4151a1fde09a51f17b65_Out_2;
            Unity_Add_float(1, _Property_17938a6d7e2f40dd8d0f1b984a9fbb59_Out_0, _Add_df54866b810e4151a1fde09a51f17b65_Out_2);
            float _Divide_b2c87465e89040e4940d7d7f42943c3f_Out_2;
            Unity_Divide_float(_Add_f82d9f056cbf456f911125a9574d865f_Out_2, _Add_df54866b810e4151a1fde09a51f17b65_Out_2, _Divide_b2c87465e89040e4940d7d7f42943c3f_Out_2);
            float4 _Lerp_e1c7d9cabc824317b0da8bea40147de4_Out_3;
            Unity_Lerp_float4(_Property_f70ef70650bc4abe8a4358f10ab5f59a_Out_0, _Property_cf745efc5da64fe1acadd633d86b5954_Out_0, (_Divide_b2c87465e89040e4940d7d7f42943c3f_Out_2.xxxx), _Lerp_e1c7d9cabc824317b0da8bea40147de4_Out_3);
            float _Property_33a66f4a3f464542bc2e9201073e6268_Out_0 = _Fresnel_Power;
            float _FresnelEffect_cda7894954cb4589a28e6bdcbd021fde_Out_3;
            Unity_FresnelEffect_float(IN.WorldSpaceNormal, IN.WorldSpaceViewDirection, _Property_33a66f4a3f464542bc2e9201073e6268_Out_0, _FresnelEffect_cda7894954cb4589a28e6bdcbd021fde_Out_3);
            float _Multiply_829db86855944f02b1729d284dda1e98_Out_2;
            Unity_Multiply_float_float(_Divide_b2c87465e89040e4940d7d7f42943c3f_Out_2, _FresnelEffect_cda7894954cb4589a28e6bdcbd021fde_Out_3, _Multiply_829db86855944f02b1729d284dda1e98_Out_2);
            float _Property_f436e175694f4bcc91263ca02ecd0089_Out_0 = _Fresnel_opacity;
            float _Multiply_36396cf8d2ff40a7aeb44aa7c649cd87_Out_2;
            Unity_Multiply_float_float(_Multiply_829db86855944f02b1729d284dda1e98_Out_2, _Property_f436e175694f4bcc91263ca02ecd0089_Out_0, _Multiply_36396cf8d2ff40a7aeb44aa7c649cd87_Out_2);
            float4 _Add_3f758469690e403892df2e9b5577bcda_Out_2;
            Unity_Add_float4(_Lerp_e1c7d9cabc824317b0da8bea40147de4_Out_3, (_Multiply_36396cf8d2ff40a7aeb44aa7c649cd87_Out_2.xxxx), _Add_3f758469690e403892df2e9b5577bcda_Out_2);
            float _SceneDepth_92d0d826f11444f38ddac1aa18b54491_Out_1;
            Unity_SceneDepth_Eye_float(float4(IN.ScreenPosition.xy / IN.ScreenPosition.w, 0, 0), _SceneDepth_92d0d826f11444f38ddac1aa18b54491_Out_1);
            float4 _ScreenPosition_a43e7cd4d3c742149035c252ba0d4ec9_Out_0 = IN.ScreenPosition;
            float _Split_945e233c5d5644b39c8f24743ae9b880_R_1 = _ScreenPosition_a43e7cd4d3c742149035c252ba0d4ec9_Out_0[0];
            float _Split_945e233c5d5644b39c8f24743ae9b880_G_2 = _ScreenPosition_a43e7cd4d3c742149035c252ba0d4ec9_Out_0[1];
            float _Split_945e233c5d5644b39c8f24743ae9b880_B_3 = _ScreenPosition_a43e7cd4d3c742149035c252ba0d4ec9_Out_0[2];
            float _Split_945e233c5d5644b39c8f24743ae9b880_A_4 = _ScreenPosition_a43e7cd4d3c742149035c252ba0d4ec9_Out_0[3];
            float _Subtract_509aa90668e7408bad7076496f9d5759_Out_2;
            Unity_Subtract_float(_Split_945e233c5d5644b39c8f24743ae9b880_A_4, 1, _Subtract_509aa90668e7408bad7076496f9d5759_Out_2);
            float _Subtract_72c15d8c0496460ca2c6aaf585c41381_Out_2;
            Unity_Subtract_float(_SceneDepth_92d0d826f11444f38ddac1aa18b54491_Out_1, _Subtract_509aa90668e7408bad7076496f9d5759_Out_2, _Subtract_72c15d8c0496460ca2c6aaf585c41381_Out_2);
            float _Property_3a30c5a5cbf24fa6913c8ee537ee5f4b_Out_0 = _Fade_Depth;
            float _Divide_8b2505abc71b4c3f8954d6fb229e0865_Out_2;
            Unity_Divide_float(_Subtract_72c15d8c0496460ca2c6aaf585c41381_Out_2, _Property_3a30c5a5cbf24fa6913c8ee537ee5f4b_Out_0, _Divide_8b2505abc71b4c3f8954d6fb229e0865_Out_2);
            float _Saturate_3c60f55f62d842639e72ca2a20ce74df_Out_1;
            Unity_Saturate_float(_Divide_8b2505abc71b4c3f8954d6fb229e0865_Out_2, _Saturate_3c60f55f62d842639e72ca2a20ce74df_Out_1);
            surface.BaseColor = (_Add_3f758469690e403892df2e9b5577bcda_Out_2.xyz);
            surface.Alpha = _Saturate_3c60f55f62d842639e72ca2a20ce74df_Out_1;
            surface.AlphaClipThreshold = 0.5;
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
            output.WorldSpaceNormal =                           TransformObjectToWorldNormal(input.normalOS);
            output.ObjectSpaceTangent =                         input.tangentOS.xyz;
            output.ObjectSpacePosition =                        input.positionOS;
            output.WorldSpacePosition =                         TransformObjectToWorld(input.positionOS);
            output.TimeParameters =                             _TimeParameters.xyz;
        
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
        
            
        
            // must use interpolated tangent, bitangent and normal before they are normalized in the pixel shader.
            float3 unnormalizedNormalWS = input.normalWS;
            const float renormFactor = 1.0 / length(unnormalizedNormalWS);
        
        
            output.WorldSpaceNormal = renormFactor * input.normalWS.xyz;      // we want a unit length Normal Vector node in shader graph
        
        
            output.WorldSpaceViewDirection = normalize(input.viewDirectionWS);
            output.WorldSpacePosition = input.positionWS;
            output.ScreenPosition = ComputeScreenPos(TransformWorldToHClip(input.positionWS), _ProjectionParams.x);
            output.TimeParameters = _TimeParameters.xyz; // This is mainly for LW as HD overwrite this value
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
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/UnlitPass.hlsl"
        
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
        Cull [_Cull]
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
        
        // DotsInstancingOptions: <None>
        // HybridV1InjectedBuiltinProperties: <None>
        
        // Keywords
        #pragma shader_feature_local_fragment _ _ALPHATEST_ON
        // GraphKeywords: <None>
        
        // Defines
        
        #define ATTRIBUTES_NEED_NORMAL
        #define ATTRIBUTES_NEED_TANGENT
        #define VARYINGS_NEED_POSITION_WS
        #define FEATURES_GRAPH_VERTEX
        /* WARNING: $splice Could not find named fragment 'PassInstancing' */
        #define SHADERPASS SHADERPASS_DEPTHONLY
        #define REQUIRE_DEPTH_TEXTURE
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
             float3 positionWS;
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
             float3 WorldSpacePosition;
             float4 ScreenPosition;
        };
        struct VertexDescriptionInputs
        {
             float3 ObjectSpaceNormal;
             float3 WorldSpaceNormal;
             float3 ObjectSpaceTangent;
             float3 ObjectSpacePosition;
             float3 WorldSpacePosition;
             float3 TimeParameters;
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
            output.interp0.xyz =  input.positionWS;
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
        float4 _Rotate_Projection;
        float _Noise_Scale;
        float _Noise_Speed;
        float _Noise_Height;
        float4 _Noise_Remap;
        float4 _Colour_Peak;
        float4 _Colour_Valley;
        float _Noise_Edge_1;
        float _Noise_Edge_2;
        float _Noise_Power;
        float _Base_Scale;
        float _Base_Speed;
        float _Base_Strength;
        float _Emission;
        float _Curvature_Radius;
        float _Fresnel_Power;
        float _Fresnel_opacity;
        float _Fade_Depth;
        CBUFFER_END
        
        // Object and Global properties
        
        // Graph Includes
        // GraphIncludes: <None>
        
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
        
        void Unity_Distance_float3(float3 A, float3 B, out float Out)
        {
            Out = distance(A, B);
        }
        
        void Unity_Divide_float(float A, float B, out float Out)
        {
            Out = A / B;
        }
        
        void Unity_Power_float(float A, float B, out float Out)
        {
            Out = pow(A, B);
        }
        
        void Unity_Multiply_float3_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A * B;
        }
        
        void Unity_Rotate_About_Axis_Degrees_float(float3 In, float3 Axis, float Rotation, out float3 Out)
        {
            Rotation = radians(Rotation);
        
            float s = sin(Rotation);
            float c = cos(Rotation);
            float one_minus_c = 1.0 - c;
        
            Axis = normalize(Axis);
        
            float3x3 rot_mat = { one_minus_c * Axis.x * Axis.x + c,            one_minus_c * Axis.x * Axis.y - Axis.z * s,     one_minus_c * Axis.z * Axis.x + Axis.y * s,
                                      one_minus_c * Axis.x * Axis.y + Axis.z * s,   one_minus_c * Axis.y * Axis.y + c,              one_minus_c * Axis.y * Axis.z - Axis.x * s,
                                      one_minus_c * Axis.z * Axis.x - Axis.y * s,   one_minus_c * Axis.y * Axis.z + Axis.x * s,     one_minus_c * Axis.z * Axis.z + c
                                    };
        
            Out = mul(rot_mat,  In);
        }
        
        void Unity_Multiply_float_float(float A, float B, out float Out)
        {
            Out = A * B;
        }
        
        void Unity_TilingAndOffset_float(float2 UV, float2 Tiling, float2 Offset, out float2 Out)
        {
            Out = UV * Tiling + Offset;
        }
        
        
        float2 Unity_GradientNoise_Dir_float(float2 p)
        {
            // Permutation and hashing used in webgl-nosie goo.gl/pX7HtC
            p = p % 289;
            // need full precision, otherwise half overflows when p > 1
            float x = float(34 * p.x + 1) * p.x % 289 + p.y;
            x = (34 * x + 1) * x % 289;
            x = frac(x / 41) * 2 - 1;
            return normalize(float2(x - floor(x + 0.5), abs(x) - 0.5));
        }
        
        void Unity_GradientNoise_float(float2 UV, float Scale, out float Out)
        {
            float2 p = UV * Scale;
            float2 ip = floor(p);
            float2 fp = frac(p);
            float d00 = dot(Unity_GradientNoise_Dir_float(ip), fp);
            float d01 = dot(Unity_GradientNoise_Dir_float(ip + float2(0, 1)), fp - float2(0, 1));
            float d10 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 0)), fp - float2(1, 0));
            float d11 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 1)), fp - float2(1, 1));
            fp = fp * fp * fp * (fp * (fp * 6 - 15) + 10);
            Out = lerp(lerp(d00, d01, fp.y), lerp(d10, d11, fp.y), fp.x) + 0.5;
        }
        
        void Unity_Add_float(float A, float B, out float Out)
        {
            Out = A + B;
        }
        
        void Unity_Saturate_float(float In, out float Out)
        {
            Out = saturate(In);
        }
        
        void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
        {
            RGBA = float4(R, G, B, A);
            RGB = float3(R, G, B);
            RG = float2(R, G);
        }
        
        void Unity_Remap_float(float In, float2 InMinMax, float2 OutMinMax, out float Out)
        {
            Out = OutMinMax.x + (In - InMinMax.x) * (OutMinMax.y - OutMinMax.x) / (InMinMax.y - InMinMax.x);
        }
        
        void Unity_Absolute_float(float In, out float Out)
        {
            Out = abs(In);
        }
        
        void Unity_Smoothstep_float(float Edge1, float Edge2, float In, out float Out)
        {
            Out = smoothstep(Edge1, Edge2, In);
        }
        
        void Unity_Add_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A + B;
        }
        
        void Unity_SceneDepth_Eye_float(float4 UV, out float Out)
        {
            if (unity_OrthoParams.w == 1.0)
            {
                Out = LinearEyeDepth(ComputeWorldSpacePosition(UV.xy, SHADERGRAPH_SAMPLE_SCENE_DEPTH(UV.xy), UNITY_MATRIX_I_VP), UNITY_MATRIX_V);
            }
            else
            {
                Out = LinearEyeDepth(SHADERGRAPH_SAMPLE_SCENE_DEPTH(UV.xy), _ZBufferParams);
            }
        }
        
        void Unity_Subtract_float(float A, float B, out float Out)
        {
            Out = A - B;
        }
        
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
            float _Distance_c01ba79505ea4a8891c3da5756fe9e5a_Out_2;
            Unity_Distance_float3(SHADERGRAPH_OBJECT_POSITION, IN.WorldSpacePosition, _Distance_c01ba79505ea4a8891c3da5756fe9e5a_Out_2);
            float _Property_d1be4d71eb4e4aae9337b9b402f45d63_Out_0 = _Curvature_Radius;
            float _Divide_03646e2359744ec38397913fc1d7c270_Out_2;
            Unity_Divide_float(_Distance_c01ba79505ea4a8891c3da5756fe9e5a_Out_2, _Property_d1be4d71eb4e4aae9337b9b402f45d63_Out_0, _Divide_03646e2359744ec38397913fc1d7c270_Out_2);
            float _Power_07f0eac51f1244fbb5c4966f586ac4dc_Out_2;
            Unity_Power_float(_Divide_03646e2359744ec38397913fc1d7c270_Out_2, 3, _Power_07f0eac51f1244fbb5c4966f586ac4dc_Out_2);
            float3 _Multiply_5ca41a1165784fbe980a8c3177fad7e1_Out_2;
            Unity_Multiply_float3_float3(IN.WorldSpaceNormal, (_Power_07f0eac51f1244fbb5c4966f586ac4dc_Out_2.xxx), _Multiply_5ca41a1165784fbe980a8c3177fad7e1_Out_2);
            float _Property_ef386ec2d5f4434a8a5f934ff230322f_Out_0 = _Noise_Edge_1;
            float _Property_147f1a2515e04a399eed34de35cf1107_Out_0 = _Noise_Edge_2;
            float4 _Property_b84368a6bae8433994c8bf5d771c01f4_Out_0 = _Rotate_Projection;
            float _Split_31db8d949ab24fd1b5ded76e6ecb6868_R_1 = _Property_b84368a6bae8433994c8bf5d771c01f4_Out_0[0];
            float _Split_31db8d949ab24fd1b5ded76e6ecb6868_G_2 = _Property_b84368a6bae8433994c8bf5d771c01f4_Out_0[1];
            float _Split_31db8d949ab24fd1b5ded76e6ecb6868_B_3 = _Property_b84368a6bae8433994c8bf5d771c01f4_Out_0[2];
            float _Split_31db8d949ab24fd1b5ded76e6ecb6868_A_4 = _Property_b84368a6bae8433994c8bf5d771c01f4_Out_0[3];
            float3 _RotateAboutAxis_6e7d2784bd02405faeb7bacb567d0731_Out_3;
            Unity_Rotate_About_Axis_Degrees_float(IN.WorldSpacePosition, (_Property_b84368a6bae8433994c8bf5d771c01f4_Out_0.xyz), _Split_31db8d949ab24fd1b5ded76e6ecb6868_A_4, _RotateAboutAxis_6e7d2784bd02405faeb7bacb567d0731_Out_3);
            float _Property_1b5acb9aca4b4c1ca8150917cb29e38d_Out_0 = _Noise_Speed;
            float _Multiply_a1f01de168c5412e848fa5a9a4f633d8_Out_2;
            Unity_Multiply_float_float(IN.TimeParameters.x, _Property_1b5acb9aca4b4c1ca8150917cb29e38d_Out_0, _Multiply_a1f01de168c5412e848fa5a9a4f633d8_Out_2);
            float2 _TilingAndOffset_3a22eccd71474e639594fce72cde2d02_Out_3;
            Unity_TilingAndOffset_float((_RotateAboutAxis_6e7d2784bd02405faeb7bacb567d0731_Out_3.xy), float2 (1, 1), (_Multiply_a1f01de168c5412e848fa5a9a4f633d8_Out_2.xx), _TilingAndOffset_3a22eccd71474e639594fce72cde2d02_Out_3);
            float _Property_e34f89cb08684afb94f0ac41ba675b11_Out_0 = _Noise_Scale;
            float _GradientNoise_71dea3d8ca7f493a820838ec4624d407_Out_2;
            Unity_GradientNoise_float(_TilingAndOffset_3a22eccd71474e639594fce72cde2d02_Out_3, _Property_e34f89cb08684afb94f0ac41ba675b11_Out_0, _GradientNoise_71dea3d8ca7f493a820838ec4624d407_Out_2);
            float2 _TilingAndOffset_b402f80311694eb4b5a4c3d07e71c615_Out_3;
            Unity_TilingAndOffset_float((_RotateAboutAxis_6e7d2784bd02405faeb7bacb567d0731_Out_3.xy), float2 (1, 1), float2 (0, 0), _TilingAndOffset_b402f80311694eb4b5a4c3d07e71c615_Out_3);
            float _GradientNoise_7cfc31faa781410090b11ae418c9e103_Out_2;
            Unity_GradientNoise_float(_TilingAndOffset_b402f80311694eb4b5a4c3d07e71c615_Out_3, _Property_e34f89cb08684afb94f0ac41ba675b11_Out_0, _GradientNoise_7cfc31faa781410090b11ae418c9e103_Out_2);
            float _Add_8d3a946d8f7848c0a6a4ee9e280c511d_Out_2;
            Unity_Add_float(_GradientNoise_71dea3d8ca7f493a820838ec4624d407_Out_2, _GradientNoise_7cfc31faa781410090b11ae418c9e103_Out_2, _Add_8d3a946d8f7848c0a6a4ee9e280c511d_Out_2);
            float _Divide_883697060c4b42898d76bc5325a5b568_Out_2;
            Unity_Divide_float(_Add_8d3a946d8f7848c0a6a4ee9e280c511d_Out_2, 2, _Divide_883697060c4b42898d76bc5325a5b568_Out_2);
            float _Saturate_c96331ef3b2642d39a446bce3d43f560_Out_1;
            Unity_Saturate_float(_Divide_883697060c4b42898d76bc5325a5b568_Out_2, _Saturate_c96331ef3b2642d39a446bce3d43f560_Out_1);
            float _Property_a5e2c659762f49e2826023553b233885_Out_0 = _Noise_Power;
            float _Power_fe5fa4a062ff4bac868501be2a7f055c_Out_2;
            Unity_Power_float(_Saturate_c96331ef3b2642d39a446bce3d43f560_Out_1, _Property_a5e2c659762f49e2826023553b233885_Out_0, _Power_fe5fa4a062ff4bac868501be2a7f055c_Out_2);
            float4 _Property_f466dd4679cc4567b14cecb45e839124_Out_0 = _Noise_Remap;
            float _Split_cfe4e3a30c93414694a4d7e49c708985_R_1 = _Property_f466dd4679cc4567b14cecb45e839124_Out_0[0];
            float _Split_cfe4e3a30c93414694a4d7e49c708985_G_2 = _Property_f466dd4679cc4567b14cecb45e839124_Out_0[1];
            float _Split_cfe4e3a30c93414694a4d7e49c708985_B_3 = _Property_f466dd4679cc4567b14cecb45e839124_Out_0[2];
            float _Split_cfe4e3a30c93414694a4d7e49c708985_A_4 = _Property_f466dd4679cc4567b14cecb45e839124_Out_0[3];
            float4 _Combine_c045c4c659354461848cd6c7d61e4be5_RGBA_4;
            float3 _Combine_c045c4c659354461848cd6c7d61e4be5_RGB_5;
            float2 _Combine_c045c4c659354461848cd6c7d61e4be5_RG_6;
            Unity_Combine_float(_Split_cfe4e3a30c93414694a4d7e49c708985_R_1, _Split_cfe4e3a30c93414694a4d7e49c708985_G_2, 0, 0, _Combine_c045c4c659354461848cd6c7d61e4be5_RGBA_4, _Combine_c045c4c659354461848cd6c7d61e4be5_RGB_5, _Combine_c045c4c659354461848cd6c7d61e4be5_RG_6);
            float4 _Combine_6de15c52675e489b874b27eaf16323df_RGBA_4;
            float3 _Combine_6de15c52675e489b874b27eaf16323df_RGB_5;
            float2 _Combine_6de15c52675e489b874b27eaf16323df_RG_6;
            Unity_Combine_float(_Split_cfe4e3a30c93414694a4d7e49c708985_B_3, _Split_cfe4e3a30c93414694a4d7e49c708985_A_4, 0, 0, _Combine_6de15c52675e489b874b27eaf16323df_RGBA_4, _Combine_6de15c52675e489b874b27eaf16323df_RGB_5, _Combine_6de15c52675e489b874b27eaf16323df_RG_6);
            float _Remap_192e92b0649c4e009e825f27b2499763_Out_3;
            Unity_Remap_float(_Power_fe5fa4a062ff4bac868501be2a7f055c_Out_2, _Combine_c045c4c659354461848cd6c7d61e4be5_RG_6, _Combine_6de15c52675e489b874b27eaf16323df_RG_6, _Remap_192e92b0649c4e009e825f27b2499763_Out_3);
            float _Absolute_d5fceabb74744431b85e0fdda3c8cf5c_Out_1;
            Unity_Absolute_float(_Remap_192e92b0649c4e009e825f27b2499763_Out_3, _Absolute_d5fceabb74744431b85e0fdda3c8cf5c_Out_1);
            float _Smoothstep_5b3511aa53f74a73b9b9614372a6af74_Out_3;
            Unity_Smoothstep_float(_Property_ef386ec2d5f4434a8a5f934ff230322f_Out_0, _Property_147f1a2515e04a399eed34de35cf1107_Out_0, _Absolute_d5fceabb74744431b85e0fdda3c8cf5c_Out_1, _Smoothstep_5b3511aa53f74a73b9b9614372a6af74_Out_3);
            float _Property_8fb0c3dbf4a84403a6068e70183a7ea4_Out_0 = _Base_Speed;
            float _Multiply_774f493cd66541e7ba6553802a499b79_Out_2;
            Unity_Multiply_float_float(IN.TimeParameters.x, _Property_8fb0c3dbf4a84403a6068e70183a7ea4_Out_0, _Multiply_774f493cd66541e7ba6553802a499b79_Out_2);
            float2 _TilingAndOffset_969b7b642fd04ed7b2592123a03eca18_Out_3;
            Unity_TilingAndOffset_float((_RotateAboutAxis_6e7d2784bd02405faeb7bacb567d0731_Out_3.xy), float2 (1, 1), (_Multiply_774f493cd66541e7ba6553802a499b79_Out_2.xx), _TilingAndOffset_969b7b642fd04ed7b2592123a03eca18_Out_3);
            float _Property_e3b00c3a5e804e14a1e03e69aac49211_Out_0 = _Base_Scale;
            float _GradientNoise_04262dfbc1b540b1a9d9b997627f189b_Out_2;
            Unity_GradientNoise_float(_TilingAndOffset_969b7b642fd04ed7b2592123a03eca18_Out_3, _Property_e3b00c3a5e804e14a1e03e69aac49211_Out_0, _GradientNoise_04262dfbc1b540b1a9d9b997627f189b_Out_2);
            float _Property_17938a6d7e2f40dd8d0f1b984a9fbb59_Out_0 = _Base_Strength;
            float _Multiply_0854b1bc83aa4170a68f058b8cb96ff7_Out_2;
            Unity_Multiply_float_float(_GradientNoise_04262dfbc1b540b1a9d9b997627f189b_Out_2, _Property_17938a6d7e2f40dd8d0f1b984a9fbb59_Out_0, _Multiply_0854b1bc83aa4170a68f058b8cb96ff7_Out_2);
            float _Add_f82d9f056cbf456f911125a9574d865f_Out_2;
            Unity_Add_float(_Smoothstep_5b3511aa53f74a73b9b9614372a6af74_Out_3, _Multiply_0854b1bc83aa4170a68f058b8cb96ff7_Out_2, _Add_f82d9f056cbf456f911125a9574d865f_Out_2);
            float _Add_df54866b810e4151a1fde09a51f17b65_Out_2;
            Unity_Add_float(1, _Property_17938a6d7e2f40dd8d0f1b984a9fbb59_Out_0, _Add_df54866b810e4151a1fde09a51f17b65_Out_2);
            float _Divide_b2c87465e89040e4940d7d7f42943c3f_Out_2;
            Unity_Divide_float(_Add_f82d9f056cbf456f911125a9574d865f_Out_2, _Add_df54866b810e4151a1fde09a51f17b65_Out_2, _Divide_b2c87465e89040e4940d7d7f42943c3f_Out_2);
            float3 _Multiply_cc4eb1139ae74d4c85067f5171acc955_Out_2;
            Unity_Multiply_float3_float3(IN.ObjectSpaceNormal, (_Divide_b2c87465e89040e4940d7d7f42943c3f_Out_2.xxx), _Multiply_cc4eb1139ae74d4c85067f5171acc955_Out_2);
            float _Property_611696cf692e4bb19aaf7739c57cdd44_Out_0 = _Noise_Height;
            float3 _Multiply_da4791b114e34eceac3bacbb1043285e_Out_2;
            Unity_Multiply_float3_float3(_Multiply_cc4eb1139ae74d4c85067f5171acc955_Out_2, (_Property_611696cf692e4bb19aaf7739c57cdd44_Out_0.xxx), _Multiply_da4791b114e34eceac3bacbb1043285e_Out_2);
            float3 _Add_1af6468ff1e344348b74bd929f252cbf_Out_2;
            Unity_Add_float3(IN.ObjectSpacePosition, _Multiply_da4791b114e34eceac3bacbb1043285e_Out_2, _Add_1af6468ff1e344348b74bd929f252cbf_Out_2);
            float3 _Add_c7842509b95b4858bfbf1f91fea0a4c3_Out_2;
            Unity_Add_float3(_Multiply_5ca41a1165784fbe980a8c3177fad7e1_Out_2, _Add_1af6468ff1e344348b74bd929f252cbf_Out_2, _Add_c7842509b95b4858bfbf1f91fea0a4c3_Out_2);
            description.Position = _Add_c7842509b95b4858bfbf1f91fea0a4c3_Out_2;
            description.Normal = IN.ObjectSpaceNormal;
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
            float Alpha;
            float AlphaClipThreshold;
        };
        
        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            float _SceneDepth_92d0d826f11444f38ddac1aa18b54491_Out_1;
            Unity_SceneDepth_Eye_float(float4(IN.ScreenPosition.xy / IN.ScreenPosition.w, 0, 0), _SceneDepth_92d0d826f11444f38ddac1aa18b54491_Out_1);
            float4 _ScreenPosition_a43e7cd4d3c742149035c252ba0d4ec9_Out_0 = IN.ScreenPosition;
            float _Split_945e233c5d5644b39c8f24743ae9b880_R_1 = _ScreenPosition_a43e7cd4d3c742149035c252ba0d4ec9_Out_0[0];
            float _Split_945e233c5d5644b39c8f24743ae9b880_G_2 = _ScreenPosition_a43e7cd4d3c742149035c252ba0d4ec9_Out_0[1];
            float _Split_945e233c5d5644b39c8f24743ae9b880_B_3 = _ScreenPosition_a43e7cd4d3c742149035c252ba0d4ec9_Out_0[2];
            float _Split_945e233c5d5644b39c8f24743ae9b880_A_4 = _ScreenPosition_a43e7cd4d3c742149035c252ba0d4ec9_Out_0[3];
            float _Subtract_509aa90668e7408bad7076496f9d5759_Out_2;
            Unity_Subtract_float(_Split_945e233c5d5644b39c8f24743ae9b880_A_4, 1, _Subtract_509aa90668e7408bad7076496f9d5759_Out_2);
            float _Subtract_72c15d8c0496460ca2c6aaf585c41381_Out_2;
            Unity_Subtract_float(_SceneDepth_92d0d826f11444f38ddac1aa18b54491_Out_1, _Subtract_509aa90668e7408bad7076496f9d5759_Out_2, _Subtract_72c15d8c0496460ca2c6aaf585c41381_Out_2);
            float _Property_3a30c5a5cbf24fa6913c8ee537ee5f4b_Out_0 = _Fade_Depth;
            float _Divide_8b2505abc71b4c3f8954d6fb229e0865_Out_2;
            Unity_Divide_float(_Subtract_72c15d8c0496460ca2c6aaf585c41381_Out_2, _Property_3a30c5a5cbf24fa6913c8ee537ee5f4b_Out_0, _Divide_8b2505abc71b4c3f8954d6fb229e0865_Out_2);
            float _Saturate_3c60f55f62d842639e72ca2a20ce74df_Out_1;
            Unity_Saturate_float(_Divide_8b2505abc71b4c3f8954d6fb229e0865_Out_2, _Saturate_3c60f55f62d842639e72ca2a20ce74df_Out_1);
            surface.Alpha = _Saturate_3c60f55f62d842639e72ca2a20ce74df_Out_1;
            surface.AlphaClipThreshold = 0.5;
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
            output.WorldSpaceNormal =                           TransformObjectToWorldNormal(input.normalOS);
            output.ObjectSpaceTangent =                         input.tangentOS.xyz;
            output.ObjectSpacePosition =                        input.positionOS;
            output.WorldSpacePosition =                         TransformObjectToWorld(input.positionOS);
            output.TimeParameters =                             _TimeParameters.xyz;
        
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
        
            
        
        
        
        
        
            output.WorldSpacePosition = input.positionWS;
            output.ScreenPosition = ComputeScreenPos(TransformWorldToHClip(input.positionWS), _ProjectionParams.x);
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
            Name "DepthNormalsOnly"
            Tags
            {
                "LightMode" = "DepthNormalsOnly"
            }
        
        // Render State
        Cull [_Cull]
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
        
        // DotsInstancingOptions: <None>
        // HybridV1InjectedBuiltinProperties: <None>
        
        // Keywords
        #pragma shader_feature_local_fragment _ _ALPHATEST_ON
        // GraphKeywords: <None>
        
        // Defines
        
        #define ATTRIBUTES_NEED_NORMAL
        #define ATTRIBUTES_NEED_TANGENT
        #define ATTRIBUTES_NEED_TEXCOORD1
        #define VARYINGS_NEED_POSITION_WS
        #define VARYINGS_NEED_NORMAL_WS
        #define VARYINGS_NEED_TANGENT_WS
        #define FEATURES_GRAPH_VERTEX
        /* WARNING: $splice Could not find named fragment 'PassInstancing' */
        #define SHADERPASS SHADERPASS_DEPTHNORMALSONLY
        #define REQUIRE_DEPTH_TEXTURE
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
             float4 uv1 : TEXCOORD1;
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
             float3 WorldSpacePosition;
             float4 ScreenPosition;
        };
        struct VertexDescriptionInputs
        {
             float3 ObjectSpaceNormal;
             float3 WorldSpaceNormal;
             float3 ObjectSpaceTangent;
             float3 ObjectSpacePosition;
             float3 WorldSpacePosition;
             float3 TimeParameters;
        };
        struct PackedVaryings
        {
             float4 positionCS : SV_POSITION;
             float3 interp0 : INTERP0;
             float3 interp1 : INTERP1;
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
            output.interp0.xyz =  input.positionWS;
            output.interp1.xyz =  input.normalWS;
            output.interp2.xyzw =  input.tangentWS;
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
        float4 _Rotate_Projection;
        float _Noise_Scale;
        float _Noise_Speed;
        float _Noise_Height;
        float4 _Noise_Remap;
        float4 _Colour_Peak;
        float4 _Colour_Valley;
        float _Noise_Edge_1;
        float _Noise_Edge_2;
        float _Noise_Power;
        float _Base_Scale;
        float _Base_Speed;
        float _Base_Strength;
        float _Emission;
        float _Curvature_Radius;
        float _Fresnel_Power;
        float _Fresnel_opacity;
        float _Fade_Depth;
        CBUFFER_END
        
        // Object and Global properties
        
        // Graph Includes
        // GraphIncludes: <None>
        
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
        
        void Unity_Distance_float3(float3 A, float3 B, out float Out)
        {
            Out = distance(A, B);
        }
        
        void Unity_Divide_float(float A, float B, out float Out)
        {
            Out = A / B;
        }
        
        void Unity_Power_float(float A, float B, out float Out)
        {
            Out = pow(A, B);
        }
        
        void Unity_Multiply_float3_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A * B;
        }
        
        void Unity_Rotate_About_Axis_Degrees_float(float3 In, float3 Axis, float Rotation, out float3 Out)
        {
            Rotation = radians(Rotation);
        
            float s = sin(Rotation);
            float c = cos(Rotation);
            float one_minus_c = 1.0 - c;
        
            Axis = normalize(Axis);
        
            float3x3 rot_mat = { one_minus_c * Axis.x * Axis.x + c,            one_minus_c * Axis.x * Axis.y - Axis.z * s,     one_minus_c * Axis.z * Axis.x + Axis.y * s,
                                      one_minus_c * Axis.x * Axis.y + Axis.z * s,   one_minus_c * Axis.y * Axis.y + c,              one_minus_c * Axis.y * Axis.z - Axis.x * s,
                                      one_minus_c * Axis.z * Axis.x - Axis.y * s,   one_minus_c * Axis.y * Axis.z + Axis.x * s,     one_minus_c * Axis.z * Axis.z + c
                                    };
        
            Out = mul(rot_mat,  In);
        }
        
        void Unity_Multiply_float_float(float A, float B, out float Out)
        {
            Out = A * B;
        }
        
        void Unity_TilingAndOffset_float(float2 UV, float2 Tiling, float2 Offset, out float2 Out)
        {
            Out = UV * Tiling + Offset;
        }
        
        
        float2 Unity_GradientNoise_Dir_float(float2 p)
        {
            // Permutation and hashing used in webgl-nosie goo.gl/pX7HtC
            p = p % 289;
            // need full precision, otherwise half overflows when p > 1
            float x = float(34 * p.x + 1) * p.x % 289 + p.y;
            x = (34 * x + 1) * x % 289;
            x = frac(x / 41) * 2 - 1;
            return normalize(float2(x - floor(x + 0.5), abs(x) - 0.5));
        }
        
        void Unity_GradientNoise_float(float2 UV, float Scale, out float Out)
        {
            float2 p = UV * Scale;
            float2 ip = floor(p);
            float2 fp = frac(p);
            float d00 = dot(Unity_GradientNoise_Dir_float(ip), fp);
            float d01 = dot(Unity_GradientNoise_Dir_float(ip + float2(0, 1)), fp - float2(0, 1));
            float d10 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 0)), fp - float2(1, 0));
            float d11 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 1)), fp - float2(1, 1));
            fp = fp * fp * fp * (fp * (fp * 6 - 15) + 10);
            Out = lerp(lerp(d00, d01, fp.y), lerp(d10, d11, fp.y), fp.x) + 0.5;
        }
        
        void Unity_Add_float(float A, float B, out float Out)
        {
            Out = A + B;
        }
        
        void Unity_Saturate_float(float In, out float Out)
        {
            Out = saturate(In);
        }
        
        void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
        {
            RGBA = float4(R, G, B, A);
            RGB = float3(R, G, B);
            RG = float2(R, G);
        }
        
        void Unity_Remap_float(float In, float2 InMinMax, float2 OutMinMax, out float Out)
        {
            Out = OutMinMax.x + (In - InMinMax.x) * (OutMinMax.y - OutMinMax.x) / (InMinMax.y - InMinMax.x);
        }
        
        void Unity_Absolute_float(float In, out float Out)
        {
            Out = abs(In);
        }
        
        void Unity_Smoothstep_float(float Edge1, float Edge2, float In, out float Out)
        {
            Out = smoothstep(Edge1, Edge2, In);
        }
        
        void Unity_Add_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A + B;
        }
        
        void Unity_SceneDepth_Eye_float(float4 UV, out float Out)
        {
            if (unity_OrthoParams.w == 1.0)
            {
                Out = LinearEyeDepth(ComputeWorldSpacePosition(UV.xy, SHADERGRAPH_SAMPLE_SCENE_DEPTH(UV.xy), UNITY_MATRIX_I_VP), UNITY_MATRIX_V);
            }
            else
            {
                Out = LinearEyeDepth(SHADERGRAPH_SAMPLE_SCENE_DEPTH(UV.xy), _ZBufferParams);
            }
        }
        
        void Unity_Subtract_float(float A, float B, out float Out)
        {
            Out = A - B;
        }
        
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
            float _Distance_c01ba79505ea4a8891c3da5756fe9e5a_Out_2;
            Unity_Distance_float3(SHADERGRAPH_OBJECT_POSITION, IN.WorldSpacePosition, _Distance_c01ba79505ea4a8891c3da5756fe9e5a_Out_2);
            float _Property_d1be4d71eb4e4aae9337b9b402f45d63_Out_0 = _Curvature_Radius;
            float _Divide_03646e2359744ec38397913fc1d7c270_Out_2;
            Unity_Divide_float(_Distance_c01ba79505ea4a8891c3da5756fe9e5a_Out_2, _Property_d1be4d71eb4e4aae9337b9b402f45d63_Out_0, _Divide_03646e2359744ec38397913fc1d7c270_Out_2);
            float _Power_07f0eac51f1244fbb5c4966f586ac4dc_Out_2;
            Unity_Power_float(_Divide_03646e2359744ec38397913fc1d7c270_Out_2, 3, _Power_07f0eac51f1244fbb5c4966f586ac4dc_Out_2);
            float3 _Multiply_5ca41a1165784fbe980a8c3177fad7e1_Out_2;
            Unity_Multiply_float3_float3(IN.WorldSpaceNormal, (_Power_07f0eac51f1244fbb5c4966f586ac4dc_Out_2.xxx), _Multiply_5ca41a1165784fbe980a8c3177fad7e1_Out_2);
            float _Property_ef386ec2d5f4434a8a5f934ff230322f_Out_0 = _Noise_Edge_1;
            float _Property_147f1a2515e04a399eed34de35cf1107_Out_0 = _Noise_Edge_2;
            float4 _Property_b84368a6bae8433994c8bf5d771c01f4_Out_0 = _Rotate_Projection;
            float _Split_31db8d949ab24fd1b5ded76e6ecb6868_R_1 = _Property_b84368a6bae8433994c8bf5d771c01f4_Out_0[0];
            float _Split_31db8d949ab24fd1b5ded76e6ecb6868_G_2 = _Property_b84368a6bae8433994c8bf5d771c01f4_Out_0[1];
            float _Split_31db8d949ab24fd1b5ded76e6ecb6868_B_3 = _Property_b84368a6bae8433994c8bf5d771c01f4_Out_0[2];
            float _Split_31db8d949ab24fd1b5ded76e6ecb6868_A_4 = _Property_b84368a6bae8433994c8bf5d771c01f4_Out_0[3];
            float3 _RotateAboutAxis_6e7d2784bd02405faeb7bacb567d0731_Out_3;
            Unity_Rotate_About_Axis_Degrees_float(IN.WorldSpacePosition, (_Property_b84368a6bae8433994c8bf5d771c01f4_Out_0.xyz), _Split_31db8d949ab24fd1b5ded76e6ecb6868_A_4, _RotateAboutAxis_6e7d2784bd02405faeb7bacb567d0731_Out_3);
            float _Property_1b5acb9aca4b4c1ca8150917cb29e38d_Out_0 = _Noise_Speed;
            float _Multiply_a1f01de168c5412e848fa5a9a4f633d8_Out_2;
            Unity_Multiply_float_float(IN.TimeParameters.x, _Property_1b5acb9aca4b4c1ca8150917cb29e38d_Out_0, _Multiply_a1f01de168c5412e848fa5a9a4f633d8_Out_2);
            float2 _TilingAndOffset_3a22eccd71474e639594fce72cde2d02_Out_3;
            Unity_TilingAndOffset_float((_RotateAboutAxis_6e7d2784bd02405faeb7bacb567d0731_Out_3.xy), float2 (1, 1), (_Multiply_a1f01de168c5412e848fa5a9a4f633d8_Out_2.xx), _TilingAndOffset_3a22eccd71474e639594fce72cde2d02_Out_3);
            float _Property_e34f89cb08684afb94f0ac41ba675b11_Out_0 = _Noise_Scale;
            float _GradientNoise_71dea3d8ca7f493a820838ec4624d407_Out_2;
            Unity_GradientNoise_float(_TilingAndOffset_3a22eccd71474e639594fce72cde2d02_Out_3, _Property_e34f89cb08684afb94f0ac41ba675b11_Out_0, _GradientNoise_71dea3d8ca7f493a820838ec4624d407_Out_2);
            float2 _TilingAndOffset_b402f80311694eb4b5a4c3d07e71c615_Out_3;
            Unity_TilingAndOffset_float((_RotateAboutAxis_6e7d2784bd02405faeb7bacb567d0731_Out_3.xy), float2 (1, 1), float2 (0, 0), _TilingAndOffset_b402f80311694eb4b5a4c3d07e71c615_Out_3);
            float _GradientNoise_7cfc31faa781410090b11ae418c9e103_Out_2;
            Unity_GradientNoise_float(_TilingAndOffset_b402f80311694eb4b5a4c3d07e71c615_Out_3, _Property_e34f89cb08684afb94f0ac41ba675b11_Out_0, _GradientNoise_7cfc31faa781410090b11ae418c9e103_Out_2);
            float _Add_8d3a946d8f7848c0a6a4ee9e280c511d_Out_2;
            Unity_Add_float(_GradientNoise_71dea3d8ca7f493a820838ec4624d407_Out_2, _GradientNoise_7cfc31faa781410090b11ae418c9e103_Out_2, _Add_8d3a946d8f7848c0a6a4ee9e280c511d_Out_2);
            float _Divide_883697060c4b42898d76bc5325a5b568_Out_2;
            Unity_Divide_float(_Add_8d3a946d8f7848c0a6a4ee9e280c511d_Out_2, 2, _Divide_883697060c4b42898d76bc5325a5b568_Out_2);
            float _Saturate_c96331ef3b2642d39a446bce3d43f560_Out_1;
            Unity_Saturate_float(_Divide_883697060c4b42898d76bc5325a5b568_Out_2, _Saturate_c96331ef3b2642d39a446bce3d43f560_Out_1);
            float _Property_a5e2c659762f49e2826023553b233885_Out_0 = _Noise_Power;
            float _Power_fe5fa4a062ff4bac868501be2a7f055c_Out_2;
            Unity_Power_float(_Saturate_c96331ef3b2642d39a446bce3d43f560_Out_1, _Property_a5e2c659762f49e2826023553b233885_Out_0, _Power_fe5fa4a062ff4bac868501be2a7f055c_Out_2);
            float4 _Property_f466dd4679cc4567b14cecb45e839124_Out_0 = _Noise_Remap;
            float _Split_cfe4e3a30c93414694a4d7e49c708985_R_1 = _Property_f466dd4679cc4567b14cecb45e839124_Out_0[0];
            float _Split_cfe4e3a30c93414694a4d7e49c708985_G_2 = _Property_f466dd4679cc4567b14cecb45e839124_Out_0[1];
            float _Split_cfe4e3a30c93414694a4d7e49c708985_B_3 = _Property_f466dd4679cc4567b14cecb45e839124_Out_0[2];
            float _Split_cfe4e3a30c93414694a4d7e49c708985_A_4 = _Property_f466dd4679cc4567b14cecb45e839124_Out_0[3];
            float4 _Combine_c045c4c659354461848cd6c7d61e4be5_RGBA_4;
            float3 _Combine_c045c4c659354461848cd6c7d61e4be5_RGB_5;
            float2 _Combine_c045c4c659354461848cd6c7d61e4be5_RG_6;
            Unity_Combine_float(_Split_cfe4e3a30c93414694a4d7e49c708985_R_1, _Split_cfe4e3a30c93414694a4d7e49c708985_G_2, 0, 0, _Combine_c045c4c659354461848cd6c7d61e4be5_RGBA_4, _Combine_c045c4c659354461848cd6c7d61e4be5_RGB_5, _Combine_c045c4c659354461848cd6c7d61e4be5_RG_6);
            float4 _Combine_6de15c52675e489b874b27eaf16323df_RGBA_4;
            float3 _Combine_6de15c52675e489b874b27eaf16323df_RGB_5;
            float2 _Combine_6de15c52675e489b874b27eaf16323df_RG_6;
            Unity_Combine_float(_Split_cfe4e3a30c93414694a4d7e49c708985_B_3, _Split_cfe4e3a30c93414694a4d7e49c708985_A_4, 0, 0, _Combine_6de15c52675e489b874b27eaf16323df_RGBA_4, _Combine_6de15c52675e489b874b27eaf16323df_RGB_5, _Combine_6de15c52675e489b874b27eaf16323df_RG_6);
            float _Remap_192e92b0649c4e009e825f27b2499763_Out_3;
            Unity_Remap_float(_Power_fe5fa4a062ff4bac868501be2a7f055c_Out_2, _Combine_c045c4c659354461848cd6c7d61e4be5_RG_6, _Combine_6de15c52675e489b874b27eaf16323df_RG_6, _Remap_192e92b0649c4e009e825f27b2499763_Out_3);
            float _Absolute_d5fceabb74744431b85e0fdda3c8cf5c_Out_1;
            Unity_Absolute_float(_Remap_192e92b0649c4e009e825f27b2499763_Out_3, _Absolute_d5fceabb74744431b85e0fdda3c8cf5c_Out_1);
            float _Smoothstep_5b3511aa53f74a73b9b9614372a6af74_Out_3;
            Unity_Smoothstep_float(_Property_ef386ec2d5f4434a8a5f934ff230322f_Out_0, _Property_147f1a2515e04a399eed34de35cf1107_Out_0, _Absolute_d5fceabb74744431b85e0fdda3c8cf5c_Out_1, _Smoothstep_5b3511aa53f74a73b9b9614372a6af74_Out_3);
            float _Property_8fb0c3dbf4a84403a6068e70183a7ea4_Out_0 = _Base_Speed;
            float _Multiply_774f493cd66541e7ba6553802a499b79_Out_2;
            Unity_Multiply_float_float(IN.TimeParameters.x, _Property_8fb0c3dbf4a84403a6068e70183a7ea4_Out_0, _Multiply_774f493cd66541e7ba6553802a499b79_Out_2);
            float2 _TilingAndOffset_969b7b642fd04ed7b2592123a03eca18_Out_3;
            Unity_TilingAndOffset_float((_RotateAboutAxis_6e7d2784bd02405faeb7bacb567d0731_Out_3.xy), float2 (1, 1), (_Multiply_774f493cd66541e7ba6553802a499b79_Out_2.xx), _TilingAndOffset_969b7b642fd04ed7b2592123a03eca18_Out_3);
            float _Property_e3b00c3a5e804e14a1e03e69aac49211_Out_0 = _Base_Scale;
            float _GradientNoise_04262dfbc1b540b1a9d9b997627f189b_Out_2;
            Unity_GradientNoise_float(_TilingAndOffset_969b7b642fd04ed7b2592123a03eca18_Out_3, _Property_e3b00c3a5e804e14a1e03e69aac49211_Out_0, _GradientNoise_04262dfbc1b540b1a9d9b997627f189b_Out_2);
            float _Property_17938a6d7e2f40dd8d0f1b984a9fbb59_Out_0 = _Base_Strength;
            float _Multiply_0854b1bc83aa4170a68f058b8cb96ff7_Out_2;
            Unity_Multiply_float_float(_GradientNoise_04262dfbc1b540b1a9d9b997627f189b_Out_2, _Property_17938a6d7e2f40dd8d0f1b984a9fbb59_Out_0, _Multiply_0854b1bc83aa4170a68f058b8cb96ff7_Out_2);
            float _Add_f82d9f056cbf456f911125a9574d865f_Out_2;
            Unity_Add_float(_Smoothstep_5b3511aa53f74a73b9b9614372a6af74_Out_3, _Multiply_0854b1bc83aa4170a68f058b8cb96ff7_Out_2, _Add_f82d9f056cbf456f911125a9574d865f_Out_2);
            float _Add_df54866b810e4151a1fde09a51f17b65_Out_2;
            Unity_Add_float(1, _Property_17938a6d7e2f40dd8d0f1b984a9fbb59_Out_0, _Add_df54866b810e4151a1fde09a51f17b65_Out_2);
            float _Divide_b2c87465e89040e4940d7d7f42943c3f_Out_2;
            Unity_Divide_float(_Add_f82d9f056cbf456f911125a9574d865f_Out_2, _Add_df54866b810e4151a1fde09a51f17b65_Out_2, _Divide_b2c87465e89040e4940d7d7f42943c3f_Out_2);
            float3 _Multiply_cc4eb1139ae74d4c85067f5171acc955_Out_2;
            Unity_Multiply_float3_float3(IN.ObjectSpaceNormal, (_Divide_b2c87465e89040e4940d7d7f42943c3f_Out_2.xxx), _Multiply_cc4eb1139ae74d4c85067f5171acc955_Out_2);
            float _Property_611696cf692e4bb19aaf7739c57cdd44_Out_0 = _Noise_Height;
            float3 _Multiply_da4791b114e34eceac3bacbb1043285e_Out_2;
            Unity_Multiply_float3_float3(_Multiply_cc4eb1139ae74d4c85067f5171acc955_Out_2, (_Property_611696cf692e4bb19aaf7739c57cdd44_Out_0.xxx), _Multiply_da4791b114e34eceac3bacbb1043285e_Out_2);
            float3 _Add_1af6468ff1e344348b74bd929f252cbf_Out_2;
            Unity_Add_float3(IN.ObjectSpacePosition, _Multiply_da4791b114e34eceac3bacbb1043285e_Out_2, _Add_1af6468ff1e344348b74bd929f252cbf_Out_2);
            float3 _Add_c7842509b95b4858bfbf1f91fea0a4c3_Out_2;
            Unity_Add_float3(_Multiply_5ca41a1165784fbe980a8c3177fad7e1_Out_2, _Add_1af6468ff1e344348b74bd929f252cbf_Out_2, _Add_c7842509b95b4858bfbf1f91fea0a4c3_Out_2);
            description.Position = _Add_c7842509b95b4858bfbf1f91fea0a4c3_Out_2;
            description.Normal = IN.ObjectSpaceNormal;
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
            float Alpha;
            float AlphaClipThreshold;
        };
        
        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            float _SceneDepth_92d0d826f11444f38ddac1aa18b54491_Out_1;
            Unity_SceneDepth_Eye_float(float4(IN.ScreenPosition.xy / IN.ScreenPosition.w, 0, 0), _SceneDepth_92d0d826f11444f38ddac1aa18b54491_Out_1);
            float4 _ScreenPosition_a43e7cd4d3c742149035c252ba0d4ec9_Out_0 = IN.ScreenPosition;
            float _Split_945e233c5d5644b39c8f24743ae9b880_R_1 = _ScreenPosition_a43e7cd4d3c742149035c252ba0d4ec9_Out_0[0];
            float _Split_945e233c5d5644b39c8f24743ae9b880_G_2 = _ScreenPosition_a43e7cd4d3c742149035c252ba0d4ec9_Out_0[1];
            float _Split_945e233c5d5644b39c8f24743ae9b880_B_3 = _ScreenPosition_a43e7cd4d3c742149035c252ba0d4ec9_Out_0[2];
            float _Split_945e233c5d5644b39c8f24743ae9b880_A_4 = _ScreenPosition_a43e7cd4d3c742149035c252ba0d4ec9_Out_0[3];
            float _Subtract_509aa90668e7408bad7076496f9d5759_Out_2;
            Unity_Subtract_float(_Split_945e233c5d5644b39c8f24743ae9b880_A_4, 1, _Subtract_509aa90668e7408bad7076496f9d5759_Out_2);
            float _Subtract_72c15d8c0496460ca2c6aaf585c41381_Out_2;
            Unity_Subtract_float(_SceneDepth_92d0d826f11444f38ddac1aa18b54491_Out_1, _Subtract_509aa90668e7408bad7076496f9d5759_Out_2, _Subtract_72c15d8c0496460ca2c6aaf585c41381_Out_2);
            float _Property_3a30c5a5cbf24fa6913c8ee537ee5f4b_Out_0 = _Fade_Depth;
            float _Divide_8b2505abc71b4c3f8954d6fb229e0865_Out_2;
            Unity_Divide_float(_Subtract_72c15d8c0496460ca2c6aaf585c41381_Out_2, _Property_3a30c5a5cbf24fa6913c8ee537ee5f4b_Out_0, _Divide_8b2505abc71b4c3f8954d6fb229e0865_Out_2);
            float _Saturate_3c60f55f62d842639e72ca2a20ce74df_Out_1;
            Unity_Saturate_float(_Divide_8b2505abc71b4c3f8954d6fb229e0865_Out_2, _Saturate_3c60f55f62d842639e72ca2a20ce74df_Out_1);
            surface.Alpha = _Saturate_3c60f55f62d842639e72ca2a20ce74df_Out_1;
            surface.AlphaClipThreshold = 0.5;
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
            output.WorldSpaceNormal =                           TransformObjectToWorldNormal(input.normalOS);
            output.ObjectSpaceTangent =                         input.tangentOS.xyz;
            output.ObjectSpacePosition =                        input.positionOS;
            output.WorldSpacePosition =                         TransformObjectToWorld(input.positionOS);
            output.TimeParameters =                             _TimeParameters.xyz;
        
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
        
            
        
        
        
        
        
            output.WorldSpacePosition = input.positionWS;
            output.ScreenPosition = ComputeScreenPos(TransformWorldToHClip(input.positionWS), _ProjectionParams.x);
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
            Name "ShadowCaster"
            Tags
            {
                "LightMode" = "ShadowCaster"
            }
        
        // Render State
        Cull [_Cull]
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
        
        // DotsInstancingOptions: <None>
        // HybridV1InjectedBuiltinProperties: <None>
        
        // Keywords
        #pragma multi_compile _ _CASTING_PUNCTUAL_LIGHT_SHADOW
        #pragma shader_feature_local_fragment _ _ALPHATEST_ON
        // GraphKeywords: <None>
        
        // Defines
        
        #define ATTRIBUTES_NEED_NORMAL
        #define ATTRIBUTES_NEED_TANGENT
        #define VARYINGS_NEED_POSITION_WS
        #define VARYINGS_NEED_NORMAL_WS
        #define FEATURES_GRAPH_VERTEX
        /* WARNING: $splice Could not find named fragment 'PassInstancing' */
        #define SHADERPASS SHADERPASS_SHADOWCASTER
        #define REQUIRE_DEPTH_TEXTURE
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
             float3 positionWS;
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
             float3 WorldSpacePosition;
             float4 ScreenPosition;
        };
        struct VertexDescriptionInputs
        {
             float3 ObjectSpaceNormal;
             float3 WorldSpaceNormal;
             float3 ObjectSpaceTangent;
             float3 ObjectSpacePosition;
             float3 WorldSpacePosition;
             float3 TimeParameters;
        };
        struct PackedVaryings
        {
             float4 positionCS : SV_POSITION;
             float3 interp0 : INTERP0;
             float3 interp1 : INTERP1;
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
        float4 _Rotate_Projection;
        float _Noise_Scale;
        float _Noise_Speed;
        float _Noise_Height;
        float4 _Noise_Remap;
        float4 _Colour_Peak;
        float4 _Colour_Valley;
        float _Noise_Edge_1;
        float _Noise_Edge_2;
        float _Noise_Power;
        float _Base_Scale;
        float _Base_Speed;
        float _Base_Strength;
        float _Emission;
        float _Curvature_Radius;
        float _Fresnel_Power;
        float _Fresnel_opacity;
        float _Fade_Depth;
        CBUFFER_END
        
        // Object and Global properties
        
        // Graph Includes
        // GraphIncludes: <None>
        
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
        
        void Unity_Distance_float3(float3 A, float3 B, out float Out)
        {
            Out = distance(A, B);
        }
        
        void Unity_Divide_float(float A, float B, out float Out)
        {
            Out = A / B;
        }
        
        void Unity_Power_float(float A, float B, out float Out)
        {
            Out = pow(A, B);
        }
        
        void Unity_Multiply_float3_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A * B;
        }
        
        void Unity_Rotate_About_Axis_Degrees_float(float3 In, float3 Axis, float Rotation, out float3 Out)
        {
            Rotation = radians(Rotation);
        
            float s = sin(Rotation);
            float c = cos(Rotation);
            float one_minus_c = 1.0 - c;
        
            Axis = normalize(Axis);
        
            float3x3 rot_mat = { one_minus_c * Axis.x * Axis.x + c,            one_minus_c * Axis.x * Axis.y - Axis.z * s,     one_minus_c * Axis.z * Axis.x + Axis.y * s,
                                      one_minus_c * Axis.x * Axis.y + Axis.z * s,   one_minus_c * Axis.y * Axis.y + c,              one_minus_c * Axis.y * Axis.z - Axis.x * s,
                                      one_minus_c * Axis.z * Axis.x - Axis.y * s,   one_minus_c * Axis.y * Axis.z + Axis.x * s,     one_minus_c * Axis.z * Axis.z + c
                                    };
        
            Out = mul(rot_mat,  In);
        }
        
        void Unity_Multiply_float_float(float A, float B, out float Out)
        {
            Out = A * B;
        }
        
        void Unity_TilingAndOffset_float(float2 UV, float2 Tiling, float2 Offset, out float2 Out)
        {
            Out = UV * Tiling + Offset;
        }
        
        
        float2 Unity_GradientNoise_Dir_float(float2 p)
        {
            // Permutation and hashing used in webgl-nosie goo.gl/pX7HtC
            p = p % 289;
            // need full precision, otherwise half overflows when p > 1
            float x = float(34 * p.x + 1) * p.x % 289 + p.y;
            x = (34 * x + 1) * x % 289;
            x = frac(x / 41) * 2 - 1;
            return normalize(float2(x - floor(x + 0.5), abs(x) - 0.5));
        }
        
        void Unity_GradientNoise_float(float2 UV, float Scale, out float Out)
        {
            float2 p = UV * Scale;
            float2 ip = floor(p);
            float2 fp = frac(p);
            float d00 = dot(Unity_GradientNoise_Dir_float(ip), fp);
            float d01 = dot(Unity_GradientNoise_Dir_float(ip + float2(0, 1)), fp - float2(0, 1));
            float d10 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 0)), fp - float2(1, 0));
            float d11 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 1)), fp - float2(1, 1));
            fp = fp * fp * fp * (fp * (fp * 6 - 15) + 10);
            Out = lerp(lerp(d00, d01, fp.y), lerp(d10, d11, fp.y), fp.x) + 0.5;
        }
        
        void Unity_Add_float(float A, float B, out float Out)
        {
            Out = A + B;
        }
        
        void Unity_Saturate_float(float In, out float Out)
        {
            Out = saturate(In);
        }
        
        void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
        {
            RGBA = float4(R, G, B, A);
            RGB = float3(R, G, B);
            RG = float2(R, G);
        }
        
        void Unity_Remap_float(float In, float2 InMinMax, float2 OutMinMax, out float Out)
        {
            Out = OutMinMax.x + (In - InMinMax.x) * (OutMinMax.y - OutMinMax.x) / (InMinMax.y - InMinMax.x);
        }
        
        void Unity_Absolute_float(float In, out float Out)
        {
            Out = abs(In);
        }
        
        void Unity_Smoothstep_float(float Edge1, float Edge2, float In, out float Out)
        {
            Out = smoothstep(Edge1, Edge2, In);
        }
        
        void Unity_Add_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A + B;
        }
        
        void Unity_SceneDepth_Eye_float(float4 UV, out float Out)
        {
            if (unity_OrthoParams.w == 1.0)
            {
                Out = LinearEyeDepth(ComputeWorldSpacePosition(UV.xy, SHADERGRAPH_SAMPLE_SCENE_DEPTH(UV.xy), UNITY_MATRIX_I_VP), UNITY_MATRIX_V);
            }
            else
            {
                Out = LinearEyeDepth(SHADERGRAPH_SAMPLE_SCENE_DEPTH(UV.xy), _ZBufferParams);
            }
        }
        
        void Unity_Subtract_float(float A, float B, out float Out)
        {
            Out = A - B;
        }
        
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
            float _Distance_c01ba79505ea4a8891c3da5756fe9e5a_Out_2;
            Unity_Distance_float3(SHADERGRAPH_OBJECT_POSITION, IN.WorldSpacePosition, _Distance_c01ba79505ea4a8891c3da5756fe9e5a_Out_2);
            float _Property_d1be4d71eb4e4aae9337b9b402f45d63_Out_0 = _Curvature_Radius;
            float _Divide_03646e2359744ec38397913fc1d7c270_Out_2;
            Unity_Divide_float(_Distance_c01ba79505ea4a8891c3da5756fe9e5a_Out_2, _Property_d1be4d71eb4e4aae9337b9b402f45d63_Out_0, _Divide_03646e2359744ec38397913fc1d7c270_Out_2);
            float _Power_07f0eac51f1244fbb5c4966f586ac4dc_Out_2;
            Unity_Power_float(_Divide_03646e2359744ec38397913fc1d7c270_Out_2, 3, _Power_07f0eac51f1244fbb5c4966f586ac4dc_Out_2);
            float3 _Multiply_5ca41a1165784fbe980a8c3177fad7e1_Out_2;
            Unity_Multiply_float3_float3(IN.WorldSpaceNormal, (_Power_07f0eac51f1244fbb5c4966f586ac4dc_Out_2.xxx), _Multiply_5ca41a1165784fbe980a8c3177fad7e1_Out_2);
            float _Property_ef386ec2d5f4434a8a5f934ff230322f_Out_0 = _Noise_Edge_1;
            float _Property_147f1a2515e04a399eed34de35cf1107_Out_0 = _Noise_Edge_2;
            float4 _Property_b84368a6bae8433994c8bf5d771c01f4_Out_0 = _Rotate_Projection;
            float _Split_31db8d949ab24fd1b5ded76e6ecb6868_R_1 = _Property_b84368a6bae8433994c8bf5d771c01f4_Out_0[0];
            float _Split_31db8d949ab24fd1b5ded76e6ecb6868_G_2 = _Property_b84368a6bae8433994c8bf5d771c01f4_Out_0[1];
            float _Split_31db8d949ab24fd1b5ded76e6ecb6868_B_3 = _Property_b84368a6bae8433994c8bf5d771c01f4_Out_0[2];
            float _Split_31db8d949ab24fd1b5ded76e6ecb6868_A_4 = _Property_b84368a6bae8433994c8bf5d771c01f4_Out_0[3];
            float3 _RotateAboutAxis_6e7d2784bd02405faeb7bacb567d0731_Out_3;
            Unity_Rotate_About_Axis_Degrees_float(IN.WorldSpacePosition, (_Property_b84368a6bae8433994c8bf5d771c01f4_Out_0.xyz), _Split_31db8d949ab24fd1b5ded76e6ecb6868_A_4, _RotateAboutAxis_6e7d2784bd02405faeb7bacb567d0731_Out_3);
            float _Property_1b5acb9aca4b4c1ca8150917cb29e38d_Out_0 = _Noise_Speed;
            float _Multiply_a1f01de168c5412e848fa5a9a4f633d8_Out_2;
            Unity_Multiply_float_float(IN.TimeParameters.x, _Property_1b5acb9aca4b4c1ca8150917cb29e38d_Out_0, _Multiply_a1f01de168c5412e848fa5a9a4f633d8_Out_2);
            float2 _TilingAndOffset_3a22eccd71474e639594fce72cde2d02_Out_3;
            Unity_TilingAndOffset_float((_RotateAboutAxis_6e7d2784bd02405faeb7bacb567d0731_Out_3.xy), float2 (1, 1), (_Multiply_a1f01de168c5412e848fa5a9a4f633d8_Out_2.xx), _TilingAndOffset_3a22eccd71474e639594fce72cde2d02_Out_3);
            float _Property_e34f89cb08684afb94f0ac41ba675b11_Out_0 = _Noise_Scale;
            float _GradientNoise_71dea3d8ca7f493a820838ec4624d407_Out_2;
            Unity_GradientNoise_float(_TilingAndOffset_3a22eccd71474e639594fce72cde2d02_Out_3, _Property_e34f89cb08684afb94f0ac41ba675b11_Out_0, _GradientNoise_71dea3d8ca7f493a820838ec4624d407_Out_2);
            float2 _TilingAndOffset_b402f80311694eb4b5a4c3d07e71c615_Out_3;
            Unity_TilingAndOffset_float((_RotateAboutAxis_6e7d2784bd02405faeb7bacb567d0731_Out_3.xy), float2 (1, 1), float2 (0, 0), _TilingAndOffset_b402f80311694eb4b5a4c3d07e71c615_Out_3);
            float _GradientNoise_7cfc31faa781410090b11ae418c9e103_Out_2;
            Unity_GradientNoise_float(_TilingAndOffset_b402f80311694eb4b5a4c3d07e71c615_Out_3, _Property_e34f89cb08684afb94f0ac41ba675b11_Out_0, _GradientNoise_7cfc31faa781410090b11ae418c9e103_Out_2);
            float _Add_8d3a946d8f7848c0a6a4ee9e280c511d_Out_2;
            Unity_Add_float(_GradientNoise_71dea3d8ca7f493a820838ec4624d407_Out_2, _GradientNoise_7cfc31faa781410090b11ae418c9e103_Out_2, _Add_8d3a946d8f7848c0a6a4ee9e280c511d_Out_2);
            float _Divide_883697060c4b42898d76bc5325a5b568_Out_2;
            Unity_Divide_float(_Add_8d3a946d8f7848c0a6a4ee9e280c511d_Out_2, 2, _Divide_883697060c4b42898d76bc5325a5b568_Out_2);
            float _Saturate_c96331ef3b2642d39a446bce3d43f560_Out_1;
            Unity_Saturate_float(_Divide_883697060c4b42898d76bc5325a5b568_Out_2, _Saturate_c96331ef3b2642d39a446bce3d43f560_Out_1);
            float _Property_a5e2c659762f49e2826023553b233885_Out_0 = _Noise_Power;
            float _Power_fe5fa4a062ff4bac868501be2a7f055c_Out_2;
            Unity_Power_float(_Saturate_c96331ef3b2642d39a446bce3d43f560_Out_1, _Property_a5e2c659762f49e2826023553b233885_Out_0, _Power_fe5fa4a062ff4bac868501be2a7f055c_Out_2);
            float4 _Property_f466dd4679cc4567b14cecb45e839124_Out_0 = _Noise_Remap;
            float _Split_cfe4e3a30c93414694a4d7e49c708985_R_1 = _Property_f466dd4679cc4567b14cecb45e839124_Out_0[0];
            float _Split_cfe4e3a30c93414694a4d7e49c708985_G_2 = _Property_f466dd4679cc4567b14cecb45e839124_Out_0[1];
            float _Split_cfe4e3a30c93414694a4d7e49c708985_B_3 = _Property_f466dd4679cc4567b14cecb45e839124_Out_0[2];
            float _Split_cfe4e3a30c93414694a4d7e49c708985_A_4 = _Property_f466dd4679cc4567b14cecb45e839124_Out_0[3];
            float4 _Combine_c045c4c659354461848cd6c7d61e4be5_RGBA_4;
            float3 _Combine_c045c4c659354461848cd6c7d61e4be5_RGB_5;
            float2 _Combine_c045c4c659354461848cd6c7d61e4be5_RG_6;
            Unity_Combine_float(_Split_cfe4e3a30c93414694a4d7e49c708985_R_1, _Split_cfe4e3a30c93414694a4d7e49c708985_G_2, 0, 0, _Combine_c045c4c659354461848cd6c7d61e4be5_RGBA_4, _Combine_c045c4c659354461848cd6c7d61e4be5_RGB_5, _Combine_c045c4c659354461848cd6c7d61e4be5_RG_6);
            float4 _Combine_6de15c52675e489b874b27eaf16323df_RGBA_4;
            float3 _Combine_6de15c52675e489b874b27eaf16323df_RGB_5;
            float2 _Combine_6de15c52675e489b874b27eaf16323df_RG_6;
            Unity_Combine_float(_Split_cfe4e3a30c93414694a4d7e49c708985_B_3, _Split_cfe4e3a30c93414694a4d7e49c708985_A_4, 0, 0, _Combine_6de15c52675e489b874b27eaf16323df_RGBA_4, _Combine_6de15c52675e489b874b27eaf16323df_RGB_5, _Combine_6de15c52675e489b874b27eaf16323df_RG_6);
            float _Remap_192e92b0649c4e009e825f27b2499763_Out_3;
            Unity_Remap_float(_Power_fe5fa4a062ff4bac868501be2a7f055c_Out_2, _Combine_c045c4c659354461848cd6c7d61e4be5_RG_6, _Combine_6de15c52675e489b874b27eaf16323df_RG_6, _Remap_192e92b0649c4e009e825f27b2499763_Out_3);
            float _Absolute_d5fceabb74744431b85e0fdda3c8cf5c_Out_1;
            Unity_Absolute_float(_Remap_192e92b0649c4e009e825f27b2499763_Out_3, _Absolute_d5fceabb74744431b85e0fdda3c8cf5c_Out_1);
            float _Smoothstep_5b3511aa53f74a73b9b9614372a6af74_Out_3;
            Unity_Smoothstep_float(_Property_ef386ec2d5f4434a8a5f934ff230322f_Out_0, _Property_147f1a2515e04a399eed34de35cf1107_Out_0, _Absolute_d5fceabb74744431b85e0fdda3c8cf5c_Out_1, _Smoothstep_5b3511aa53f74a73b9b9614372a6af74_Out_3);
            float _Property_8fb0c3dbf4a84403a6068e70183a7ea4_Out_0 = _Base_Speed;
            float _Multiply_774f493cd66541e7ba6553802a499b79_Out_2;
            Unity_Multiply_float_float(IN.TimeParameters.x, _Property_8fb0c3dbf4a84403a6068e70183a7ea4_Out_0, _Multiply_774f493cd66541e7ba6553802a499b79_Out_2);
            float2 _TilingAndOffset_969b7b642fd04ed7b2592123a03eca18_Out_3;
            Unity_TilingAndOffset_float((_RotateAboutAxis_6e7d2784bd02405faeb7bacb567d0731_Out_3.xy), float2 (1, 1), (_Multiply_774f493cd66541e7ba6553802a499b79_Out_2.xx), _TilingAndOffset_969b7b642fd04ed7b2592123a03eca18_Out_3);
            float _Property_e3b00c3a5e804e14a1e03e69aac49211_Out_0 = _Base_Scale;
            float _GradientNoise_04262dfbc1b540b1a9d9b997627f189b_Out_2;
            Unity_GradientNoise_float(_TilingAndOffset_969b7b642fd04ed7b2592123a03eca18_Out_3, _Property_e3b00c3a5e804e14a1e03e69aac49211_Out_0, _GradientNoise_04262dfbc1b540b1a9d9b997627f189b_Out_2);
            float _Property_17938a6d7e2f40dd8d0f1b984a9fbb59_Out_0 = _Base_Strength;
            float _Multiply_0854b1bc83aa4170a68f058b8cb96ff7_Out_2;
            Unity_Multiply_float_float(_GradientNoise_04262dfbc1b540b1a9d9b997627f189b_Out_2, _Property_17938a6d7e2f40dd8d0f1b984a9fbb59_Out_0, _Multiply_0854b1bc83aa4170a68f058b8cb96ff7_Out_2);
            float _Add_f82d9f056cbf456f911125a9574d865f_Out_2;
            Unity_Add_float(_Smoothstep_5b3511aa53f74a73b9b9614372a6af74_Out_3, _Multiply_0854b1bc83aa4170a68f058b8cb96ff7_Out_2, _Add_f82d9f056cbf456f911125a9574d865f_Out_2);
            float _Add_df54866b810e4151a1fde09a51f17b65_Out_2;
            Unity_Add_float(1, _Property_17938a6d7e2f40dd8d0f1b984a9fbb59_Out_0, _Add_df54866b810e4151a1fde09a51f17b65_Out_2);
            float _Divide_b2c87465e89040e4940d7d7f42943c3f_Out_2;
            Unity_Divide_float(_Add_f82d9f056cbf456f911125a9574d865f_Out_2, _Add_df54866b810e4151a1fde09a51f17b65_Out_2, _Divide_b2c87465e89040e4940d7d7f42943c3f_Out_2);
            float3 _Multiply_cc4eb1139ae74d4c85067f5171acc955_Out_2;
            Unity_Multiply_float3_float3(IN.ObjectSpaceNormal, (_Divide_b2c87465e89040e4940d7d7f42943c3f_Out_2.xxx), _Multiply_cc4eb1139ae74d4c85067f5171acc955_Out_2);
            float _Property_611696cf692e4bb19aaf7739c57cdd44_Out_0 = _Noise_Height;
            float3 _Multiply_da4791b114e34eceac3bacbb1043285e_Out_2;
            Unity_Multiply_float3_float3(_Multiply_cc4eb1139ae74d4c85067f5171acc955_Out_2, (_Property_611696cf692e4bb19aaf7739c57cdd44_Out_0.xxx), _Multiply_da4791b114e34eceac3bacbb1043285e_Out_2);
            float3 _Add_1af6468ff1e344348b74bd929f252cbf_Out_2;
            Unity_Add_float3(IN.ObjectSpacePosition, _Multiply_da4791b114e34eceac3bacbb1043285e_Out_2, _Add_1af6468ff1e344348b74bd929f252cbf_Out_2);
            float3 _Add_c7842509b95b4858bfbf1f91fea0a4c3_Out_2;
            Unity_Add_float3(_Multiply_5ca41a1165784fbe980a8c3177fad7e1_Out_2, _Add_1af6468ff1e344348b74bd929f252cbf_Out_2, _Add_c7842509b95b4858bfbf1f91fea0a4c3_Out_2);
            description.Position = _Add_c7842509b95b4858bfbf1f91fea0a4c3_Out_2;
            description.Normal = IN.ObjectSpaceNormal;
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
            float Alpha;
            float AlphaClipThreshold;
        };
        
        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            float _SceneDepth_92d0d826f11444f38ddac1aa18b54491_Out_1;
            Unity_SceneDepth_Eye_float(float4(IN.ScreenPosition.xy / IN.ScreenPosition.w, 0, 0), _SceneDepth_92d0d826f11444f38ddac1aa18b54491_Out_1);
            float4 _ScreenPosition_a43e7cd4d3c742149035c252ba0d4ec9_Out_0 = IN.ScreenPosition;
            float _Split_945e233c5d5644b39c8f24743ae9b880_R_1 = _ScreenPosition_a43e7cd4d3c742149035c252ba0d4ec9_Out_0[0];
            float _Split_945e233c5d5644b39c8f24743ae9b880_G_2 = _ScreenPosition_a43e7cd4d3c742149035c252ba0d4ec9_Out_0[1];
            float _Split_945e233c5d5644b39c8f24743ae9b880_B_3 = _ScreenPosition_a43e7cd4d3c742149035c252ba0d4ec9_Out_0[2];
            float _Split_945e233c5d5644b39c8f24743ae9b880_A_4 = _ScreenPosition_a43e7cd4d3c742149035c252ba0d4ec9_Out_0[3];
            float _Subtract_509aa90668e7408bad7076496f9d5759_Out_2;
            Unity_Subtract_float(_Split_945e233c5d5644b39c8f24743ae9b880_A_4, 1, _Subtract_509aa90668e7408bad7076496f9d5759_Out_2);
            float _Subtract_72c15d8c0496460ca2c6aaf585c41381_Out_2;
            Unity_Subtract_float(_SceneDepth_92d0d826f11444f38ddac1aa18b54491_Out_1, _Subtract_509aa90668e7408bad7076496f9d5759_Out_2, _Subtract_72c15d8c0496460ca2c6aaf585c41381_Out_2);
            float _Property_3a30c5a5cbf24fa6913c8ee537ee5f4b_Out_0 = _Fade_Depth;
            float _Divide_8b2505abc71b4c3f8954d6fb229e0865_Out_2;
            Unity_Divide_float(_Subtract_72c15d8c0496460ca2c6aaf585c41381_Out_2, _Property_3a30c5a5cbf24fa6913c8ee537ee5f4b_Out_0, _Divide_8b2505abc71b4c3f8954d6fb229e0865_Out_2);
            float _Saturate_3c60f55f62d842639e72ca2a20ce74df_Out_1;
            Unity_Saturate_float(_Divide_8b2505abc71b4c3f8954d6fb229e0865_Out_2, _Saturate_3c60f55f62d842639e72ca2a20ce74df_Out_1);
            surface.Alpha = _Saturate_3c60f55f62d842639e72ca2a20ce74df_Out_1;
            surface.AlphaClipThreshold = 0.5;
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
            output.WorldSpaceNormal =                           TransformObjectToWorldNormal(input.normalOS);
            output.ObjectSpaceTangent =                         input.tangentOS.xyz;
            output.ObjectSpacePosition =                        input.positionOS;
            output.WorldSpacePosition =                         TransformObjectToWorld(input.positionOS);
            output.TimeParameters =                             _TimeParameters.xyz;
        
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
        
            
        
        
        
        
        
            output.WorldSpacePosition = input.positionWS;
            output.ScreenPosition = ComputeScreenPos(TransformWorldToHClip(input.positionWS), _ProjectionParams.x);
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
        #pragma target 2.0
        #pragma only_renderers gles gles3 glcore d3d11
        #pragma multi_compile_instancing
        #pragma vertex vert
        #pragma fragment frag
        
        // DotsInstancingOptions: <None>
        // HybridV1InjectedBuiltinProperties: <None>
        
        // Keywords
        #pragma shader_feature_local_fragment _ _ALPHATEST_ON
        // GraphKeywords: <None>
        
        // Defines
        
        #define ATTRIBUTES_NEED_NORMAL
        #define ATTRIBUTES_NEED_TANGENT
        #define VARYINGS_NEED_POSITION_WS
        #define FEATURES_GRAPH_VERTEX
        /* WARNING: $splice Could not find named fragment 'PassInstancing' */
        #define SHADERPASS SHADERPASS_DEPTHONLY
        #define SCENESELECTIONPASS 1
        #define ALPHA_CLIP_THRESHOLD 1
        #define REQUIRE_DEPTH_TEXTURE
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
             float3 positionWS;
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
             float3 WorldSpacePosition;
             float4 ScreenPosition;
        };
        struct VertexDescriptionInputs
        {
             float3 ObjectSpaceNormal;
             float3 WorldSpaceNormal;
             float3 ObjectSpaceTangent;
             float3 ObjectSpacePosition;
             float3 WorldSpacePosition;
             float3 TimeParameters;
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
            output.interp0.xyz =  input.positionWS;
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
        float4 _Rotate_Projection;
        float _Noise_Scale;
        float _Noise_Speed;
        float _Noise_Height;
        float4 _Noise_Remap;
        float4 _Colour_Peak;
        float4 _Colour_Valley;
        float _Noise_Edge_1;
        float _Noise_Edge_2;
        float _Noise_Power;
        float _Base_Scale;
        float _Base_Speed;
        float _Base_Strength;
        float _Emission;
        float _Curvature_Radius;
        float _Fresnel_Power;
        float _Fresnel_opacity;
        float _Fade_Depth;
        CBUFFER_END
        
        // Object and Global properties
        
        // Graph Includes
        // GraphIncludes: <None>
        
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
        
        void Unity_Distance_float3(float3 A, float3 B, out float Out)
        {
            Out = distance(A, B);
        }
        
        void Unity_Divide_float(float A, float B, out float Out)
        {
            Out = A / B;
        }
        
        void Unity_Power_float(float A, float B, out float Out)
        {
            Out = pow(A, B);
        }
        
        void Unity_Multiply_float3_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A * B;
        }
        
        void Unity_Rotate_About_Axis_Degrees_float(float3 In, float3 Axis, float Rotation, out float3 Out)
        {
            Rotation = radians(Rotation);
        
            float s = sin(Rotation);
            float c = cos(Rotation);
            float one_minus_c = 1.0 - c;
        
            Axis = normalize(Axis);
        
            float3x3 rot_mat = { one_minus_c * Axis.x * Axis.x + c,            one_minus_c * Axis.x * Axis.y - Axis.z * s,     one_minus_c * Axis.z * Axis.x + Axis.y * s,
                                      one_minus_c * Axis.x * Axis.y + Axis.z * s,   one_minus_c * Axis.y * Axis.y + c,              one_minus_c * Axis.y * Axis.z - Axis.x * s,
                                      one_minus_c * Axis.z * Axis.x - Axis.y * s,   one_minus_c * Axis.y * Axis.z + Axis.x * s,     one_minus_c * Axis.z * Axis.z + c
                                    };
        
            Out = mul(rot_mat,  In);
        }
        
        void Unity_Multiply_float_float(float A, float B, out float Out)
        {
            Out = A * B;
        }
        
        void Unity_TilingAndOffset_float(float2 UV, float2 Tiling, float2 Offset, out float2 Out)
        {
            Out = UV * Tiling + Offset;
        }
        
        
        float2 Unity_GradientNoise_Dir_float(float2 p)
        {
            // Permutation and hashing used in webgl-nosie goo.gl/pX7HtC
            p = p % 289;
            // need full precision, otherwise half overflows when p > 1
            float x = float(34 * p.x + 1) * p.x % 289 + p.y;
            x = (34 * x + 1) * x % 289;
            x = frac(x / 41) * 2 - 1;
            return normalize(float2(x - floor(x + 0.5), abs(x) - 0.5));
        }
        
        void Unity_GradientNoise_float(float2 UV, float Scale, out float Out)
        {
            float2 p = UV * Scale;
            float2 ip = floor(p);
            float2 fp = frac(p);
            float d00 = dot(Unity_GradientNoise_Dir_float(ip), fp);
            float d01 = dot(Unity_GradientNoise_Dir_float(ip + float2(0, 1)), fp - float2(0, 1));
            float d10 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 0)), fp - float2(1, 0));
            float d11 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 1)), fp - float2(1, 1));
            fp = fp * fp * fp * (fp * (fp * 6 - 15) + 10);
            Out = lerp(lerp(d00, d01, fp.y), lerp(d10, d11, fp.y), fp.x) + 0.5;
        }
        
        void Unity_Add_float(float A, float B, out float Out)
        {
            Out = A + B;
        }
        
        void Unity_Saturate_float(float In, out float Out)
        {
            Out = saturate(In);
        }
        
        void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
        {
            RGBA = float4(R, G, B, A);
            RGB = float3(R, G, B);
            RG = float2(R, G);
        }
        
        void Unity_Remap_float(float In, float2 InMinMax, float2 OutMinMax, out float Out)
        {
            Out = OutMinMax.x + (In - InMinMax.x) * (OutMinMax.y - OutMinMax.x) / (InMinMax.y - InMinMax.x);
        }
        
        void Unity_Absolute_float(float In, out float Out)
        {
            Out = abs(In);
        }
        
        void Unity_Smoothstep_float(float Edge1, float Edge2, float In, out float Out)
        {
            Out = smoothstep(Edge1, Edge2, In);
        }
        
        void Unity_Add_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A + B;
        }
        
        void Unity_SceneDepth_Eye_float(float4 UV, out float Out)
        {
            if (unity_OrthoParams.w == 1.0)
            {
                Out = LinearEyeDepth(ComputeWorldSpacePosition(UV.xy, SHADERGRAPH_SAMPLE_SCENE_DEPTH(UV.xy), UNITY_MATRIX_I_VP), UNITY_MATRIX_V);
            }
            else
            {
                Out = LinearEyeDepth(SHADERGRAPH_SAMPLE_SCENE_DEPTH(UV.xy), _ZBufferParams);
            }
        }
        
        void Unity_Subtract_float(float A, float B, out float Out)
        {
            Out = A - B;
        }
        
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
            float _Distance_c01ba79505ea4a8891c3da5756fe9e5a_Out_2;
            Unity_Distance_float3(SHADERGRAPH_OBJECT_POSITION, IN.WorldSpacePosition, _Distance_c01ba79505ea4a8891c3da5756fe9e5a_Out_2);
            float _Property_d1be4d71eb4e4aae9337b9b402f45d63_Out_0 = _Curvature_Radius;
            float _Divide_03646e2359744ec38397913fc1d7c270_Out_2;
            Unity_Divide_float(_Distance_c01ba79505ea4a8891c3da5756fe9e5a_Out_2, _Property_d1be4d71eb4e4aae9337b9b402f45d63_Out_0, _Divide_03646e2359744ec38397913fc1d7c270_Out_2);
            float _Power_07f0eac51f1244fbb5c4966f586ac4dc_Out_2;
            Unity_Power_float(_Divide_03646e2359744ec38397913fc1d7c270_Out_2, 3, _Power_07f0eac51f1244fbb5c4966f586ac4dc_Out_2);
            float3 _Multiply_5ca41a1165784fbe980a8c3177fad7e1_Out_2;
            Unity_Multiply_float3_float3(IN.WorldSpaceNormal, (_Power_07f0eac51f1244fbb5c4966f586ac4dc_Out_2.xxx), _Multiply_5ca41a1165784fbe980a8c3177fad7e1_Out_2);
            float _Property_ef386ec2d5f4434a8a5f934ff230322f_Out_0 = _Noise_Edge_1;
            float _Property_147f1a2515e04a399eed34de35cf1107_Out_0 = _Noise_Edge_2;
            float4 _Property_b84368a6bae8433994c8bf5d771c01f4_Out_0 = _Rotate_Projection;
            float _Split_31db8d949ab24fd1b5ded76e6ecb6868_R_1 = _Property_b84368a6bae8433994c8bf5d771c01f4_Out_0[0];
            float _Split_31db8d949ab24fd1b5ded76e6ecb6868_G_2 = _Property_b84368a6bae8433994c8bf5d771c01f4_Out_0[1];
            float _Split_31db8d949ab24fd1b5ded76e6ecb6868_B_3 = _Property_b84368a6bae8433994c8bf5d771c01f4_Out_0[2];
            float _Split_31db8d949ab24fd1b5ded76e6ecb6868_A_4 = _Property_b84368a6bae8433994c8bf5d771c01f4_Out_0[3];
            float3 _RotateAboutAxis_6e7d2784bd02405faeb7bacb567d0731_Out_3;
            Unity_Rotate_About_Axis_Degrees_float(IN.WorldSpacePosition, (_Property_b84368a6bae8433994c8bf5d771c01f4_Out_0.xyz), _Split_31db8d949ab24fd1b5ded76e6ecb6868_A_4, _RotateAboutAxis_6e7d2784bd02405faeb7bacb567d0731_Out_3);
            float _Property_1b5acb9aca4b4c1ca8150917cb29e38d_Out_0 = _Noise_Speed;
            float _Multiply_a1f01de168c5412e848fa5a9a4f633d8_Out_2;
            Unity_Multiply_float_float(IN.TimeParameters.x, _Property_1b5acb9aca4b4c1ca8150917cb29e38d_Out_0, _Multiply_a1f01de168c5412e848fa5a9a4f633d8_Out_2);
            float2 _TilingAndOffset_3a22eccd71474e639594fce72cde2d02_Out_3;
            Unity_TilingAndOffset_float((_RotateAboutAxis_6e7d2784bd02405faeb7bacb567d0731_Out_3.xy), float2 (1, 1), (_Multiply_a1f01de168c5412e848fa5a9a4f633d8_Out_2.xx), _TilingAndOffset_3a22eccd71474e639594fce72cde2d02_Out_3);
            float _Property_e34f89cb08684afb94f0ac41ba675b11_Out_0 = _Noise_Scale;
            float _GradientNoise_71dea3d8ca7f493a820838ec4624d407_Out_2;
            Unity_GradientNoise_float(_TilingAndOffset_3a22eccd71474e639594fce72cde2d02_Out_3, _Property_e34f89cb08684afb94f0ac41ba675b11_Out_0, _GradientNoise_71dea3d8ca7f493a820838ec4624d407_Out_2);
            float2 _TilingAndOffset_b402f80311694eb4b5a4c3d07e71c615_Out_3;
            Unity_TilingAndOffset_float((_RotateAboutAxis_6e7d2784bd02405faeb7bacb567d0731_Out_3.xy), float2 (1, 1), float2 (0, 0), _TilingAndOffset_b402f80311694eb4b5a4c3d07e71c615_Out_3);
            float _GradientNoise_7cfc31faa781410090b11ae418c9e103_Out_2;
            Unity_GradientNoise_float(_TilingAndOffset_b402f80311694eb4b5a4c3d07e71c615_Out_3, _Property_e34f89cb08684afb94f0ac41ba675b11_Out_0, _GradientNoise_7cfc31faa781410090b11ae418c9e103_Out_2);
            float _Add_8d3a946d8f7848c0a6a4ee9e280c511d_Out_2;
            Unity_Add_float(_GradientNoise_71dea3d8ca7f493a820838ec4624d407_Out_2, _GradientNoise_7cfc31faa781410090b11ae418c9e103_Out_2, _Add_8d3a946d8f7848c0a6a4ee9e280c511d_Out_2);
            float _Divide_883697060c4b42898d76bc5325a5b568_Out_2;
            Unity_Divide_float(_Add_8d3a946d8f7848c0a6a4ee9e280c511d_Out_2, 2, _Divide_883697060c4b42898d76bc5325a5b568_Out_2);
            float _Saturate_c96331ef3b2642d39a446bce3d43f560_Out_1;
            Unity_Saturate_float(_Divide_883697060c4b42898d76bc5325a5b568_Out_2, _Saturate_c96331ef3b2642d39a446bce3d43f560_Out_1);
            float _Property_a5e2c659762f49e2826023553b233885_Out_0 = _Noise_Power;
            float _Power_fe5fa4a062ff4bac868501be2a7f055c_Out_2;
            Unity_Power_float(_Saturate_c96331ef3b2642d39a446bce3d43f560_Out_1, _Property_a5e2c659762f49e2826023553b233885_Out_0, _Power_fe5fa4a062ff4bac868501be2a7f055c_Out_2);
            float4 _Property_f466dd4679cc4567b14cecb45e839124_Out_0 = _Noise_Remap;
            float _Split_cfe4e3a30c93414694a4d7e49c708985_R_1 = _Property_f466dd4679cc4567b14cecb45e839124_Out_0[0];
            float _Split_cfe4e3a30c93414694a4d7e49c708985_G_2 = _Property_f466dd4679cc4567b14cecb45e839124_Out_0[1];
            float _Split_cfe4e3a30c93414694a4d7e49c708985_B_3 = _Property_f466dd4679cc4567b14cecb45e839124_Out_0[2];
            float _Split_cfe4e3a30c93414694a4d7e49c708985_A_4 = _Property_f466dd4679cc4567b14cecb45e839124_Out_0[3];
            float4 _Combine_c045c4c659354461848cd6c7d61e4be5_RGBA_4;
            float3 _Combine_c045c4c659354461848cd6c7d61e4be5_RGB_5;
            float2 _Combine_c045c4c659354461848cd6c7d61e4be5_RG_6;
            Unity_Combine_float(_Split_cfe4e3a30c93414694a4d7e49c708985_R_1, _Split_cfe4e3a30c93414694a4d7e49c708985_G_2, 0, 0, _Combine_c045c4c659354461848cd6c7d61e4be5_RGBA_4, _Combine_c045c4c659354461848cd6c7d61e4be5_RGB_5, _Combine_c045c4c659354461848cd6c7d61e4be5_RG_6);
            float4 _Combine_6de15c52675e489b874b27eaf16323df_RGBA_4;
            float3 _Combine_6de15c52675e489b874b27eaf16323df_RGB_5;
            float2 _Combine_6de15c52675e489b874b27eaf16323df_RG_6;
            Unity_Combine_float(_Split_cfe4e3a30c93414694a4d7e49c708985_B_3, _Split_cfe4e3a30c93414694a4d7e49c708985_A_4, 0, 0, _Combine_6de15c52675e489b874b27eaf16323df_RGBA_4, _Combine_6de15c52675e489b874b27eaf16323df_RGB_5, _Combine_6de15c52675e489b874b27eaf16323df_RG_6);
            float _Remap_192e92b0649c4e009e825f27b2499763_Out_3;
            Unity_Remap_float(_Power_fe5fa4a062ff4bac868501be2a7f055c_Out_2, _Combine_c045c4c659354461848cd6c7d61e4be5_RG_6, _Combine_6de15c52675e489b874b27eaf16323df_RG_6, _Remap_192e92b0649c4e009e825f27b2499763_Out_3);
            float _Absolute_d5fceabb74744431b85e0fdda3c8cf5c_Out_1;
            Unity_Absolute_float(_Remap_192e92b0649c4e009e825f27b2499763_Out_3, _Absolute_d5fceabb74744431b85e0fdda3c8cf5c_Out_1);
            float _Smoothstep_5b3511aa53f74a73b9b9614372a6af74_Out_3;
            Unity_Smoothstep_float(_Property_ef386ec2d5f4434a8a5f934ff230322f_Out_0, _Property_147f1a2515e04a399eed34de35cf1107_Out_0, _Absolute_d5fceabb74744431b85e0fdda3c8cf5c_Out_1, _Smoothstep_5b3511aa53f74a73b9b9614372a6af74_Out_3);
            float _Property_8fb0c3dbf4a84403a6068e70183a7ea4_Out_0 = _Base_Speed;
            float _Multiply_774f493cd66541e7ba6553802a499b79_Out_2;
            Unity_Multiply_float_float(IN.TimeParameters.x, _Property_8fb0c3dbf4a84403a6068e70183a7ea4_Out_0, _Multiply_774f493cd66541e7ba6553802a499b79_Out_2);
            float2 _TilingAndOffset_969b7b642fd04ed7b2592123a03eca18_Out_3;
            Unity_TilingAndOffset_float((_RotateAboutAxis_6e7d2784bd02405faeb7bacb567d0731_Out_3.xy), float2 (1, 1), (_Multiply_774f493cd66541e7ba6553802a499b79_Out_2.xx), _TilingAndOffset_969b7b642fd04ed7b2592123a03eca18_Out_3);
            float _Property_e3b00c3a5e804e14a1e03e69aac49211_Out_0 = _Base_Scale;
            float _GradientNoise_04262dfbc1b540b1a9d9b997627f189b_Out_2;
            Unity_GradientNoise_float(_TilingAndOffset_969b7b642fd04ed7b2592123a03eca18_Out_3, _Property_e3b00c3a5e804e14a1e03e69aac49211_Out_0, _GradientNoise_04262dfbc1b540b1a9d9b997627f189b_Out_2);
            float _Property_17938a6d7e2f40dd8d0f1b984a9fbb59_Out_0 = _Base_Strength;
            float _Multiply_0854b1bc83aa4170a68f058b8cb96ff7_Out_2;
            Unity_Multiply_float_float(_GradientNoise_04262dfbc1b540b1a9d9b997627f189b_Out_2, _Property_17938a6d7e2f40dd8d0f1b984a9fbb59_Out_0, _Multiply_0854b1bc83aa4170a68f058b8cb96ff7_Out_2);
            float _Add_f82d9f056cbf456f911125a9574d865f_Out_2;
            Unity_Add_float(_Smoothstep_5b3511aa53f74a73b9b9614372a6af74_Out_3, _Multiply_0854b1bc83aa4170a68f058b8cb96ff7_Out_2, _Add_f82d9f056cbf456f911125a9574d865f_Out_2);
            float _Add_df54866b810e4151a1fde09a51f17b65_Out_2;
            Unity_Add_float(1, _Property_17938a6d7e2f40dd8d0f1b984a9fbb59_Out_0, _Add_df54866b810e4151a1fde09a51f17b65_Out_2);
            float _Divide_b2c87465e89040e4940d7d7f42943c3f_Out_2;
            Unity_Divide_float(_Add_f82d9f056cbf456f911125a9574d865f_Out_2, _Add_df54866b810e4151a1fde09a51f17b65_Out_2, _Divide_b2c87465e89040e4940d7d7f42943c3f_Out_2);
            float3 _Multiply_cc4eb1139ae74d4c85067f5171acc955_Out_2;
            Unity_Multiply_float3_float3(IN.ObjectSpaceNormal, (_Divide_b2c87465e89040e4940d7d7f42943c3f_Out_2.xxx), _Multiply_cc4eb1139ae74d4c85067f5171acc955_Out_2);
            float _Property_611696cf692e4bb19aaf7739c57cdd44_Out_0 = _Noise_Height;
            float3 _Multiply_da4791b114e34eceac3bacbb1043285e_Out_2;
            Unity_Multiply_float3_float3(_Multiply_cc4eb1139ae74d4c85067f5171acc955_Out_2, (_Property_611696cf692e4bb19aaf7739c57cdd44_Out_0.xxx), _Multiply_da4791b114e34eceac3bacbb1043285e_Out_2);
            float3 _Add_1af6468ff1e344348b74bd929f252cbf_Out_2;
            Unity_Add_float3(IN.ObjectSpacePosition, _Multiply_da4791b114e34eceac3bacbb1043285e_Out_2, _Add_1af6468ff1e344348b74bd929f252cbf_Out_2);
            float3 _Add_c7842509b95b4858bfbf1f91fea0a4c3_Out_2;
            Unity_Add_float3(_Multiply_5ca41a1165784fbe980a8c3177fad7e1_Out_2, _Add_1af6468ff1e344348b74bd929f252cbf_Out_2, _Add_c7842509b95b4858bfbf1f91fea0a4c3_Out_2);
            description.Position = _Add_c7842509b95b4858bfbf1f91fea0a4c3_Out_2;
            description.Normal = IN.ObjectSpaceNormal;
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
            float Alpha;
            float AlphaClipThreshold;
        };
        
        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            float _SceneDepth_92d0d826f11444f38ddac1aa18b54491_Out_1;
            Unity_SceneDepth_Eye_float(float4(IN.ScreenPosition.xy / IN.ScreenPosition.w, 0, 0), _SceneDepth_92d0d826f11444f38ddac1aa18b54491_Out_1);
            float4 _ScreenPosition_a43e7cd4d3c742149035c252ba0d4ec9_Out_0 = IN.ScreenPosition;
            float _Split_945e233c5d5644b39c8f24743ae9b880_R_1 = _ScreenPosition_a43e7cd4d3c742149035c252ba0d4ec9_Out_0[0];
            float _Split_945e233c5d5644b39c8f24743ae9b880_G_2 = _ScreenPosition_a43e7cd4d3c742149035c252ba0d4ec9_Out_0[1];
            float _Split_945e233c5d5644b39c8f24743ae9b880_B_3 = _ScreenPosition_a43e7cd4d3c742149035c252ba0d4ec9_Out_0[2];
            float _Split_945e233c5d5644b39c8f24743ae9b880_A_4 = _ScreenPosition_a43e7cd4d3c742149035c252ba0d4ec9_Out_0[3];
            float _Subtract_509aa90668e7408bad7076496f9d5759_Out_2;
            Unity_Subtract_float(_Split_945e233c5d5644b39c8f24743ae9b880_A_4, 1, _Subtract_509aa90668e7408bad7076496f9d5759_Out_2);
            float _Subtract_72c15d8c0496460ca2c6aaf585c41381_Out_2;
            Unity_Subtract_float(_SceneDepth_92d0d826f11444f38ddac1aa18b54491_Out_1, _Subtract_509aa90668e7408bad7076496f9d5759_Out_2, _Subtract_72c15d8c0496460ca2c6aaf585c41381_Out_2);
            float _Property_3a30c5a5cbf24fa6913c8ee537ee5f4b_Out_0 = _Fade_Depth;
            float _Divide_8b2505abc71b4c3f8954d6fb229e0865_Out_2;
            Unity_Divide_float(_Subtract_72c15d8c0496460ca2c6aaf585c41381_Out_2, _Property_3a30c5a5cbf24fa6913c8ee537ee5f4b_Out_0, _Divide_8b2505abc71b4c3f8954d6fb229e0865_Out_2);
            float _Saturate_3c60f55f62d842639e72ca2a20ce74df_Out_1;
            Unity_Saturate_float(_Divide_8b2505abc71b4c3f8954d6fb229e0865_Out_2, _Saturate_3c60f55f62d842639e72ca2a20ce74df_Out_1);
            surface.Alpha = _Saturate_3c60f55f62d842639e72ca2a20ce74df_Out_1;
            surface.AlphaClipThreshold = 0.5;
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
            output.WorldSpaceNormal =                           TransformObjectToWorldNormal(input.normalOS);
            output.ObjectSpaceTangent =                         input.tangentOS.xyz;
            output.ObjectSpacePosition =                        input.positionOS;
            output.WorldSpacePosition =                         TransformObjectToWorld(input.positionOS);
            output.TimeParameters =                             _TimeParameters.xyz;
        
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
        
            
        
        
        
        
        
            output.WorldSpacePosition = input.positionWS;
            output.ScreenPosition = ComputeScreenPos(TransformWorldToHClip(input.positionWS), _ProjectionParams.x);
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
        Cull [_Cull]
        
        // Debug
        // <None>
        
        // --------------------------------------------------
        // Pass
        
        HLSLPROGRAM
        
        // Pragmas
        #pragma target 2.0
        #pragma only_renderers gles gles3 glcore d3d11
        #pragma multi_compile_instancing
        #pragma vertex vert
        #pragma fragment frag
        
        // DotsInstancingOptions: <None>
        // HybridV1InjectedBuiltinProperties: <None>
        
        // Keywords
        #pragma shader_feature_local_fragment _ _ALPHATEST_ON
        // GraphKeywords: <None>
        
        // Defines
        
        #define ATTRIBUTES_NEED_NORMAL
        #define ATTRIBUTES_NEED_TANGENT
        #define VARYINGS_NEED_POSITION_WS
        #define FEATURES_GRAPH_VERTEX
        /* WARNING: $splice Could not find named fragment 'PassInstancing' */
        #define SHADERPASS SHADERPASS_DEPTHONLY
        #define SCENEPICKINGPASS 1
        #define ALPHA_CLIP_THRESHOLD 1
        #define REQUIRE_DEPTH_TEXTURE
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
             float3 positionWS;
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
             float3 WorldSpacePosition;
             float4 ScreenPosition;
        };
        struct VertexDescriptionInputs
        {
             float3 ObjectSpaceNormal;
             float3 WorldSpaceNormal;
             float3 ObjectSpaceTangent;
             float3 ObjectSpacePosition;
             float3 WorldSpacePosition;
             float3 TimeParameters;
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
            output.interp0.xyz =  input.positionWS;
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
        float4 _Rotate_Projection;
        float _Noise_Scale;
        float _Noise_Speed;
        float _Noise_Height;
        float4 _Noise_Remap;
        float4 _Colour_Peak;
        float4 _Colour_Valley;
        float _Noise_Edge_1;
        float _Noise_Edge_2;
        float _Noise_Power;
        float _Base_Scale;
        float _Base_Speed;
        float _Base_Strength;
        float _Emission;
        float _Curvature_Radius;
        float _Fresnel_Power;
        float _Fresnel_opacity;
        float _Fade_Depth;
        CBUFFER_END
        
        // Object and Global properties
        
        // Graph Includes
        // GraphIncludes: <None>
        
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
        
        void Unity_Distance_float3(float3 A, float3 B, out float Out)
        {
            Out = distance(A, B);
        }
        
        void Unity_Divide_float(float A, float B, out float Out)
        {
            Out = A / B;
        }
        
        void Unity_Power_float(float A, float B, out float Out)
        {
            Out = pow(A, B);
        }
        
        void Unity_Multiply_float3_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A * B;
        }
        
        void Unity_Rotate_About_Axis_Degrees_float(float3 In, float3 Axis, float Rotation, out float3 Out)
        {
            Rotation = radians(Rotation);
        
            float s = sin(Rotation);
            float c = cos(Rotation);
            float one_minus_c = 1.0 - c;
        
            Axis = normalize(Axis);
        
            float3x3 rot_mat = { one_minus_c * Axis.x * Axis.x + c,            one_minus_c * Axis.x * Axis.y - Axis.z * s,     one_minus_c * Axis.z * Axis.x + Axis.y * s,
                                      one_minus_c * Axis.x * Axis.y + Axis.z * s,   one_minus_c * Axis.y * Axis.y + c,              one_minus_c * Axis.y * Axis.z - Axis.x * s,
                                      one_minus_c * Axis.z * Axis.x - Axis.y * s,   one_minus_c * Axis.y * Axis.z + Axis.x * s,     one_minus_c * Axis.z * Axis.z + c
                                    };
        
            Out = mul(rot_mat,  In);
        }
        
        void Unity_Multiply_float_float(float A, float B, out float Out)
        {
            Out = A * B;
        }
        
        void Unity_TilingAndOffset_float(float2 UV, float2 Tiling, float2 Offset, out float2 Out)
        {
            Out = UV * Tiling + Offset;
        }
        
        
        float2 Unity_GradientNoise_Dir_float(float2 p)
        {
            // Permutation and hashing used in webgl-nosie goo.gl/pX7HtC
            p = p % 289;
            // need full precision, otherwise half overflows when p > 1
            float x = float(34 * p.x + 1) * p.x % 289 + p.y;
            x = (34 * x + 1) * x % 289;
            x = frac(x / 41) * 2 - 1;
            return normalize(float2(x - floor(x + 0.5), abs(x) - 0.5));
        }
        
        void Unity_GradientNoise_float(float2 UV, float Scale, out float Out)
        {
            float2 p = UV * Scale;
            float2 ip = floor(p);
            float2 fp = frac(p);
            float d00 = dot(Unity_GradientNoise_Dir_float(ip), fp);
            float d01 = dot(Unity_GradientNoise_Dir_float(ip + float2(0, 1)), fp - float2(0, 1));
            float d10 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 0)), fp - float2(1, 0));
            float d11 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 1)), fp - float2(1, 1));
            fp = fp * fp * fp * (fp * (fp * 6 - 15) + 10);
            Out = lerp(lerp(d00, d01, fp.y), lerp(d10, d11, fp.y), fp.x) + 0.5;
        }
        
        void Unity_Add_float(float A, float B, out float Out)
        {
            Out = A + B;
        }
        
        void Unity_Saturate_float(float In, out float Out)
        {
            Out = saturate(In);
        }
        
        void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
        {
            RGBA = float4(R, G, B, A);
            RGB = float3(R, G, B);
            RG = float2(R, G);
        }
        
        void Unity_Remap_float(float In, float2 InMinMax, float2 OutMinMax, out float Out)
        {
            Out = OutMinMax.x + (In - InMinMax.x) * (OutMinMax.y - OutMinMax.x) / (InMinMax.y - InMinMax.x);
        }
        
        void Unity_Absolute_float(float In, out float Out)
        {
            Out = abs(In);
        }
        
        void Unity_Smoothstep_float(float Edge1, float Edge2, float In, out float Out)
        {
            Out = smoothstep(Edge1, Edge2, In);
        }
        
        void Unity_Add_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A + B;
        }
        
        void Unity_SceneDepth_Eye_float(float4 UV, out float Out)
        {
            if (unity_OrthoParams.w == 1.0)
            {
                Out = LinearEyeDepth(ComputeWorldSpacePosition(UV.xy, SHADERGRAPH_SAMPLE_SCENE_DEPTH(UV.xy), UNITY_MATRIX_I_VP), UNITY_MATRIX_V);
            }
            else
            {
                Out = LinearEyeDepth(SHADERGRAPH_SAMPLE_SCENE_DEPTH(UV.xy), _ZBufferParams);
            }
        }
        
        void Unity_Subtract_float(float A, float B, out float Out)
        {
            Out = A - B;
        }
        
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
            float _Distance_c01ba79505ea4a8891c3da5756fe9e5a_Out_2;
            Unity_Distance_float3(SHADERGRAPH_OBJECT_POSITION, IN.WorldSpacePosition, _Distance_c01ba79505ea4a8891c3da5756fe9e5a_Out_2);
            float _Property_d1be4d71eb4e4aae9337b9b402f45d63_Out_0 = _Curvature_Radius;
            float _Divide_03646e2359744ec38397913fc1d7c270_Out_2;
            Unity_Divide_float(_Distance_c01ba79505ea4a8891c3da5756fe9e5a_Out_2, _Property_d1be4d71eb4e4aae9337b9b402f45d63_Out_0, _Divide_03646e2359744ec38397913fc1d7c270_Out_2);
            float _Power_07f0eac51f1244fbb5c4966f586ac4dc_Out_2;
            Unity_Power_float(_Divide_03646e2359744ec38397913fc1d7c270_Out_2, 3, _Power_07f0eac51f1244fbb5c4966f586ac4dc_Out_2);
            float3 _Multiply_5ca41a1165784fbe980a8c3177fad7e1_Out_2;
            Unity_Multiply_float3_float3(IN.WorldSpaceNormal, (_Power_07f0eac51f1244fbb5c4966f586ac4dc_Out_2.xxx), _Multiply_5ca41a1165784fbe980a8c3177fad7e1_Out_2);
            float _Property_ef386ec2d5f4434a8a5f934ff230322f_Out_0 = _Noise_Edge_1;
            float _Property_147f1a2515e04a399eed34de35cf1107_Out_0 = _Noise_Edge_2;
            float4 _Property_b84368a6bae8433994c8bf5d771c01f4_Out_0 = _Rotate_Projection;
            float _Split_31db8d949ab24fd1b5ded76e6ecb6868_R_1 = _Property_b84368a6bae8433994c8bf5d771c01f4_Out_0[0];
            float _Split_31db8d949ab24fd1b5ded76e6ecb6868_G_2 = _Property_b84368a6bae8433994c8bf5d771c01f4_Out_0[1];
            float _Split_31db8d949ab24fd1b5ded76e6ecb6868_B_3 = _Property_b84368a6bae8433994c8bf5d771c01f4_Out_0[2];
            float _Split_31db8d949ab24fd1b5ded76e6ecb6868_A_4 = _Property_b84368a6bae8433994c8bf5d771c01f4_Out_0[3];
            float3 _RotateAboutAxis_6e7d2784bd02405faeb7bacb567d0731_Out_3;
            Unity_Rotate_About_Axis_Degrees_float(IN.WorldSpacePosition, (_Property_b84368a6bae8433994c8bf5d771c01f4_Out_0.xyz), _Split_31db8d949ab24fd1b5ded76e6ecb6868_A_4, _RotateAboutAxis_6e7d2784bd02405faeb7bacb567d0731_Out_3);
            float _Property_1b5acb9aca4b4c1ca8150917cb29e38d_Out_0 = _Noise_Speed;
            float _Multiply_a1f01de168c5412e848fa5a9a4f633d8_Out_2;
            Unity_Multiply_float_float(IN.TimeParameters.x, _Property_1b5acb9aca4b4c1ca8150917cb29e38d_Out_0, _Multiply_a1f01de168c5412e848fa5a9a4f633d8_Out_2);
            float2 _TilingAndOffset_3a22eccd71474e639594fce72cde2d02_Out_3;
            Unity_TilingAndOffset_float((_RotateAboutAxis_6e7d2784bd02405faeb7bacb567d0731_Out_3.xy), float2 (1, 1), (_Multiply_a1f01de168c5412e848fa5a9a4f633d8_Out_2.xx), _TilingAndOffset_3a22eccd71474e639594fce72cde2d02_Out_3);
            float _Property_e34f89cb08684afb94f0ac41ba675b11_Out_0 = _Noise_Scale;
            float _GradientNoise_71dea3d8ca7f493a820838ec4624d407_Out_2;
            Unity_GradientNoise_float(_TilingAndOffset_3a22eccd71474e639594fce72cde2d02_Out_3, _Property_e34f89cb08684afb94f0ac41ba675b11_Out_0, _GradientNoise_71dea3d8ca7f493a820838ec4624d407_Out_2);
            float2 _TilingAndOffset_b402f80311694eb4b5a4c3d07e71c615_Out_3;
            Unity_TilingAndOffset_float((_RotateAboutAxis_6e7d2784bd02405faeb7bacb567d0731_Out_3.xy), float2 (1, 1), float2 (0, 0), _TilingAndOffset_b402f80311694eb4b5a4c3d07e71c615_Out_3);
            float _GradientNoise_7cfc31faa781410090b11ae418c9e103_Out_2;
            Unity_GradientNoise_float(_TilingAndOffset_b402f80311694eb4b5a4c3d07e71c615_Out_3, _Property_e34f89cb08684afb94f0ac41ba675b11_Out_0, _GradientNoise_7cfc31faa781410090b11ae418c9e103_Out_2);
            float _Add_8d3a946d8f7848c0a6a4ee9e280c511d_Out_2;
            Unity_Add_float(_GradientNoise_71dea3d8ca7f493a820838ec4624d407_Out_2, _GradientNoise_7cfc31faa781410090b11ae418c9e103_Out_2, _Add_8d3a946d8f7848c0a6a4ee9e280c511d_Out_2);
            float _Divide_883697060c4b42898d76bc5325a5b568_Out_2;
            Unity_Divide_float(_Add_8d3a946d8f7848c0a6a4ee9e280c511d_Out_2, 2, _Divide_883697060c4b42898d76bc5325a5b568_Out_2);
            float _Saturate_c96331ef3b2642d39a446bce3d43f560_Out_1;
            Unity_Saturate_float(_Divide_883697060c4b42898d76bc5325a5b568_Out_2, _Saturate_c96331ef3b2642d39a446bce3d43f560_Out_1);
            float _Property_a5e2c659762f49e2826023553b233885_Out_0 = _Noise_Power;
            float _Power_fe5fa4a062ff4bac868501be2a7f055c_Out_2;
            Unity_Power_float(_Saturate_c96331ef3b2642d39a446bce3d43f560_Out_1, _Property_a5e2c659762f49e2826023553b233885_Out_0, _Power_fe5fa4a062ff4bac868501be2a7f055c_Out_2);
            float4 _Property_f466dd4679cc4567b14cecb45e839124_Out_0 = _Noise_Remap;
            float _Split_cfe4e3a30c93414694a4d7e49c708985_R_1 = _Property_f466dd4679cc4567b14cecb45e839124_Out_0[0];
            float _Split_cfe4e3a30c93414694a4d7e49c708985_G_2 = _Property_f466dd4679cc4567b14cecb45e839124_Out_0[1];
            float _Split_cfe4e3a30c93414694a4d7e49c708985_B_3 = _Property_f466dd4679cc4567b14cecb45e839124_Out_0[2];
            float _Split_cfe4e3a30c93414694a4d7e49c708985_A_4 = _Property_f466dd4679cc4567b14cecb45e839124_Out_0[3];
            float4 _Combine_c045c4c659354461848cd6c7d61e4be5_RGBA_4;
            float3 _Combine_c045c4c659354461848cd6c7d61e4be5_RGB_5;
            float2 _Combine_c045c4c659354461848cd6c7d61e4be5_RG_6;
            Unity_Combine_float(_Split_cfe4e3a30c93414694a4d7e49c708985_R_1, _Split_cfe4e3a30c93414694a4d7e49c708985_G_2, 0, 0, _Combine_c045c4c659354461848cd6c7d61e4be5_RGBA_4, _Combine_c045c4c659354461848cd6c7d61e4be5_RGB_5, _Combine_c045c4c659354461848cd6c7d61e4be5_RG_6);
            float4 _Combine_6de15c52675e489b874b27eaf16323df_RGBA_4;
            float3 _Combine_6de15c52675e489b874b27eaf16323df_RGB_5;
            float2 _Combine_6de15c52675e489b874b27eaf16323df_RG_6;
            Unity_Combine_float(_Split_cfe4e3a30c93414694a4d7e49c708985_B_3, _Split_cfe4e3a30c93414694a4d7e49c708985_A_4, 0, 0, _Combine_6de15c52675e489b874b27eaf16323df_RGBA_4, _Combine_6de15c52675e489b874b27eaf16323df_RGB_5, _Combine_6de15c52675e489b874b27eaf16323df_RG_6);
            float _Remap_192e92b0649c4e009e825f27b2499763_Out_3;
            Unity_Remap_float(_Power_fe5fa4a062ff4bac868501be2a7f055c_Out_2, _Combine_c045c4c659354461848cd6c7d61e4be5_RG_6, _Combine_6de15c52675e489b874b27eaf16323df_RG_6, _Remap_192e92b0649c4e009e825f27b2499763_Out_3);
            float _Absolute_d5fceabb74744431b85e0fdda3c8cf5c_Out_1;
            Unity_Absolute_float(_Remap_192e92b0649c4e009e825f27b2499763_Out_3, _Absolute_d5fceabb74744431b85e0fdda3c8cf5c_Out_1);
            float _Smoothstep_5b3511aa53f74a73b9b9614372a6af74_Out_3;
            Unity_Smoothstep_float(_Property_ef386ec2d5f4434a8a5f934ff230322f_Out_0, _Property_147f1a2515e04a399eed34de35cf1107_Out_0, _Absolute_d5fceabb74744431b85e0fdda3c8cf5c_Out_1, _Smoothstep_5b3511aa53f74a73b9b9614372a6af74_Out_3);
            float _Property_8fb0c3dbf4a84403a6068e70183a7ea4_Out_0 = _Base_Speed;
            float _Multiply_774f493cd66541e7ba6553802a499b79_Out_2;
            Unity_Multiply_float_float(IN.TimeParameters.x, _Property_8fb0c3dbf4a84403a6068e70183a7ea4_Out_0, _Multiply_774f493cd66541e7ba6553802a499b79_Out_2);
            float2 _TilingAndOffset_969b7b642fd04ed7b2592123a03eca18_Out_3;
            Unity_TilingAndOffset_float((_RotateAboutAxis_6e7d2784bd02405faeb7bacb567d0731_Out_3.xy), float2 (1, 1), (_Multiply_774f493cd66541e7ba6553802a499b79_Out_2.xx), _TilingAndOffset_969b7b642fd04ed7b2592123a03eca18_Out_3);
            float _Property_e3b00c3a5e804e14a1e03e69aac49211_Out_0 = _Base_Scale;
            float _GradientNoise_04262dfbc1b540b1a9d9b997627f189b_Out_2;
            Unity_GradientNoise_float(_TilingAndOffset_969b7b642fd04ed7b2592123a03eca18_Out_3, _Property_e3b00c3a5e804e14a1e03e69aac49211_Out_0, _GradientNoise_04262dfbc1b540b1a9d9b997627f189b_Out_2);
            float _Property_17938a6d7e2f40dd8d0f1b984a9fbb59_Out_0 = _Base_Strength;
            float _Multiply_0854b1bc83aa4170a68f058b8cb96ff7_Out_2;
            Unity_Multiply_float_float(_GradientNoise_04262dfbc1b540b1a9d9b997627f189b_Out_2, _Property_17938a6d7e2f40dd8d0f1b984a9fbb59_Out_0, _Multiply_0854b1bc83aa4170a68f058b8cb96ff7_Out_2);
            float _Add_f82d9f056cbf456f911125a9574d865f_Out_2;
            Unity_Add_float(_Smoothstep_5b3511aa53f74a73b9b9614372a6af74_Out_3, _Multiply_0854b1bc83aa4170a68f058b8cb96ff7_Out_2, _Add_f82d9f056cbf456f911125a9574d865f_Out_2);
            float _Add_df54866b810e4151a1fde09a51f17b65_Out_2;
            Unity_Add_float(1, _Property_17938a6d7e2f40dd8d0f1b984a9fbb59_Out_0, _Add_df54866b810e4151a1fde09a51f17b65_Out_2);
            float _Divide_b2c87465e89040e4940d7d7f42943c3f_Out_2;
            Unity_Divide_float(_Add_f82d9f056cbf456f911125a9574d865f_Out_2, _Add_df54866b810e4151a1fde09a51f17b65_Out_2, _Divide_b2c87465e89040e4940d7d7f42943c3f_Out_2);
            float3 _Multiply_cc4eb1139ae74d4c85067f5171acc955_Out_2;
            Unity_Multiply_float3_float3(IN.ObjectSpaceNormal, (_Divide_b2c87465e89040e4940d7d7f42943c3f_Out_2.xxx), _Multiply_cc4eb1139ae74d4c85067f5171acc955_Out_2);
            float _Property_611696cf692e4bb19aaf7739c57cdd44_Out_0 = _Noise_Height;
            float3 _Multiply_da4791b114e34eceac3bacbb1043285e_Out_2;
            Unity_Multiply_float3_float3(_Multiply_cc4eb1139ae74d4c85067f5171acc955_Out_2, (_Property_611696cf692e4bb19aaf7739c57cdd44_Out_0.xxx), _Multiply_da4791b114e34eceac3bacbb1043285e_Out_2);
            float3 _Add_1af6468ff1e344348b74bd929f252cbf_Out_2;
            Unity_Add_float3(IN.ObjectSpacePosition, _Multiply_da4791b114e34eceac3bacbb1043285e_Out_2, _Add_1af6468ff1e344348b74bd929f252cbf_Out_2);
            float3 _Add_c7842509b95b4858bfbf1f91fea0a4c3_Out_2;
            Unity_Add_float3(_Multiply_5ca41a1165784fbe980a8c3177fad7e1_Out_2, _Add_1af6468ff1e344348b74bd929f252cbf_Out_2, _Add_c7842509b95b4858bfbf1f91fea0a4c3_Out_2);
            description.Position = _Add_c7842509b95b4858bfbf1f91fea0a4c3_Out_2;
            description.Normal = IN.ObjectSpaceNormal;
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
            float Alpha;
            float AlphaClipThreshold;
        };
        
        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            float _SceneDepth_92d0d826f11444f38ddac1aa18b54491_Out_1;
            Unity_SceneDepth_Eye_float(float4(IN.ScreenPosition.xy / IN.ScreenPosition.w, 0, 0), _SceneDepth_92d0d826f11444f38ddac1aa18b54491_Out_1);
            float4 _ScreenPosition_a43e7cd4d3c742149035c252ba0d4ec9_Out_0 = IN.ScreenPosition;
            float _Split_945e233c5d5644b39c8f24743ae9b880_R_1 = _ScreenPosition_a43e7cd4d3c742149035c252ba0d4ec9_Out_0[0];
            float _Split_945e233c5d5644b39c8f24743ae9b880_G_2 = _ScreenPosition_a43e7cd4d3c742149035c252ba0d4ec9_Out_0[1];
            float _Split_945e233c5d5644b39c8f24743ae9b880_B_3 = _ScreenPosition_a43e7cd4d3c742149035c252ba0d4ec9_Out_0[2];
            float _Split_945e233c5d5644b39c8f24743ae9b880_A_4 = _ScreenPosition_a43e7cd4d3c742149035c252ba0d4ec9_Out_0[3];
            float _Subtract_509aa90668e7408bad7076496f9d5759_Out_2;
            Unity_Subtract_float(_Split_945e233c5d5644b39c8f24743ae9b880_A_4, 1, _Subtract_509aa90668e7408bad7076496f9d5759_Out_2);
            float _Subtract_72c15d8c0496460ca2c6aaf585c41381_Out_2;
            Unity_Subtract_float(_SceneDepth_92d0d826f11444f38ddac1aa18b54491_Out_1, _Subtract_509aa90668e7408bad7076496f9d5759_Out_2, _Subtract_72c15d8c0496460ca2c6aaf585c41381_Out_2);
            float _Property_3a30c5a5cbf24fa6913c8ee537ee5f4b_Out_0 = _Fade_Depth;
            float _Divide_8b2505abc71b4c3f8954d6fb229e0865_Out_2;
            Unity_Divide_float(_Subtract_72c15d8c0496460ca2c6aaf585c41381_Out_2, _Property_3a30c5a5cbf24fa6913c8ee537ee5f4b_Out_0, _Divide_8b2505abc71b4c3f8954d6fb229e0865_Out_2);
            float _Saturate_3c60f55f62d842639e72ca2a20ce74df_Out_1;
            Unity_Saturate_float(_Divide_8b2505abc71b4c3f8954d6fb229e0865_Out_2, _Saturate_3c60f55f62d842639e72ca2a20ce74df_Out_1);
            surface.Alpha = _Saturate_3c60f55f62d842639e72ca2a20ce74df_Out_1;
            surface.AlphaClipThreshold = 0.5;
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
            output.WorldSpaceNormal =                           TransformObjectToWorldNormal(input.normalOS);
            output.ObjectSpaceTangent =                         input.tangentOS.xyz;
            output.ObjectSpacePosition =                        input.positionOS;
            output.WorldSpacePosition =                         TransformObjectToWorld(input.positionOS);
            output.TimeParameters =                             _TimeParameters.xyz;
        
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
        
            
        
        
        
        
        
            output.WorldSpacePosition = input.positionWS;
            output.ScreenPosition = ComputeScreenPos(TransformWorldToHClip(input.positionWS), _ProjectionParams.x);
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
            Name "DepthNormals"
            Tags
            {
                "LightMode" = "DepthNormalsOnly"
            }
        
        // Render State
        Cull [_Cull]
        ZTest LEqual
        ZWrite On
        
        // Debug
        // <None>
        
        // --------------------------------------------------
        // Pass
        
        HLSLPROGRAM
        
        // Pragmas
        #pragma target 2.0
        #pragma only_renderers gles gles3 glcore d3d11
        #pragma multi_compile_instancing
        #pragma multi_compile_fog
        #pragma instancing_options renderinglayer
        #pragma vertex vert
        #pragma fragment frag
        
        // DotsInstancingOptions: <None>
        // HybridV1InjectedBuiltinProperties: <None>
        
        // Keywords
        #pragma shader_feature_fragment _ _SURFACE_TYPE_TRANSPARENT
        #pragma shader_feature_local_fragment _ _ALPHAPREMULTIPLY_ON
        #pragma shader_feature_local_fragment _ _ALPHATEST_ON
        // GraphKeywords: <None>
        
        // Defines
        
        #define ATTRIBUTES_NEED_NORMAL
        #define ATTRIBUTES_NEED_TANGENT
        #define VARYINGS_NEED_POSITION_WS
        #define VARYINGS_NEED_NORMAL_WS
        #define FEATURES_GRAPH_VERTEX
        /* WARNING: $splice Could not find named fragment 'PassInstancing' */
        #define SHADERPASS SHADERPASS_DEPTHNORMALSONLY
        #define REQUIRE_DEPTH_TEXTURE
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
             float3 positionWS;
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
             float3 WorldSpacePosition;
             float4 ScreenPosition;
        };
        struct VertexDescriptionInputs
        {
             float3 ObjectSpaceNormal;
             float3 WorldSpaceNormal;
             float3 ObjectSpaceTangent;
             float3 ObjectSpacePosition;
             float3 WorldSpacePosition;
             float3 TimeParameters;
        };
        struct PackedVaryings
        {
             float4 positionCS : SV_POSITION;
             float3 interp0 : INTERP0;
             float3 interp1 : INTERP1;
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
        float4 _Rotate_Projection;
        float _Noise_Scale;
        float _Noise_Speed;
        float _Noise_Height;
        float4 _Noise_Remap;
        float4 _Colour_Peak;
        float4 _Colour_Valley;
        float _Noise_Edge_1;
        float _Noise_Edge_2;
        float _Noise_Power;
        float _Base_Scale;
        float _Base_Speed;
        float _Base_Strength;
        float _Emission;
        float _Curvature_Radius;
        float _Fresnel_Power;
        float _Fresnel_opacity;
        float _Fade_Depth;
        CBUFFER_END
        
        // Object and Global properties
        
        // Graph Includes
        // GraphIncludes: <None>
        
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
        
        void Unity_Distance_float3(float3 A, float3 B, out float Out)
        {
            Out = distance(A, B);
        }
        
        void Unity_Divide_float(float A, float B, out float Out)
        {
            Out = A / B;
        }
        
        void Unity_Power_float(float A, float B, out float Out)
        {
            Out = pow(A, B);
        }
        
        void Unity_Multiply_float3_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A * B;
        }
        
        void Unity_Rotate_About_Axis_Degrees_float(float3 In, float3 Axis, float Rotation, out float3 Out)
        {
            Rotation = radians(Rotation);
        
            float s = sin(Rotation);
            float c = cos(Rotation);
            float one_minus_c = 1.0 - c;
        
            Axis = normalize(Axis);
        
            float3x3 rot_mat = { one_minus_c * Axis.x * Axis.x + c,            one_minus_c * Axis.x * Axis.y - Axis.z * s,     one_minus_c * Axis.z * Axis.x + Axis.y * s,
                                      one_minus_c * Axis.x * Axis.y + Axis.z * s,   one_minus_c * Axis.y * Axis.y + c,              one_minus_c * Axis.y * Axis.z - Axis.x * s,
                                      one_minus_c * Axis.z * Axis.x - Axis.y * s,   one_minus_c * Axis.y * Axis.z + Axis.x * s,     one_minus_c * Axis.z * Axis.z + c
                                    };
        
            Out = mul(rot_mat,  In);
        }
        
        void Unity_Multiply_float_float(float A, float B, out float Out)
        {
            Out = A * B;
        }
        
        void Unity_TilingAndOffset_float(float2 UV, float2 Tiling, float2 Offset, out float2 Out)
        {
            Out = UV * Tiling + Offset;
        }
        
        
        float2 Unity_GradientNoise_Dir_float(float2 p)
        {
            // Permutation and hashing used in webgl-nosie goo.gl/pX7HtC
            p = p % 289;
            // need full precision, otherwise half overflows when p > 1
            float x = float(34 * p.x + 1) * p.x % 289 + p.y;
            x = (34 * x + 1) * x % 289;
            x = frac(x / 41) * 2 - 1;
            return normalize(float2(x - floor(x + 0.5), abs(x) - 0.5));
        }
        
        void Unity_GradientNoise_float(float2 UV, float Scale, out float Out)
        {
            float2 p = UV * Scale;
            float2 ip = floor(p);
            float2 fp = frac(p);
            float d00 = dot(Unity_GradientNoise_Dir_float(ip), fp);
            float d01 = dot(Unity_GradientNoise_Dir_float(ip + float2(0, 1)), fp - float2(0, 1));
            float d10 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 0)), fp - float2(1, 0));
            float d11 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 1)), fp - float2(1, 1));
            fp = fp * fp * fp * (fp * (fp * 6 - 15) + 10);
            Out = lerp(lerp(d00, d01, fp.y), lerp(d10, d11, fp.y), fp.x) + 0.5;
        }
        
        void Unity_Add_float(float A, float B, out float Out)
        {
            Out = A + B;
        }
        
        void Unity_Saturate_float(float In, out float Out)
        {
            Out = saturate(In);
        }
        
        void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
        {
            RGBA = float4(R, G, B, A);
            RGB = float3(R, G, B);
            RG = float2(R, G);
        }
        
        void Unity_Remap_float(float In, float2 InMinMax, float2 OutMinMax, out float Out)
        {
            Out = OutMinMax.x + (In - InMinMax.x) * (OutMinMax.y - OutMinMax.x) / (InMinMax.y - InMinMax.x);
        }
        
        void Unity_Absolute_float(float In, out float Out)
        {
            Out = abs(In);
        }
        
        void Unity_Smoothstep_float(float Edge1, float Edge2, float In, out float Out)
        {
            Out = smoothstep(Edge1, Edge2, In);
        }
        
        void Unity_Add_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A + B;
        }
        
        void Unity_SceneDepth_Eye_float(float4 UV, out float Out)
        {
            if (unity_OrthoParams.w == 1.0)
            {
                Out = LinearEyeDepth(ComputeWorldSpacePosition(UV.xy, SHADERGRAPH_SAMPLE_SCENE_DEPTH(UV.xy), UNITY_MATRIX_I_VP), UNITY_MATRIX_V);
            }
            else
            {
                Out = LinearEyeDepth(SHADERGRAPH_SAMPLE_SCENE_DEPTH(UV.xy), _ZBufferParams);
            }
        }
        
        void Unity_Subtract_float(float A, float B, out float Out)
        {
            Out = A - B;
        }
        
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
            float _Distance_c01ba79505ea4a8891c3da5756fe9e5a_Out_2;
            Unity_Distance_float3(SHADERGRAPH_OBJECT_POSITION, IN.WorldSpacePosition, _Distance_c01ba79505ea4a8891c3da5756fe9e5a_Out_2);
            float _Property_d1be4d71eb4e4aae9337b9b402f45d63_Out_0 = _Curvature_Radius;
            float _Divide_03646e2359744ec38397913fc1d7c270_Out_2;
            Unity_Divide_float(_Distance_c01ba79505ea4a8891c3da5756fe9e5a_Out_2, _Property_d1be4d71eb4e4aae9337b9b402f45d63_Out_0, _Divide_03646e2359744ec38397913fc1d7c270_Out_2);
            float _Power_07f0eac51f1244fbb5c4966f586ac4dc_Out_2;
            Unity_Power_float(_Divide_03646e2359744ec38397913fc1d7c270_Out_2, 3, _Power_07f0eac51f1244fbb5c4966f586ac4dc_Out_2);
            float3 _Multiply_5ca41a1165784fbe980a8c3177fad7e1_Out_2;
            Unity_Multiply_float3_float3(IN.WorldSpaceNormal, (_Power_07f0eac51f1244fbb5c4966f586ac4dc_Out_2.xxx), _Multiply_5ca41a1165784fbe980a8c3177fad7e1_Out_2);
            float _Property_ef386ec2d5f4434a8a5f934ff230322f_Out_0 = _Noise_Edge_1;
            float _Property_147f1a2515e04a399eed34de35cf1107_Out_0 = _Noise_Edge_2;
            float4 _Property_b84368a6bae8433994c8bf5d771c01f4_Out_0 = _Rotate_Projection;
            float _Split_31db8d949ab24fd1b5ded76e6ecb6868_R_1 = _Property_b84368a6bae8433994c8bf5d771c01f4_Out_0[0];
            float _Split_31db8d949ab24fd1b5ded76e6ecb6868_G_2 = _Property_b84368a6bae8433994c8bf5d771c01f4_Out_0[1];
            float _Split_31db8d949ab24fd1b5ded76e6ecb6868_B_3 = _Property_b84368a6bae8433994c8bf5d771c01f4_Out_0[2];
            float _Split_31db8d949ab24fd1b5ded76e6ecb6868_A_4 = _Property_b84368a6bae8433994c8bf5d771c01f4_Out_0[3];
            float3 _RotateAboutAxis_6e7d2784bd02405faeb7bacb567d0731_Out_3;
            Unity_Rotate_About_Axis_Degrees_float(IN.WorldSpacePosition, (_Property_b84368a6bae8433994c8bf5d771c01f4_Out_0.xyz), _Split_31db8d949ab24fd1b5ded76e6ecb6868_A_4, _RotateAboutAxis_6e7d2784bd02405faeb7bacb567d0731_Out_3);
            float _Property_1b5acb9aca4b4c1ca8150917cb29e38d_Out_0 = _Noise_Speed;
            float _Multiply_a1f01de168c5412e848fa5a9a4f633d8_Out_2;
            Unity_Multiply_float_float(IN.TimeParameters.x, _Property_1b5acb9aca4b4c1ca8150917cb29e38d_Out_0, _Multiply_a1f01de168c5412e848fa5a9a4f633d8_Out_2);
            float2 _TilingAndOffset_3a22eccd71474e639594fce72cde2d02_Out_3;
            Unity_TilingAndOffset_float((_RotateAboutAxis_6e7d2784bd02405faeb7bacb567d0731_Out_3.xy), float2 (1, 1), (_Multiply_a1f01de168c5412e848fa5a9a4f633d8_Out_2.xx), _TilingAndOffset_3a22eccd71474e639594fce72cde2d02_Out_3);
            float _Property_e34f89cb08684afb94f0ac41ba675b11_Out_0 = _Noise_Scale;
            float _GradientNoise_71dea3d8ca7f493a820838ec4624d407_Out_2;
            Unity_GradientNoise_float(_TilingAndOffset_3a22eccd71474e639594fce72cde2d02_Out_3, _Property_e34f89cb08684afb94f0ac41ba675b11_Out_0, _GradientNoise_71dea3d8ca7f493a820838ec4624d407_Out_2);
            float2 _TilingAndOffset_b402f80311694eb4b5a4c3d07e71c615_Out_3;
            Unity_TilingAndOffset_float((_RotateAboutAxis_6e7d2784bd02405faeb7bacb567d0731_Out_3.xy), float2 (1, 1), float2 (0, 0), _TilingAndOffset_b402f80311694eb4b5a4c3d07e71c615_Out_3);
            float _GradientNoise_7cfc31faa781410090b11ae418c9e103_Out_2;
            Unity_GradientNoise_float(_TilingAndOffset_b402f80311694eb4b5a4c3d07e71c615_Out_3, _Property_e34f89cb08684afb94f0ac41ba675b11_Out_0, _GradientNoise_7cfc31faa781410090b11ae418c9e103_Out_2);
            float _Add_8d3a946d8f7848c0a6a4ee9e280c511d_Out_2;
            Unity_Add_float(_GradientNoise_71dea3d8ca7f493a820838ec4624d407_Out_2, _GradientNoise_7cfc31faa781410090b11ae418c9e103_Out_2, _Add_8d3a946d8f7848c0a6a4ee9e280c511d_Out_2);
            float _Divide_883697060c4b42898d76bc5325a5b568_Out_2;
            Unity_Divide_float(_Add_8d3a946d8f7848c0a6a4ee9e280c511d_Out_2, 2, _Divide_883697060c4b42898d76bc5325a5b568_Out_2);
            float _Saturate_c96331ef3b2642d39a446bce3d43f560_Out_1;
            Unity_Saturate_float(_Divide_883697060c4b42898d76bc5325a5b568_Out_2, _Saturate_c96331ef3b2642d39a446bce3d43f560_Out_1);
            float _Property_a5e2c659762f49e2826023553b233885_Out_0 = _Noise_Power;
            float _Power_fe5fa4a062ff4bac868501be2a7f055c_Out_2;
            Unity_Power_float(_Saturate_c96331ef3b2642d39a446bce3d43f560_Out_1, _Property_a5e2c659762f49e2826023553b233885_Out_0, _Power_fe5fa4a062ff4bac868501be2a7f055c_Out_2);
            float4 _Property_f466dd4679cc4567b14cecb45e839124_Out_0 = _Noise_Remap;
            float _Split_cfe4e3a30c93414694a4d7e49c708985_R_1 = _Property_f466dd4679cc4567b14cecb45e839124_Out_0[0];
            float _Split_cfe4e3a30c93414694a4d7e49c708985_G_2 = _Property_f466dd4679cc4567b14cecb45e839124_Out_0[1];
            float _Split_cfe4e3a30c93414694a4d7e49c708985_B_3 = _Property_f466dd4679cc4567b14cecb45e839124_Out_0[2];
            float _Split_cfe4e3a30c93414694a4d7e49c708985_A_4 = _Property_f466dd4679cc4567b14cecb45e839124_Out_0[3];
            float4 _Combine_c045c4c659354461848cd6c7d61e4be5_RGBA_4;
            float3 _Combine_c045c4c659354461848cd6c7d61e4be5_RGB_5;
            float2 _Combine_c045c4c659354461848cd6c7d61e4be5_RG_6;
            Unity_Combine_float(_Split_cfe4e3a30c93414694a4d7e49c708985_R_1, _Split_cfe4e3a30c93414694a4d7e49c708985_G_2, 0, 0, _Combine_c045c4c659354461848cd6c7d61e4be5_RGBA_4, _Combine_c045c4c659354461848cd6c7d61e4be5_RGB_5, _Combine_c045c4c659354461848cd6c7d61e4be5_RG_6);
            float4 _Combine_6de15c52675e489b874b27eaf16323df_RGBA_4;
            float3 _Combine_6de15c52675e489b874b27eaf16323df_RGB_5;
            float2 _Combine_6de15c52675e489b874b27eaf16323df_RG_6;
            Unity_Combine_float(_Split_cfe4e3a30c93414694a4d7e49c708985_B_3, _Split_cfe4e3a30c93414694a4d7e49c708985_A_4, 0, 0, _Combine_6de15c52675e489b874b27eaf16323df_RGBA_4, _Combine_6de15c52675e489b874b27eaf16323df_RGB_5, _Combine_6de15c52675e489b874b27eaf16323df_RG_6);
            float _Remap_192e92b0649c4e009e825f27b2499763_Out_3;
            Unity_Remap_float(_Power_fe5fa4a062ff4bac868501be2a7f055c_Out_2, _Combine_c045c4c659354461848cd6c7d61e4be5_RG_6, _Combine_6de15c52675e489b874b27eaf16323df_RG_6, _Remap_192e92b0649c4e009e825f27b2499763_Out_3);
            float _Absolute_d5fceabb74744431b85e0fdda3c8cf5c_Out_1;
            Unity_Absolute_float(_Remap_192e92b0649c4e009e825f27b2499763_Out_3, _Absolute_d5fceabb74744431b85e0fdda3c8cf5c_Out_1);
            float _Smoothstep_5b3511aa53f74a73b9b9614372a6af74_Out_3;
            Unity_Smoothstep_float(_Property_ef386ec2d5f4434a8a5f934ff230322f_Out_0, _Property_147f1a2515e04a399eed34de35cf1107_Out_0, _Absolute_d5fceabb74744431b85e0fdda3c8cf5c_Out_1, _Smoothstep_5b3511aa53f74a73b9b9614372a6af74_Out_3);
            float _Property_8fb0c3dbf4a84403a6068e70183a7ea4_Out_0 = _Base_Speed;
            float _Multiply_774f493cd66541e7ba6553802a499b79_Out_2;
            Unity_Multiply_float_float(IN.TimeParameters.x, _Property_8fb0c3dbf4a84403a6068e70183a7ea4_Out_0, _Multiply_774f493cd66541e7ba6553802a499b79_Out_2);
            float2 _TilingAndOffset_969b7b642fd04ed7b2592123a03eca18_Out_3;
            Unity_TilingAndOffset_float((_RotateAboutAxis_6e7d2784bd02405faeb7bacb567d0731_Out_3.xy), float2 (1, 1), (_Multiply_774f493cd66541e7ba6553802a499b79_Out_2.xx), _TilingAndOffset_969b7b642fd04ed7b2592123a03eca18_Out_3);
            float _Property_e3b00c3a5e804e14a1e03e69aac49211_Out_0 = _Base_Scale;
            float _GradientNoise_04262dfbc1b540b1a9d9b997627f189b_Out_2;
            Unity_GradientNoise_float(_TilingAndOffset_969b7b642fd04ed7b2592123a03eca18_Out_3, _Property_e3b00c3a5e804e14a1e03e69aac49211_Out_0, _GradientNoise_04262dfbc1b540b1a9d9b997627f189b_Out_2);
            float _Property_17938a6d7e2f40dd8d0f1b984a9fbb59_Out_0 = _Base_Strength;
            float _Multiply_0854b1bc83aa4170a68f058b8cb96ff7_Out_2;
            Unity_Multiply_float_float(_GradientNoise_04262dfbc1b540b1a9d9b997627f189b_Out_2, _Property_17938a6d7e2f40dd8d0f1b984a9fbb59_Out_0, _Multiply_0854b1bc83aa4170a68f058b8cb96ff7_Out_2);
            float _Add_f82d9f056cbf456f911125a9574d865f_Out_2;
            Unity_Add_float(_Smoothstep_5b3511aa53f74a73b9b9614372a6af74_Out_3, _Multiply_0854b1bc83aa4170a68f058b8cb96ff7_Out_2, _Add_f82d9f056cbf456f911125a9574d865f_Out_2);
            float _Add_df54866b810e4151a1fde09a51f17b65_Out_2;
            Unity_Add_float(1, _Property_17938a6d7e2f40dd8d0f1b984a9fbb59_Out_0, _Add_df54866b810e4151a1fde09a51f17b65_Out_2);
            float _Divide_b2c87465e89040e4940d7d7f42943c3f_Out_2;
            Unity_Divide_float(_Add_f82d9f056cbf456f911125a9574d865f_Out_2, _Add_df54866b810e4151a1fde09a51f17b65_Out_2, _Divide_b2c87465e89040e4940d7d7f42943c3f_Out_2);
            float3 _Multiply_cc4eb1139ae74d4c85067f5171acc955_Out_2;
            Unity_Multiply_float3_float3(IN.ObjectSpaceNormal, (_Divide_b2c87465e89040e4940d7d7f42943c3f_Out_2.xxx), _Multiply_cc4eb1139ae74d4c85067f5171acc955_Out_2);
            float _Property_611696cf692e4bb19aaf7739c57cdd44_Out_0 = _Noise_Height;
            float3 _Multiply_da4791b114e34eceac3bacbb1043285e_Out_2;
            Unity_Multiply_float3_float3(_Multiply_cc4eb1139ae74d4c85067f5171acc955_Out_2, (_Property_611696cf692e4bb19aaf7739c57cdd44_Out_0.xxx), _Multiply_da4791b114e34eceac3bacbb1043285e_Out_2);
            float3 _Add_1af6468ff1e344348b74bd929f252cbf_Out_2;
            Unity_Add_float3(IN.ObjectSpacePosition, _Multiply_da4791b114e34eceac3bacbb1043285e_Out_2, _Add_1af6468ff1e344348b74bd929f252cbf_Out_2);
            float3 _Add_c7842509b95b4858bfbf1f91fea0a4c3_Out_2;
            Unity_Add_float3(_Multiply_5ca41a1165784fbe980a8c3177fad7e1_Out_2, _Add_1af6468ff1e344348b74bd929f252cbf_Out_2, _Add_c7842509b95b4858bfbf1f91fea0a4c3_Out_2);
            description.Position = _Add_c7842509b95b4858bfbf1f91fea0a4c3_Out_2;
            description.Normal = IN.ObjectSpaceNormal;
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
            float Alpha;
            float AlphaClipThreshold;
        };
        
        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            float _SceneDepth_92d0d826f11444f38ddac1aa18b54491_Out_1;
            Unity_SceneDepth_Eye_float(float4(IN.ScreenPosition.xy / IN.ScreenPosition.w, 0, 0), _SceneDepth_92d0d826f11444f38ddac1aa18b54491_Out_1);
            float4 _ScreenPosition_a43e7cd4d3c742149035c252ba0d4ec9_Out_0 = IN.ScreenPosition;
            float _Split_945e233c5d5644b39c8f24743ae9b880_R_1 = _ScreenPosition_a43e7cd4d3c742149035c252ba0d4ec9_Out_0[0];
            float _Split_945e233c5d5644b39c8f24743ae9b880_G_2 = _ScreenPosition_a43e7cd4d3c742149035c252ba0d4ec9_Out_0[1];
            float _Split_945e233c5d5644b39c8f24743ae9b880_B_3 = _ScreenPosition_a43e7cd4d3c742149035c252ba0d4ec9_Out_0[2];
            float _Split_945e233c5d5644b39c8f24743ae9b880_A_4 = _ScreenPosition_a43e7cd4d3c742149035c252ba0d4ec9_Out_0[3];
            float _Subtract_509aa90668e7408bad7076496f9d5759_Out_2;
            Unity_Subtract_float(_Split_945e233c5d5644b39c8f24743ae9b880_A_4, 1, _Subtract_509aa90668e7408bad7076496f9d5759_Out_2);
            float _Subtract_72c15d8c0496460ca2c6aaf585c41381_Out_2;
            Unity_Subtract_float(_SceneDepth_92d0d826f11444f38ddac1aa18b54491_Out_1, _Subtract_509aa90668e7408bad7076496f9d5759_Out_2, _Subtract_72c15d8c0496460ca2c6aaf585c41381_Out_2);
            float _Property_3a30c5a5cbf24fa6913c8ee537ee5f4b_Out_0 = _Fade_Depth;
            float _Divide_8b2505abc71b4c3f8954d6fb229e0865_Out_2;
            Unity_Divide_float(_Subtract_72c15d8c0496460ca2c6aaf585c41381_Out_2, _Property_3a30c5a5cbf24fa6913c8ee537ee5f4b_Out_0, _Divide_8b2505abc71b4c3f8954d6fb229e0865_Out_2);
            float _Saturate_3c60f55f62d842639e72ca2a20ce74df_Out_1;
            Unity_Saturate_float(_Divide_8b2505abc71b4c3f8954d6fb229e0865_Out_2, _Saturate_3c60f55f62d842639e72ca2a20ce74df_Out_1);
            surface.Alpha = _Saturate_3c60f55f62d842639e72ca2a20ce74df_Out_1;
            surface.AlphaClipThreshold = 0.5;
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
            output.WorldSpaceNormal =                           TransformObjectToWorldNormal(input.normalOS);
            output.ObjectSpaceTangent =                         input.tangentOS.xyz;
            output.ObjectSpacePosition =                        input.positionOS;
            output.WorldSpacePosition =                         TransformObjectToWorld(input.positionOS);
            output.TimeParameters =                             _TimeParameters.xyz;
        
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
        
            
        
        
        
        
        
            output.WorldSpacePosition = input.positionWS;
            output.ScreenPosition = ComputeScreenPos(TransformWorldToHClip(input.positionWS), _ProjectionParams.x);
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
    }
    SubShader
    {
        Tags
        {
            "RenderPipeline"="UniversalPipeline"
            "RenderType"="Transparent"
            "UniversalMaterialType" = "Unlit"
            "Queue"="Transparent"
            "ShaderGraphShader"="true"
            "ShaderGraphTargetId"="UniversalUnlitSubTarget"
        }
        Pass
        {
            Name "Universal Forward"
            Tags
            {
                // LightMode: <None>
            }
        
        // Render State
        Cull [_Cull]
        Blend [_SrcBlend] [_DstBlend]
        ZTest [_ZTest]

        //ZWrite [_ZWrite]
        //turning ZWrite ON
        ZWrite On
        
        // Debug
        // <None>
        
        // --------------------------------------------------
        // Pass
        
        HLSLPROGRAM
        
        // Pragmas
        #pragma target 2.0
        #pragma only_renderers gles gles3 glcore d3d11
        #pragma multi_compile_instancing
        #pragma multi_compile_fog
        #pragma instancing_options renderinglayer
        #pragma vertex vert
        #pragma fragment frag
        
        // DotsInstancingOptions: <None>
        // HybridV1InjectedBuiltinProperties: <None>
        
        // Keywords
        #pragma multi_compile _ LIGHTMAP_ON
        #pragma multi_compile _ DIRLIGHTMAP_COMBINED
        #pragma shader_feature _ _SAMPLE_GI
        #pragma multi_compile _ _DBUFFER_MRT1 _DBUFFER_MRT2 _DBUFFER_MRT3
        #pragma multi_compile _ DEBUG_DISPLAY
        #pragma shader_feature_fragment _ _SURFACE_TYPE_TRANSPARENT
        #pragma shader_feature_local_fragment _ _ALPHAPREMULTIPLY_ON
        #pragma shader_feature_local_fragment _ _ALPHATEST_ON
        // GraphKeywords: <None>
        
        // Defines
        
        #define ATTRIBUTES_NEED_NORMAL
        #define ATTRIBUTES_NEED_TANGENT
        #define VARYINGS_NEED_POSITION_WS
        #define VARYINGS_NEED_NORMAL_WS
        #define VARYINGS_NEED_VIEWDIRECTION_WS
        #define FEATURES_GRAPH_VERTEX
        /* WARNING: $splice Could not find named fragment 'PassInstancing' */
        #define SHADERPASS SHADERPASS_UNLIT
        #define _FOG_FRAGMENT 1
        #define REQUIRE_DEPTH_TEXTURE
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
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : INSTANCEID_SEMANTIC;
            #endif
        };
        struct Varyings
        {
             float4 positionCS : SV_POSITION;
             float3 positionWS;
             float3 normalWS;
             float3 viewDirectionWS;
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
             float3 WorldSpaceNormal;
             float3 WorldSpaceViewDirection;
             float3 WorldSpacePosition;
             float4 ScreenPosition;
             float3 TimeParameters;
        };
        struct VertexDescriptionInputs
        {
             float3 ObjectSpaceNormal;
             float3 WorldSpaceNormal;
             float3 ObjectSpaceTangent;
             float3 ObjectSpacePosition;
             float3 WorldSpacePosition;
             float3 TimeParameters;
        };
        struct PackedVaryings
        {
             float4 positionCS : SV_POSITION;
             float3 interp0 : INTERP0;
             float3 interp1 : INTERP1;
             float3 interp2 : INTERP2;
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
            output.interp2.xyz =  input.viewDirectionWS;
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
            output.viewDirectionWS = input.interp2.xyz;
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
        float4 _Rotate_Projection;
        float _Noise_Scale;
        float _Noise_Speed;
        float _Noise_Height;
        float4 _Noise_Remap;
        float4 _Colour_Peak;
        float4 _Colour_Valley;
        float _Noise_Edge_1;
        float _Noise_Edge_2;
        float _Noise_Power;
        float _Base_Scale;
        float _Base_Speed;
        float _Base_Strength;
        float _Emission;
        float _Curvature_Radius;
        float _Fresnel_Power;
        float _Fresnel_opacity;
        float _Fade_Depth;
        CBUFFER_END
        
        // Object and Global properties
        
        // Graph Includes
        // GraphIncludes: <None>
        
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
        
        void Unity_Distance_float3(float3 A, float3 B, out float Out)
        {
            Out = distance(A, B);
        }
        
        void Unity_Divide_float(float A, float B, out float Out)
        {
            Out = A / B;
        }
        
        void Unity_Power_float(float A, float B, out float Out)
        {
            Out = pow(A, B);
        }
        
        void Unity_Multiply_float3_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A * B;
        }
        
        void Unity_Rotate_About_Axis_Degrees_float(float3 In, float3 Axis, float Rotation, out float3 Out)
        {
            Rotation = radians(Rotation);
        
            float s = sin(Rotation);
            float c = cos(Rotation);
            float one_minus_c = 1.0 - c;
        
            Axis = normalize(Axis);
        
            float3x3 rot_mat = { one_minus_c * Axis.x * Axis.x + c,            one_minus_c * Axis.x * Axis.y - Axis.z * s,     one_minus_c * Axis.z * Axis.x + Axis.y * s,
                                      one_minus_c * Axis.x * Axis.y + Axis.z * s,   one_minus_c * Axis.y * Axis.y + c,              one_minus_c * Axis.y * Axis.z - Axis.x * s,
                                      one_minus_c * Axis.z * Axis.x - Axis.y * s,   one_minus_c * Axis.y * Axis.z + Axis.x * s,     one_minus_c * Axis.z * Axis.z + c
                                    };
        
            Out = mul(rot_mat,  In);
        }
        
        void Unity_Multiply_float_float(float A, float B, out float Out)
        {
            Out = A * B;
        }
        
        void Unity_TilingAndOffset_float(float2 UV, float2 Tiling, float2 Offset, out float2 Out)
        {
            Out = UV * Tiling + Offset;
        }
        
        
        float2 Unity_GradientNoise_Dir_float(float2 p)
        {
            // Permutation and hashing used in webgl-nosie goo.gl/pX7HtC
            p = p % 289;
            // need full precision, otherwise half overflows when p > 1
            float x = float(34 * p.x + 1) * p.x % 289 + p.y;
            x = (34 * x + 1) * x % 289;
            x = frac(x / 41) * 2 - 1;
            return normalize(float2(x - floor(x + 0.5), abs(x) - 0.5));
        }
        
        void Unity_GradientNoise_float(float2 UV, float Scale, out float Out)
        {
            float2 p = UV * Scale;
            float2 ip = floor(p);
            float2 fp = frac(p);
            float d00 = dot(Unity_GradientNoise_Dir_float(ip), fp);
            float d01 = dot(Unity_GradientNoise_Dir_float(ip + float2(0, 1)), fp - float2(0, 1));
            float d10 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 0)), fp - float2(1, 0));
            float d11 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 1)), fp - float2(1, 1));
            fp = fp * fp * fp * (fp * (fp * 6 - 15) + 10);
            Out = lerp(lerp(d00, d01, fp.y), lerp(d10, d11, fp.y), fp.x) + 0.5;
        }
        
        void Unity_Add_float(float A, float B, out float Out)
        {
            Out = A + B;
        }
        
        void Unity_Saturate_float(float In, out float Out)
        {
            Out = saturate(In);
        }
        
        void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
        {
            RGBA = float4(R, G, B, A);
            RGB = float3(R, G, B);
            RG = float2(R, G);
        }
        
        void Unity_Remap_float(float In, float2 InMinMax, float2 OutMinMax, out float Out)
        {
            Out = OutMinMax.x + (In - InMinMax.x) * (OutMinMax.y - OutMinMax.x) / (InMinMax.y - InMinMax.x);
        }
        
        void Unity_Absolute_float(float In, out float Out)
        {
            Out = abs(In);
        }
        
        void Unity_Smoothstep_float(float Edge1, float Edge2, float In, out float Out)
        {
            Out = smoothstep(Edge1, Edge2, In);
        }
        
        void Unity_Add_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A + B;
        }
        
        void Unity_Lerp_float4(float4 A, float4 B, float4 T, out float4 Out)
        {
            Out = lerp(A, B, T);
        }
        
        void Unity_FresnelEffect_float(float3 Normal, float3 ViewDir, float Power, out float Out)
        {
            Out = pow((1.0 - saturate(dot(normalize(Normal), normalize(ViewDir)))), Power);
        }
        
        void Unity_Add_float4(float4 A, float4 B, out float4 Out)
        {
            Out = A + B;
        }
        
        void Unity_SceneDepth_Eye_float(float4 UV, out float Out)
        {
            if (unity_OrthoParams.w == 1.0)
            {
                Out = LinearEyeDepth(ComputeWorldSpacePosition(UV.xy, SHADERGRAPH_SAMPLE_SCENE_DEPTH(UV.xy), UNITY_MATRIX_I_VP), UNITY_MATRIX_V);
            }
            else
            {
                Out = LinearEyeDepth(SHADERGRAPH_SAMPLE_SCENE_DEPTH(UV.xy), _ZBufferParams);
            }
        }
        
        void Unity_Subtract_float(float A, float B, out float Out)
        {
            Out = A - B;
        }
        
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
            float _Distance_c01ba79505ea4a8891c3da5756fe9e5a_Out_2;
            Unity_Distance_float3(SHADERGRAPH_OBJECT_POSITION, IN.WorldSpacePosition, _Distance_c01ba79505ea4a8891c3da5756fe9e5a_Out_2);
            float _Property_d1be4d71eb4e4aae9337b9b402f45d63_Out_0 = _Curvature_Radius;
            float _Divide_03646e2359744ec38397913fc1d7c270_Out_2;
            Unity_Divide_float(_Distance_c01ba79505ea4a8891c3da5756fe9e5a_Out_2, _Property_d1be4d71eb4e4aae9337b9b402f45d63_Out_0, _Divide_03646e2359744ec38397913fc1d7c270_Out_2);
            float _Power_07f0eac51f1244fbb5c4966f586ac4dc_Out_2;
            Unity_Power_float(_Divide_03646e2359744ec38397913fc1d7c270_Out_2, 3, _Power_07f0eac51f1244fbb5c4966f586ac4dc_Out_2);
            float3 _Multiply_5ca41a1165784fbe980a8c3177fad7e1_Out_2;
            Unity_Multiply_float3_float3(IN.WorldSpaceNormal, (_Power_07f0eac51f1244fbb5c4966f586ac4dc_Out_2.xxx), _Multiply_5ca41a1165784fbe980a8c3177fad7e1_Out_2);
            float _Property_ef386ec2d5f4434a8a5f934ff230322f_Out_0 = _Noise_Edge_1;
            float _Property_147f1a2515e04a399eed34de35cf1107_Out_0 = _Noise_Edge_2;
            float4 _Property_b84368a6bae8433994c8bf5d771c01f4_Out_0 = _Rotate_Projection;
            float _Split_31db8d949ab24fd1b5ded76e6ecb6868_R_1 = _Property_b84368a6bae8433994c8bf5d771c01f4_Out_0[0];
            float _Split_31db8d949ab24fd1b5ded76e6ecb6868_G_2 = _Property_b84368a6bae8433994c8bf5d771c01f4_Out_0[1];
            float _Split_31db8d949ab24fd1b5ded76e6ecb6868_B_3 = _Property_b84368a6bae8433994c8bf5d771c01f4_Out_0[2];
            float _Split_31db8d949ab24fd1b5ded76e6ecb6868_A_4 = _Property_b84368a6bae8433994c8bf5d771c01f4_Out_0[3];
            float3 _RotateAboutAxis_6e7d2784bd02405faeb7bacb567d0731_Out_3;
            Unity_Rotate_About_Axis_Degrees_float(IN.WorldSpacePosition, (_Property_b84368a6bae8433994c8bf5d771c01f4_Out_0.xyz), _Split_31db8d949ab24fd1b5ded76e6ecb6868_A_4, _RotateAboutAxis_6e7d2784bd02405faeb7bacb567d0731_Out_3);
            float _Property_1b5acb9aca4b4c1ca8150917cb29e38d_Out_0 = _Noise_Speed;
            float _Multiply_a1f01de168c5412e848fa5a9a4f633d8_Out_2;
            Unity_Multiply_float_float(IN.TimeParameters.x, _Property_1b5acb9aca4b4c1ca8150917cb29e38d_Out_0, _Multiply_a1f01de168c5412e848fa5a9a4f633d8_Out_2);
            float2 _TilingAndOffset_3a22eccd71474e639594fce72cde2d02_Out_3;
            Unity_TilingAndOffset_float((_RotateAboutAxis_6e7d2784bd02405faeb7bacb567d0731_Out_3.xy), float2 (1, 1), (_Multiply_a1f01de168c5412e848fa5a9a4f633d8_Out_2.xx), _TilingAndOffset_3a22eccd71474e639594fce72cde2d02_Out_3);
            float _Property_e34f89cb08684afb94f0ac41ba675b11_Out_0 = _Noise_Scale;
            float _GradientNoise_71dea3d8ca7f493a820838ec4624d407_Out_2;
            Unity_GradientNoise_float(_TilingAndOffset_3a22eccd71474e639594fce72cde2d02_Out_3, _Property_e34f89cb08684afb94f0ac41ba675b11_Out_0, _GradientNoise_71dea3d8ca7f493a820838ec4624d407_Out_2);
            float2 _TilingAndOffset_b402f80311694eb4b5a4c3d07e71c615_Out_3;
            Unity_TilingAndOffset_float((_RotateAboutAxis_6e7d2784bd02405faeb7bacb567d0731_Out_3.xy), float2 (1, 1), float2 (0, 0), _TilingAndOffset_b402f80311694eb4b5a4c3d07e71c615_Out_3);
            float _GradientNoise_7cfc31faa781410090b11ae418c9e103_Out_2;
            Unity_GradientNoise_float(_TilingAndOffset_b402f80311694eb4b5a4c3d07e71c615_Out_3, _Property_e34f89cb08684afb94f0ac41ba675b11_Out_0, _GradientNoise_7cfc31faa781410090b11ae418c9e103_Out_2);
            float _Add_8d3a946d8f7848c0a6a4ee9e280c511d_Out_2;
            Unity_Add_float(_GradientNoise_71dea3d8ca7f493a820838ec4624d407_Out_2, _GradientNoise_7cfc31faa781410090b11ae418c9e103_Out_2, _Add_8d3a946d8f7848c0a6a4ee9e280c511d_Out_2);
            float _Divide_883697060c4b42898d76bc5325a5b568_Out_2;
            Unity_Divide_float(_Add_8d3a946d8f7848c0a6a4ee9e280c511d_Out_2, 2, _Divide_883697060c4b42898d76bc5325a5b568_Out_2);
            float _Saturate_c96331ef3b2642d39a446bce3d43f560_Out_1;
            Unity_Saturate_float(_Divide_883697060c4b42898d76bc5325a5b568_Out_2, _Saturate_c96331ef3b2642d39a446bce3d43f560_Out_1);
            float _Property_a5e2c659762f49e2826023553b233885_Out_0 = _Noise_Power;
            float _Power_fe5fa4a062ff4bac868501be2a7f055c_Out_2;
            Unity_Power_float(_Saturate_c96331ef3b2642d39a446bce3d43f560_Out_1, _Property_a5e2c659762f49e2826023553b233885_Out_0, _Power_fe5fa4a062ff4bac868501be2a7f055c_Out_2);
            float4 _Property_f466dd4679cc4567b14cecb45e839124_Out_0 = _Noise_Remap;
            float _Split_cfe4e3a30c93414694a4d7e49c708985_R_1 = _Property_f466dd4679cc4567b14cecb45e839124_Out_0[0];
            float _Split_cfe4e3a30c93414694a4d7e49c708985_G_2 = _Property_f466dd4679cc4567b14cecb45e839124_Out_0[1];
            float _Split_cfe4e3a30c93414694a4d7e49c708985_B_3 = _Property_f466dd4679cc4567b14cecb45e839124_Out_0[2];
            float _Split_cfe4e3a30c93414694a4d7e49c708985_A_4 = _Property_f466dd4679cc4567b14cecb45e839124_Out_0[3];
            float4 _Combine_c045c4c659354461848cd6c7d61e4be5_RGBA_4;
            float3 _Combine_c045c4c659354461848cd6c7d61e4be5_RGB_5;
            float2 _Combine_c045c4c659354461848cd6c7d61e4be5_RG_6;
            Unity_Combine_float(_Split_cfe4e3a30c93414694a4d7e49c708985_R_1, _Split_cfe4e3a30c93414694a4d7e49c708985_G_2, 0, 0, _Combine_c045c4c659354461848cd6c7d61e4be5_RGBA_4, _Combine_c045c4c659354461848cd6c7d61e4be5_RGB_5, _Combine_c045c4c659354461848cd6c7d61e4be5_RG_6);
            float4 _Combine_6de15c52675e489b874b27eaf16323df_RGBA_4;
            float3 _Combine_6de15c52675e489b874b27eaf16323df_RGB_5;
            float2 _Combine_6de15c52675e489b874b27eaf16323df_RG_6;
            Unity_Combine_float(_Split_cfe4e3a30c93414694a4d7e49c708985_B_3, _Split_cfe4e3a30c93414694a4d7e49c708985_A_4, 0, 0, _Combine_6de15c52675e489b874b27eaf16323df_RGBA_4, _Combine_6de15c52675e489b874b27eaf16323df_RGB_5, _Combine_6de15c52675e489b874b27eaf16323df_RG_6);
            float _Remap_192e92b0649c4e009e825f27b2499763_Out_3;
            Unity_Remap_float(_Power_fe5fa4a062ff4bac868501be2a7f055c_Out_2, _Combine_c045c4c659354461848cd6c7d61e4be5_RG_6, _Combine_6de15c52675e489b874b27eaf16323df_RG_6, _Remap_192e92b0649c4e009e825f27b2499763_Out_3);
            float _Absolute_d5fceabb74744431b85e0fdda3c8cf5c_Out_1;
            Unity_Absolute_float(_Remap_192e92b0649c4e009e825f27b2499763_Out_3, _Absolute_d5fceabb74744431b85e0fdda3c8cf5c_Out_1);
            float _Smoothstep_5b3511aa53f74a73b9b9614372a6af74_Out_3;
            Unity_Smoothstep_float(_Property_ef386ec2d5f4434a8a5f934ff230322f_Out_0, _Property_147f1a2515e04a399eed34de35cf1107_Out_0, _Absolute_d5fceabb74744431b85e0fdda3c8cf5c_Out_1, _Smoothstep_5b3511aa53f74a73b9b9614372a6af74_Out_3);
            float _Property_8fb0c3dbf4a84403a6068e70183a7ea4_Out_0 = _Base_Speed;
            float _Multiply_774f493cd66541e7ba6553802a499b79_Out_2;
            Unity_Multiply_float_float(IN.TimeParameters.x, _Property_8fb0c3dbf4a84403a6068e70183a7ea4_Out_0, _Multiply_774f493cd66541e7ba6553802a499b79_Out_2);
            float2 _TilingAndOffset_969b7b642fd04ed7b2592123a03eca18_Out_3;
            Unity_TilingAndOffset_float((_RotateAboutAxis_6e7d2784bd02405faeb7bacb567d0731_Out_3.xy), float2 (1, 1), (_Multiply_774f493cd66541e7ba6553802a499b79_Out_2.xx), _TilingAndOffset_969b7b642fd04ed7b2592123a03eca18_Out_3);
            float _Property_e3b00c3a5e804e14a1e03e69aac49211_Out_0 = _Base_Scale;
            float _GradientNoise_04262dfbc1b540b1a9d9b997627f189b_Out_2;
            Unity_GradientNoise_float(_TilingAndOffset_969b7b642fd04ed7b2592123a03eca18_Out_3, _Property_e3b00c3a5e804e14a1e03e69aac49211_Out_0, _GradientNoise_04262dfbc1b540b1a9d9b997627f189b_Out_2);
            float _Property_17938a6d7e2f40dd8d0f1b984a9fbb59_Out_0 = _Base_Strength;
            float _Multiply_0854b1bc83aa4170a68f058b8cb96ff7_Out_2;
            Unity_Multiply_float_float(_GradientNoise_04262dfbc1b540b1a9d9b997627f189b_Out_2, _Property_17938a6d7e2f40dd8d0f1b984a9fbb59_Out_0, _Multiply_0854b1bc83aa4170a68f058b8cb96ff7_Out_2);
            float _Add_f82d9f056cbf456f911125a9574d865f_Out_2;
            Unity_Add_float(_Smoothstep_5b3511aa53f74a73b9b9614372a6af74_Out_3, _Multiply_0854b1bc83aa4170a68f058b8cb96ff7_Out_2, _Add_f82d9f056cbf456f911125a9574d865f_Out_2);
            float _Add_df54866b810e4151a1fde09a51f17b65_Out_2;
            Unity_Add_float(1, _Property_17938a6d7e2f40dd8d0f1b984a9fbb59_Out_0, _Add_df54866b810e4151a1fde09a51f17b65_Out_2);
            float _Divide_b2c87465e89040e4940d7d7f42943c3f_Out_2;
            Unity_Divide_float(_Add_f82d9f056cbf456f911125a9574d865f_Out_2, _Add_df54866b810e4151a1fde09a51f17b65_Out_2, _Divide_b2c87465e89040e4940d7d7f42943c3f_Out_2);
            float3 _Multiply_cc4eb1139ae74d4c85067f5171acc955_Out_2;
            Unity_Multiply_float3_float3(IN.ObjectSpaceNormal, (_Divide_b2c87465e89040e4940d7d7f42943c3f_Out_2.xxx), _Multiply_cc4eb1139ae74d4c85067f5171acc955_Out_2);
            float _Property_611696cf692e4bb19aaf7739c57cdd44_Out_0 = _Noise_Height;
            float3 _Multiply_da4791b114e34eceac3bacbb1043285e_Out_2;
            Unity_Multiply_float3_float3(_Multiply_cc4eb1139ae74d4c85067f5171acc955_Out_2, (_Property_611696cf692e4bb19aaf7739c57cdd44_Out_0.xxx), _Multiply_da4791b114e34eceac3bacbb1043285e_Out_2);
            float3 _Add_1af6468ff1e344348b74bd929f252cbf_Out_2;
            Unity_Add_float3(IN.ObjectSpacePosition, _Multiply_da4791b114e34eceac3bacbb1043285e_Out_2, _Add_1af6468ff1e344348b74bd929f252cbf_Out_2);
            float3 _Add_c7842509b95b4858bfbf1f91fea0a4c3_Out_2;
            Unity_Add_float3(_Multiply_5ca41a1165784fbe980a8c3177fad7e1_Out_2, _Add_1af6468ff1e344348b74bd929f252cbf_Out_2, _Add_c7842509b95b4858bfbf1f91fea0a4c3_Out_2);
            description.Position = _Add_c7842509b95b4858bfbf1f91fea0a4c3_Out_2;
            description.Normal = IN.ObjectSpaceNormal;
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
            float Alpha;
            float AlphaClipThreshold;
        };
        
        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            float4 _Property_f70ef70650bc4abe8a4358f10ab5f59a_Out_0 = _Colour_Peak;
            float4 _Property_cf745efc5da64fe1acadd633d86b5954_Out_0 = _Colour_Valley;
            float _Property_ef386ec2d5f4434a8a5f934ff230322f_Out_0 = _Noise_Edge_1;
            float _Property_147f1a2515e04a399eed34de35cf1107_Out_0 = _Noise_Edge_2;
            float4 _Property_b84368a6bae8433994c8bf5d771c01f4_Out_0 = _Rotate_Projection;
            float _Split_31db8d949ab24fd1b5ded76e6ecb6868_R_1 = _Property_b84368a6bae8433994c8bf5d771c01f4_Out_0[0];
            float _Split_31db8d949ab24fd1b5ded76e6ecb6868_G_2 = _Property_b84368a6bae8433994c8bf5d771c01f4_Out_0[1];
            float _Split_31db8d949ab24fd1b5ded76e6ecb6868_B_3 = _Property_b84368a6bae8433994c8bf5d771c01f4_Out_0[2];
            float _Split_31db8d949ab24fd1b5ded76e6ecb6868_A_4 = _Property_b84368a6bae8433994c8bf5d771c01f4_Out_0[3];
            float3 _RotateAboutAxis_6e7d2784bd02405faeb7bacb567d0731_Out_3;
            Unity_Rotate_About_Axis_Degrees_float(IN.WorldSpacePosition, (_Property_b84368a6bae8433994c8bf5d771c01f4_Out_0.xyz), _Split_31db8d949ab24fd1b5ded76e6ecb6868_A_4, _RotateAboutAxis_6e7d2784bd02405faeb7bacb567d0731_Out_3);
            float _Property_1b5acb9aca4b4c1ca8150917cb29e38d_Out_0 = _Noise_Speed;
            float _Multiply_a1f01de168c5412e848fa5a9a4f633d8_Out_2;
            Unity_Multiply_float_float(IN.TimeParameters.x, _Property_1b5acb9aca4b4c1ca8150917cb29e38d_Out_0, _Multiply_a1f01de168c5412e848fa5a9a4f633d8_Out_2);
            float2 _TilingAndOffset_3a22eccd71474e639594fce72cde2d02_Out_3;
            Unity_TilingAndOffset_float((_RotateAboutAxis_6e7d2784bd02405faeb7bacb567d0731_Out_3.xy), float2 (1, 1), (_Multiply_a1f01de168c5412e848fa5a9a4f633d8_Out_2.xx), _TilingAndOffset_3a22eccd71474e639594fce72cde2d02_Out_3);
            float _Property_e34f89cb08684afb94f0ac41ba675b11_Out_0 = _Noise_Scale;
            float _GradientNoise_71dea3d8ca7f493a820838ec4624d407_Out_2;
            Unity_GradientNoise_float(_TilingAndOffset_3a22eccd71474e639594fce72cde2d02_Out_3, _Property_e34f89cb08684afb94f0ac41ba675b11_Out_0, _GradientNoise_71dea3d8ca7f493a820838ec4624d407_Out_2);
            float2 _TilingAndOffset_b402f80311694eb4b5a4c3d07e71c615_Out_3;
            Unity_TilingAndOffset_float((_RotateAboutAxis_6e7d2784bd02405faeb7bacb567d0731_Out_3.xy), float2 (1, 1), float2 (0, 0), _TilingAndOffset_b402f80311694eb4b5a4c3d07e71c615_Out_3);
            float _GradientNoise_7cfc31faa781410090b11ae418c9e103_Out_2;
            Unity_GradientNoise_float(_TilingAndOffset_b402f80311694eb4b5a4c3d07e71c615_Out_3, _Property_e34f89cb08684afb94f0ac41ba675b11_Out_0, _GradientNoise_7cfc31faa781410090b11ae418c9e103_Out_2);
            float _Add_8d3a946d8f7848c0a6a4ee9e280c511d_Out_2;
            Unity_Add_float(_GradientNoise_71dea3d8ca7f493a820838ec4624d407_Out_2, _GradientNoise_7cfc31faa781410090b11ae418c9e103_Out_2, _Add_8d3a946d8f7848c0a6a4ee9e280c511d_Out_2);
            float _Divide_883697060c4b42898d76bc5325a5b568_Out_2;
            Unity_Divide_float(_Add_8d3a946d8f7848c0a6a4ee9e280c511d_Out_2, 2, _Divide_883697060c4b42898d76bc5325a5b568_Out_2);
            float _Saturate_c96331ef3b2642d39a446bce3d43f560_Out_1;
            Unity_Saturate_float(_Divide_883697060c4b42898d76bc5325a5b568_Out_2, _Saturate_c96331ef3b2642d39a446bce3d43f560_Out_1);
            float _Property_a5e2c659762f49e2826023553b233885_Out_0 = _Noise_Power;
            float _Power_fe5fa4a062ff4bac868501be2a7f055c_Out_2;
            Unity_Power_float(_Saturate_c96331ef3b2642d39a446bce3d43f560_Out_1, _Property_a5e2c659762f49e2826023553b233885_Out_0, _Power_fe5fa4a062ff4bac868501be2a7f055c_Out_2);
            float4 _Property_f466dd4679cc4567b14cecb45e839124_Out_0 = _Noise_Remap;
            float _Split_cfe4e3a30c93414694a4d7e49c708985_R_1 = _Property_f466dd4679cc4567b14cecb45e839124_Out_0[0];
            float _Split_cfe4e3a30c93414694a4d7e49c708985_G_2 = _Property_f466dd4679cc4567b14cecb45e839124_Out_0[1];
            float _Split_cfe4e3a30c93414694a4d7e49c708985_B_3 = _Property_f466dd4679cc4567b14cecb45e839124_Out_0[2];
            float _Split_cfe4e3a30c93414694a4d7e49c708985_A_4 = _Property_f466dd4679cc4567b14cecb45e839124_Out_0[3];
            float4 _Combine_c045c4c659354461848cd6c7d61e4be5_RGBA_4;
            float3 _Combine_c045c4c659354461848cd6c7d61e4be5_RGB_5;
            float2 _Combine_c045c4c659354461848cd6c7d61e4be5_RG_6;
            Unity_Combine_float(_Split_cfe4e3a30c93414694a4d7e49c708985_R_1, _Split_cfe4e3a30c93414694a4d7e49c708985_G_2, 0, 0, _Combine_c045c4c659354461848cd6c7d61e4be5_RGBA_4, _Combine_c045c4c659354461848cd6c7d61e4be5_RGB_5, _Combine_c045c4c659354461848cd6c7d61e4be5_RG_6);
            float4 _Combine_6de15c52675e489b874b27eaf16323df_RGBA_4;
            float3 _Combine_6de15c52675e489b874b27eaf16323df_RGB_5;
            float2 _Combine_6de15c52675e489b874b27eaf16323df_RG_6;
            Unity_Combine_float(_Split_cfe4e3a30c93414694a4d7e49c708985_B_3, _Split_cfe4e3a30c93414694a4d7e49c708985_A_4, 0, 0, _Combine_6de15c52675e489b874b27eaf16323df_RGBA_4, _Combine_6de15c52675e489b874b27eaf16323df_RGB_5, _Combine_6de15c52675e489b874b27eaf16323df_RG_6);
            float _Remap_192e92b0649c4e009e825f27b2499763_Out_3;
            Unity_Remap_float(_Power_fe5fa4a062ff4bac868501be2a7f055c_Out_2, _Combine_c045c4c659354461848cd6c7d61e4be5_RG_6, _Combine_6de15c52675e489b874b27eaf16323df_RG_6, _Remap_192e92b0649c4e009e825f27b2499763_Out_3);
            float _Absolute_d5fceabb74744431b85e0fdda3c8cf5c_Out_1;
            Unity_Absolute_float(_Remap_192e92b0649c4e009e825f27b2499763_Out_3, _Absolute_d5fceabb74744431b85e0fdda3c8cf5c_Out_1);
            float _Smoothstep_5b3511aa53f74a73b9b9614372a6af74_Out_3;
            Unity_Smoothstep_float(_Property_ef386ec2d5f4434a8a5f934ff230322f_Out_0, _Property_147f1a2515e04a399eed34de35cf1107_Out_0, _Absolute_d5fceabb74744431b85e0fdda3c8cf5c_Out_1, _Smoothstep_5b3511aa53f74a73b9b9614372a6af74_Out_3);
            float _Property_8fb0c3dbf4a84403a6068e70183a7ea4_Out_0 = _Base_Speed;
            float _Multiply_774f493cd66541e7ba6553802a499b79_Out_2;
            Unity_Multiply_float_float(IN.TimeParameters.x, _Property_8fb0c3dbf4a84403a6068e70183a7ea4_Out_0, _Multiply_774f493cd66541e7ba6553802a499b79_Out_2);
            float2 _TilingAndOffset_969b7b642fd04ed7b2592123a03eca18_Out_3;
            Unity_TilingAndOffset_float((_RotateAboutAxis_6e7d2784bd02405faeb7bacb567d0731_Out_3.xy), float2 (1, 1), (_Multiply_774f493cd66541e7ba6553802a499b79_Out_2.xx), _TilingAndOffset_969b7b642fd04ed7b2592123a03eca18_Out_3);
            float _Property_e3b00c3a5e804e14a1e03e69aac49211_Out_0 = _Base_Scale;
            float _GradientNoise_04262dfbc1b540b1a9d9b997627f189b_Out_2;
            Unity_GradientNoise_float(_TilingAndOffset_969b7b642fd04ed7b2592123a03eca18_Out_3, _Property_e3b00c3a5e804e14a1e03e69aac49211_Out_0, _GradientNoise_04262dfbc1b540b1a9d9b997627f189b_Out_2);
            float _Property_17938a6d7e2f40dd8d0f1b984a9fbb59_Out_0 = _Base_Strength;
            float _Multiply_0854b1bc83aa4170a68f058b8cb96ff7_Out_2;
            Unity_Multiply_float_float(_GradientNoise_04262dfbc1b540b1a9d9b997627f189b_Out_2, _Property_17938a6d7e2f40dd8d0f1b984a9fbb59_Out_0, _Multiply_0854b1bc83aa4170a68f058b8cb96ff7_Out_2);
            float _Add_f82d9f056cbf456f911125a9574d865f_Out_2;
            Unity_Add_float(_Smoothstep_5b3511aa53f74a73b9b9614372a6af74_Out_3, _Multiply_0854b1bc83aa4170a68f058b8cb96ff7_Out_2, _Add_f82d9f056cbf456f911125a9574d865f_Out_2);
            float _Add_df54866b810e4151a1fde09a51f17b65_Out_2;
            Unity_Add_float(1, _Property_17938a6d7e2f40dd8d0f1b984a9fbb59_Out_0, _Add_df54866b810e4151a1fde09a51f17b65_Out_2);
            float _Divide_b2c87465e89040e4940d7d7f42943c3f_Out_2;
            Unity_Divide_float(_Add_f82d9f056cbf456f911125a9574d865f_Out_2, _Add_df54866b810e4151a1fde09a51f17b65_Out_2, _Divide_b2c87465e89040e4940d7d7f42943c3f_Out_2);
            float4 _Lerp_e1c7d9cabc824317b0da8bea40147de4_Out_3;
            Unity_Lerp_float4(_Property_f70ef70650bc4abe8a4358f10ab5f59a_Out_0, _Property_cf745efc5da64fe1acadd633d86b5954_Out_0, (_Divide_b2c87465e89040e4940d7d7f42943c3f_Out_2.xxxx), _Lerp_e1c7d9cabc824317b0da8bea40147de4_Out_3);
            float _Property_33a66f4a3f464542bc2e9201073e6268_Out_0 = _Fresnel_Power;
            float _FresnelEffect_cda7894954cb4589a28e6bdcbd021fde_Out_3;
            Unity_FresnelEffect_float(IN.WorldSpaceNormal, IN.WorldSpaceViewDirection, _Property_33a66f4a3f464542bc2e9201073e6268_Out_0, _FresnelEffect_cda7894954cb4589a28e6bdcbd021fde_Out_3);
            float _Multiply_829db86855944f02b1729d284dda1e98_Out_2;
            Unity_Multiply_float_float(_Divide_b2c87465e89040e4940d7d7f42943c3f_Out_2, _FresnelEffect_cda7894954cb4589a28e6bdcbd021fde_Out_3, _Multiply_829db86855944f02b1729d284dda1e98_Out_2);
            float _Property_f436e175694f4bcc91263ca02ecd0089_Out_0 = _Fresnel_opacity;
            float _Multiply_36396cf8d2ff40a7aeb44aa7c649cd87_Out_2;
            Unity_Multiply_float_float(_Multiply_829db86855944f02b1729d284dda1e98_Out_2, _Property_f436e175694f4bcc91263ca02ecd0089_Out_0, _Multiply_36396cf8d2ff40a7aeb44aa7c649cd87_Out_2);
            float4 _Add_3f758469690e403892df2e9b5577bcda_Out_2;
            Unity_Add_float4(_Lerp_e1c7d9cabc824317b0da8bea40147de4_Out_3, (_Multiply_36396cf8d2ff40a7aeb44aa7c649cd87_Out_2.xxxx), _Add_3f758469690e403892df2e9b5577bcda_Out_2);
            float _SceneDepth_92d0d826f11444f38ddac1aa18b54491_Out_1;
            Unity_SceneDepth_Eye_float(float4(IN.ScreenPosition.xy / IN.ScreenPosition.w, 0, 0), _SceneDepth_92d0d826f11444f38ddac1aa18b54491_Out_1);
            float4 _ScreenPosition_a43e7cd4d3c742149035c252ba0d4ec9_Out_0 = IN.ScreenPosition;
            float _Split_945e233c5d5644b39c8f24743ae9b880_R_1 = _ScreenPosition_a43e7cd4d3c742149035c252ba0d4ec9_Out_0[0];
            float _Split_945e233c5d5644b39c8f24743ae9b880_G_2 = _ScreenPosition_a43e7cd4d3c742149035c252ba0d4ec9_Out_0[1];
            float _Split_945e233c5d5644b39c8f24743ae9b880_B_3 = _ScreenPosition_a43e7cd4d3c742149035c252ba0d4ec9_Out_0[2];
            float _Split_945e233c5d5644b39c8f24743ae9b880_A_4 = _ScreenPosition_a43e7cd4d3c742149035c252ba0d4ec9_Out_0[3];
            float _Subtract_509aa90668e7408bad7076496f9d5759_Out_2;
            Unity_Subtract_float(_Split_945e233c5d5644b39c8f24743ae9b880_A_4, 1, _Subtract_509aa90668e7408bad7076496f9d5759_Out_2);
            float _Subtract_72c15d8c0496460ca2c6aaf585c41381_Out_2;
            Unity_Subtract_float(_SceneDepth_92d0d826f11444f38ddac1aa18b54491_Out_1, _Subtract_509aa90668e7408bad7076496f9d5759_Out_2, _Subtract_72c15d8c0496460ca2c6aaf585c41381_Out_2);
            float _Property_3a30c5a5cbf24fa6913c8ee537ee5f4b_Out_0 = _Fade_Depth;
            float _Divide_8b2505abc71b4c3f8954d6fb229e0865_Out_2;
            Unity_Divide_float(_Subtract_72c15d8c0496460ca2c6aaf585c41381_Out_2, _Property_3a30c5a5cbf24fa6913c8ee537ee5f4b_Out_0, _Divide_8b2505abc71b4c3f8954d6fb229e0865_Out_2);
            float _Saturate_3c60f55f62d842639e72ca2a20ce74df_Out_1;
            Unity_Saturate_float(_Divide_8b2505abc71b4c3f8954d6fb229e0865_Out_2, _Saturate_3c60f55f62d842639e72ca2a20ce74df_Out_1);
            surface.BaseColor = (_Add_3f758469690e403892df2e9b5577bcda_Out_2.xyz);
            surface.Alpha = _Saturate_3c60f55f62d842639e72ca2a20ce74df_Out_1;
            surface.AlphaClipThreshold = 0.5;
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
            output.WorldSpaceNormal =                           TransformObjectToWorldNormal(input.normalOS);
            output.ObjectSpaceTangent =                         input.tangentOS.xyz;
            output.ObjectSpacePosition =                        input.positionOS;
            output.WorldSpacePosition =                         TransformObjectToWorld(input.positionOS);
            output.TimeParameters =                             _TimeParameters.xyz;
        
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
        
            
        
            // must use interpolated tangent, bitangent and normal before they are normalized in the pixel shader.
            float3 unnormalizedNormalWS = input.normalWS;
            const float renormFactor = 1.0 / length(unnormalizedNormalWS);
        
        
            output.WorldSpaceNormal = renormFactor * input.normalWS.xyz;      // we want a unit length Normal Vector node in shader graph
        
        
            output.WorldSpaceViewDirection = normalize(input.viewDirectionWS);
            output.WorldSpacePosition = input.positionWS;
            output.ScreenPosition = ComputeScreenPos(TransformWorldToHClip(input.positionWS), _ProjectionParams.x);
            output.TimeParameters = _TimeParameters.xyz; // This is mainly for LW as HD overwrite this value
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
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/UnlitPass.hlsl"
        
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
        Cull [_Cull]
        ZTest LEqual
        ZWrite On
        ColorMask 0
        
        // Debug
        // <None>
        
        // --------------------------------------------------
        // Pass
        
        HLSLPROGRAM
        
        // Pragmas
        #pragma target 2.0
        #pragma only_renderers gles gles3 glcore d3d11
        #pragma multi_compile_instancing
        #pragma vertex vert
        #pragma fragment frag
        
        // DotsInstancingOptions: <None>
        // HybridV1InjectedBuiltinProperties: <None>
        
        // Keywords
        #pragma shader_feature_local_fragment _ _ALPHATEST_ON
        // GraphKeywords: <None>
        
        // Defines
        
        #define ATTRIBUTES_NEED_NORMAL
        #define ATTRIBUTES_NEED_TANGENT
        #define VARYINGS_NEED_POSITION_WS
        #define FEATURES_GRAPH_VERTEX
        /* WARNING: $splice Could not find named fragment 'PassInstancing' */
        #define SHADERPASS SHADERPASS_DEPTHONLY
        #define REQUIRE_DEPTH_TEXTURE
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
             float3 positionWS;
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
             float3 WorldSpacePosition;
             float4 ScreenPosition;
        };
        struct VertexDescriptionInputs
        {
             float3 ObjectSpaceNormal;
             float3 WorldSpaceNormal;
             float3 ObjectSpaceTangent;
             float3 ObjectSpacePosition;
             float3 WorldSpacePosition;
             float3 TimeParameters;
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
            output.interp0.xyz =  input.positionWS;
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
        float4 _Rotate_Projection;
        float _Noise_Scale;
        float _Noise_Speed;
        float _Noise_Height;
        float4 _Noise_Remap;
        float4 _Colour_Peak;
        float4 _Colour_Valley;
        float _Noise_Edge_1;
        float _Noise_Edge_2;
        float _Noise_Power;
        float _Base_Scale;
        float _Base_Speed;
        float _Base_Strength;
        float _Emission;
        float _Curvature_Radius;
        float _Fresnel_Power;
        float _Fresnel_opacity;
        float _Fade_Depth;
        CBUFFER_END
        
        // Object and Global properties
        
        // Graph Includes
        // GraphIncludes: <None>
        
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
        
        void Unity_Distance_float3(float3 A, float3 B, out float Out)
        {
            Out = distance(A, B);
        }
        
        void Unity_Divide_float(float A, float B, out float Out)
        {
            Out = A / B;
        }
        
        void Unity_Power_float(float A, float B, out float Out)
        {
            Out = pow(A, B);
        }
        
        void Unity_Multiply_float3_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A * B;
        }
        
        void Unity_Rotate_About_Axis_Degrees_float(float3 In, float3 Axis, float Rotation, out float3 Out)
        {
            Rotation = radians(Rotation);
        
            float s = sin(Rotation);
            float c = cos(Rotation);
            float one_minus_c = 1.0 - c;
        
            Axis = normalize(Axis);
        
            float3x3 rot_mat = { one_minus_c * Axis.x * Axis.x + c,            one_minus_c * Axis.x * Axis.y - Axis.z * s,     one_minus_c * Axis.z * Axis.x + Axis.y * s,
                                      one_minus_c * Axis.x * Axis.y + Axis.z * s,   one_minus_c * Axis.y * Axis.y + c,              one_minus_c * Axis.y * Axis.z - Axis.x * s,
                                      one_minus_c * Axis.z * Axis.x - Axis.y * s,   one_minus_c * Axis.y * Axis.z + Axis.x * s,     one_minus_c * Axis.z * Axis.z + c
                                    };
        
            Out = mul(rot_mat,  In);
        }
        
        void Unity_Multiply_float_float(float A, float B, out float Out)
        {
            Out = A * B;
        }
        
        void Unity_TilingAndOffset_float(float2 UV, float2 Tiling, float2 Offset, out float2 Out)
        {
            Out = UV * Tiling + Offset;
        }
        
        
        float2 Unity_GradientNoise_Dir_float(float2 p)
        {
            // Permutation and hashing used in webgl-nosie goo.gl/pX7HtC
            p = p % 289;
            // need full precision, otherwise half overflows when p > 1
            float x = float(34 * p.x + 1) * p.x % 289 + p.y;
            x = (34 * x + 1) * x % 289;
            x = frac(x / 41) * 2 - 1;
            return normalize(float2(x - floor(x + 0.5), abs(x) - 0.5));
        }
        
        void Unity_GradientNoise_float(float2 UV, float Scale, out float Out)
        {
            float2 p = UV * Scale;
            float2 ip = floor(p);
            float2 fp = frac(p);
            float d00 = dot(Unity_GradientNoise_Dir_float(ip), fp);
            float d01 = dot(Unity_GradientNoise_Dir_float(ip + float2(0, 1)), fp - float2(0, 1));
            float d10 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 0)), fp - float2(1, 0));
            float d11 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 1)), fp - float2(1, 1));
            fp = fp * fp * fp * (fp * (fp * 6 - 15) + 10);
            Out = lerp(lerp(d00, d01, fp.y), lerp(d10, d11, fp.y), fp.x) + 0.5;
        }
        
        void Unity_Add_float(float A, float B, out float Out)
        {
            Out = A + B;
        }
        
        void Unity_Saturate_float(float In, out float Out)
        {
            Out = saturate(In);
        }
        
        void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
        {
            RGBA = float4(R, G, B, A);
            RGB = float3(R, G, B);
            RG = float2(R, G);
        }
        
        void Unity_Remap_float(float In, float2 InMinMax, float2 OutMinMax, out float Out)
        {
            Out = OutMinMax.x + (In - InMinMax.x) * (OutMinMax.y - OutMinMax.x) / (InMinMax.y - InMinMax.x);
        }
        
        void Unity_Absolute_float(float In, out float Out)
        {
            Out = abs(In);
        }
        
        void Unity_Smoothstep_float(float Edge1, float Edge2, float In, out float Out)
        {
            Out = smoothstep(Edge1, Edge2, In);
        }
        
        void Unity_Add_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A + B;
        }
        
        void Unity_SceneDepth_Eye_float(float4 UV, out float Out)
        {
            if (unity_OrthoParams.w == 1.0)
            {
                Out = LinearEyeDepth(ComputeWorldSpacePosition(UV.xy, SHADERGRAPH_SAMPLE_SCENE_DEPTH(UV.xy), UNITY_MATRIX_I_VP), UNITY_MATRIX_V);
            }
            else
            {
                Out = LinearEyeDepth(SHADERGRAPH_SAMPLE_SCENE_DEPTH(UV.xy), _ZBufferParams);
            }
        }
        
        void Unity_Subtract_float(float A, float B, out float Out)
        {
            Out = A - B;
        }
        
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
            float _Distance_c01ba79505ea4a8891c3da5756fe9e5a_Out_2;
            Unity_Distance_float3(SHADERGRAPH_OBJECT_POSITION, IN.WorldSpacePosition, _Distance_c01ba79505ea4a8891c3da5756fe9e5a_Out_2);
            float _Property_d1be4d71eb4e4aae9337b9b402f45d63_Out_0 = _Curvature_Radius;
            float _Divide_03646e2359744ec38397913fc1d7c270_Out_2;
            Unity_Divide_float(_Distance_c01ba79505ea4a8891c3da5756fe9e5a_Out_2, _Property_d1be4d71eb4e4aae9337b9b402f45d63_Out_0, _Divide_03646e2359744ec38397913fc1d7c270_Out_2);
            float _Power_07f0eac51f1244fbb5c4966f586ac4dc_Out_2;
            Unity_Power_float(_Divide_03646e2359744ec38397913fc1d7c270_Out_2, 3, _Power_07f0eac51f1244fbb5c4966f586ac4dc_Out_2);
            float3 _Multiply_5ca41a1165784fbe980a8c3177fad7e1_Out_2;
            Unity_Multiply_float3_float3(IN.WorldSpaceNormal, (_Power_07f0eac51f1244fbb5c4966f586ac4dc_Out_2.xxx), _Multiply_5ca41a1165784fbe980a8c3177fad7e1_Out_2);
            float _Property_ef386ec2d5f4434a8a5f934ff230322f_Out_0 = _Noise_Edge_1;
            float _Property_147f1a2515e04a399eed34de35cf1107_Out_0 = _Noise_Edge_2;
            float4 _Property_b84368a6bae8433994c8bf5d771c01f4_Out_0 = _Rotate_Projection;
            float _Split_31db8d949ab24fd1b5ded76e6ecb6868_R_1 = _Property_b84368a6bae8433994c8bf5d771c01f4_Out_0[0];
            float _Split_31db8d949ab24fd1b5ded76e6ecb6868_G_2 = _Property_b84368a6bae8433994c8bf5d771c01f4_Out_0[1];
            float _Split_31db8d949ab24fd1b5ded76e6ecb6868_B_3 = _Property_b84368a6bae8433994c8bf5d771c01f4_Out_0[2];
            float _Split_31db8d949ab24fd1b5ded76e6ecb6868_A_4 = _Property_b84368a6bae8433994c8bf5d771c01f4_Out_0[3];
            float3 _RotateAboutAxis_6e7d2784bd02405faeb7bacb567d0731_Out_3;
            Unity_Rotate_About_Axis_Degrees_float(IN.WorldSpacePosition, (_Property_b84368a6bae8433994c8bf5d771c01f4_Out_0.xyz), _Split_31db8d949ab24fd1b5ded76e6ecb6868_A_4, _RotateAboutAxis_6e7d2784bd02405faeb7bacb567d0731_Out_3);
            float _Property_1b5acb9aca4b4c1ca8150917cb29e38d_Out_0 = _Noise_Speed;
            float _Multiply_a1f01de168c5412e848fa5a9a4f633d8_Out_2;
            Unity_Multiply_float_float(IN.TimeParameters.x, _Property_1b5acb9aca4b4c1ca8150917cb29e38d_Out_0, _Multiply_a1f01de168c5412e848fa5a9a4f633d8_Out_2);
            float2 _TilingAndOffset_3a22eccd71474e639594fce72cde2d02_Out_3;
            Unity_TilingAndOffset_float((_RotateAboutAxis_6e7d2784bd02405faeb7bacb567d0731_Out_3.xy), float2 (1, 1), (_Multiply_a1f01de168c5412e848fa5a9a4f633d8_Out_2.xx), _TilingAndOffset_3a22eccd71474e639594fce72cde2d02_Out_3);
            float _Property_e34f89cb08684afb94f0ac41ba675b11_Out_0 = _Noise_Scale;
            float _GradientNoise_71dea3d8ca7f493a820838ec4624d407_Out_2;
            Unity_GradientNoise_float(_TilingAndOffset_3a22eccd71474e639594fce72cde2d02_Out_3, _Property_e34f89cb08684afb94f0ac41ba675b11_Out_0, _GradientNoise_71dea3d8ca7f493a820838ec4624d407_Out_2);
            float2 _TilingAndOffset_b402f80311694eb4b5a4c3d07e71c615_Out_3;
            Unity_TilingAndOffset_float((_RotateAboutAxis_6e7d2784bd02405faeb7bacb567d0731_Out_3.xy), float2 (1, 1), float2 (0, 0), _TilingAndOffset_b402f80311694eb4b5a4c3d07e71c615_Out_3);
            float _GradientNoise_7cfc31faa781410090b11ae418c9e103_Out_2;
            Unity_GradientNoise_float(_TilingAndOffset_b402f80311694eb4b5a4c3d07e71c615_Out_3, _Property_e34f89cb08684afb94f0ac41ba675b11_Out_0, _GradientNoise_7cfc31faa781410090b11ae418c9e103_Out_2);
            float _Add_8d3a946d8f7848c0a6a4ee9e280c511d_Out_2;
            Unity_Add_float(_GradientNoise_71dea3d8ca7f493a820838ec4624d407_Out_2, _GradientNoise_7cfc31faa781410090b11ae418c9e103_Out_2, _Add_8d3a946d8f7848c0a6a4ee9e280c511d_Out_2);
            float _Divide_883697060c4b42898d76bc5325a5b568_Out_2;
            Unity_Divide_float(_Add_8d3a946d8f7848c0a6a4ee9e280c511d_Out_2, 2, _Divide_883697060c4b42898d76bc5325a5b568_Out_2);
            float _Saturate_c96331ef3b2642d39a446bce3d43f560_Out_1;
            Unity_Saturate_float(_Divide_883697060c4b42898d76bc5325a5b568_Out_2, _Saturate_c96331ef3b2642d39a446bce3d43f560_Out_1);
            float _Property_a5e2c659762f49e2826023553b233885_Out_0 = _Noise_Power;
            float _Power_fe5fa4a062ff4bac868501be2a7f055c_Out_2;
            Unity_Power_float(_Saturate_c96331ef3b2642d39a446bce3d43f560_Out_1, _Property_a5e2c659762f49e2826023553b233885_Out_0, _Power_fe5fa4a062ff4bac868501be2a7f055c_Out_2);
            float4 _Property_f466dd4679cc4567b14cecb45e839124_Out_0 = _Noise_Remap;
            float _Split_cfe4e3a30c93414694a4d7e49c708985_R_1 = _Property_f466dd4679cc4567b14cecb45e839124_Out_0[0];
            float _Split_cfe4e3a30c93414694a4d7e49c708985_G_2 = _Property_f466dd4679cc4567b14cecb45e839124_Out_0[1];
            float _Split_cfe4e3a30c93414694a4d7e49c708985_B_3 = _Property_f466dd4679cc4567b14cecb45e839124_Out_0[2];
            float _Split_cfe4e3a30c93414694a4d7e49c708985_A_4 = _Property_f466dd4679cc4567b14cecb45e839124_Out_0[3];
            float4 _Combine_c045c4c659354461848cd6c7d61e4be5_RGBA_4;
            float3 _Combine_c045c4c659354461848cd6c7d61e4be5_RGB_5;
            float2 _Combine_c045c4c659354461848cd6c7d61e4be5_RG_6;
            Unity_Combine_float(_Split_cfe4e3a30c93414694a4d7e49c708985_R_1, _Split_cfe4e3a30c93414694a4d7e49c708985_G_2, 0, 0, _Combine_c045c4c659354461848cd6c7d61e4be5_RGBA_4, _Combine_c045c4c659354461848cd6c7d61e4be5_RGB_5, _Combine_c045c4c659354461848cd6c7d61e4be5_RG_6);
            float4 _Combine_6de15c52675e489b874b27eaf16323df_RGBA_4;
            float3 _Combine_6de15c52675e489b874b27eaf16323df_RGB_5;
            float2 _Combine_6de15c52675e489b874b27eaf16323df_RG_6;
            Unity_Combine_float(_Split_cfe4e3a30c93414694a4d7e49c708985_B_3, _Split_cfe4e3a30c93414694a4d7e49c708985_A_4, 0, 0, _Combine_6de15c52675e489b874b27eaf16323df_RGBA_4, _Combine_6de15c52675e489b874b27eaf16323df_RGB_5, _Combine_6de15c52675e489b874b27eaf16323df_RG_6);
            float _Remap_192e92b0649c4e009e825f27b2499763_Out_3;
            Unity_Remap_float(_Power_fe5fa4a062ff4bac868501be2a7f055c_Out_2, _Combine_c045c4c659354461848cd6c7d61e4be5_RG_6, _Combine_6de15c52675e489b874b27eaf16323df_RG_6, _Remap_192e92b0649c4e009e825f27b2499763_Out_3);
            float _Absolute_d5fceabb74744431b85e0fdda3c8cf5c_Out_1;
            Unity_Absolute_float(_Remap_192e92b0649c4e009e825f27b2499763_Out_3, _Absolute_d5fceabb74744431b85e0fdda3c8cf5c_Out_1);
            float _Smoothstep_5b3511aa53f74a73b9b9614372a6af74_Out_3;
            Unity_Smoothstep_float(_Property_ef386ec2d5f4434a8a5f934ff230322f_Out_0, _Property_147f1a2515e04a399eed34de35cf1107_Out_0, _Absolute_d5fceabb74744431b85e0fdda3c8cf5c_Out_1, _Smoothstep_5b3511aa53f74a73b9b9614372a6af74_Out_3);
            float _Property_8fb0c3dbf4a84403a6068e70183a7ea4_Out_0 = _Base_Speed;
            float _Multiply_774f493cd66541e7ba6553802a499b79_Out_2;
            Unity_Multiply_float_float(IN.TimeParameters.x, _Property_8fb0c3dbf4a84403a6068e70183a7ea4_Out_0, _Multiply_774f493cd66541e7ba6553802a499b79_Out_2);
            float2 _TilingAndOffset_969b7b642fd04ed7b2592123a03eca18_Out_3;
            Unity_TilingAndOffset_float((_RotateAboutAxis_6e7d2784bd02405faeb7bacb567d0731_Out_3.xy), float2 (1, 1), (_Multiply_774f493cd66541e7ba6553802a499b79_Out_2.xx), _TilingAndOffset_969b7b642fd04ed7b2592123a03eca18_Out_3);
            float _Property_e3b00c3a5e804e14a1e03e69aac49211_Out_0 = _Base_Scale;
            float _GradientNoise_04262dfbc1b540b1a9d9b997627f189b_Out_2;
            Unity_GradientNoise_float(_TilingAndOffset_969b7b642fd04ed7b2592123a03eca18_Out_3, _Property_e3b00c3a5e804e14a1e03e69aac49211_Out_0, _GradientNoise_04262dfbc1b540b1a9d9b997627f189b_Out_2);
            float _Property_17938a6d7e2f40dd8d0f1b984a9fbb59_Out_0 = _Base_Strength;
            float _Multiply_0854b1bc83aa4170a68f058b8cb96ff7_Out_2;
            Unity_Multiply_float_float(_GradientNoise_04262dfbc1b540b1a9d9b997627f189b_Out_2, _Property_17938a6d7e2f40dd8d0f1b984a9fbb59_Out_0, _Multiply_0854b1bc83aa4170a68f058b8cb96ff7_Out_2);
            float _Add_f82d9f056cbf456f911125a9574d865f_Out_2;
            Unity_Add_float(_Smoothstep_5b3511aa53f74a73b9b9614372a6af74_Out_3, _Multiply_0854b1bc83aa4170a68f058b8cb96ff7_Out_2, _Add_f82d9f056cbf456f911125a9574d865f_Out_2);
            float _Add_df54866b810e4151a1fde09a51f17b65_Out_2;
            Unity_Add_float(1, _Property_17938a6d7e2f40dd8d0f1b984a9fbb59_Out_0, _Add_df54866b810e4151a1fde09a51f17b65_Out_2);
            float _Divide_b2c87465e89040e4940d7d7f42943c3f_Out_2;
            Unity_Divide_float(_Add_f82d9f056cbf456f911125a9574d865f_Out_2, _Add_df54866b810e4151a1fde09a51f17b65_Out_2, _Divide_b2c87465e89040e4940d7d7f42943c3f_Out_2);
            float3 _Multiply_cc4eb1139ae74d4c85067f5171acc955_Out_2;
            Unity_Multiply_float3_float3(IN.ObjectSpaceNormal, (_Divide_b2c87465e89040e4940d7d7f42943c3f_Out_2.xxx), _Multiply_cc4eb1139ae74d4c85067f5171acc955_Out_2);
            float _Property_611696cf692e4bb19aaf7739c57cdd44_Out_0 = _Noise_Height;
            float3 _Multiply_da4791b114e34eceac3bacbb1043285e_Out_2;
            Unity_Multiply_float3_float3(_Multiply_cc4eb1139ae74d4c85067f5171acc955_Out_2, (_Property_611696cf692e4bb19aaf7739c57cdd44_Out_0.xxx), _Multiply_da4791b114e34eceac3bacbb1043285e_Out_2);
            float3 _Add_1af6468ff1e344348b74bd929f252cbf_Out_2;
            Unity_Add_float3(IN.ObjectSpacePosition, _Multiply_da4791b114e34eceac3bacbb1043285e_Out_2, _Add_1af6468ff1e344348b74bd929f252cbf_Out_2);
            float3 _Add_c7842509b95b4858bfbf1f91fea0a4c3_Out_2;
            Unity_Add_float3(_Multiply_5ca41a1165784fbe980a8c3177fad7e1_Out_2, _Add_1af6468ff1e344348b74bd929f252cbf_Out_2, _Add_c7842509b95b4858bfbf1f91fea0a4c3_Out_2);
            description.Position = _Add_c7842509b95b4858bfbf1f91fea0a4c3_Out_2;
            description.Normal = IN.ObjectSpaceNormal;
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
            float Alpha;
            float AlphaClipThreshold;
        };
        
        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            float _SceneDepth_92d0d826f11444f38ddac1aa18b54491_Out_1;
            Unity_SceneDepth_Eye_float(float4(IN.ScreenPosition.xy / IN.ScreenPosition.w, 0, 0), _SceneDepth_92d0d826f11444f38ddac1aa18b54491_Out_1);
            float4 _ScreenPosition_a43e7cd4d3c742149035c252ba0d4ec9_Out_0 = IN.ScreenPosition;
            float _Split_945e233c5d5644b39c8f24743ae9b880_R_1 = _ScreenPosition_a43e7cd4d3c742149035c252ba0d4ec9_Out_0[0];
            float _Split_945e233c5d5644b39c8f24743ae9b880_G_2 = _ScreenPosition_a43e7cd4d3c742149035c252ba0d4ec9_Out_0[1];
            float _Split_945e233c5d5644b39c8f24743ae9b880_B_3 = _ScreenPosition_a43e7cd4d3c742149035c252ba0d4ec9_Out_0[2];
            float _Split_945e233c5d5644b39c8f24743ae9b880_A_4 = _ScreenPosition_a43e7cd4d3c742149035c252ba0d4ec9_Out_0[3];
            float _Subtract_509aa90668e7408bad7076496f9d5759_Out_2;
            Unity_Subtract_float(_Split_945e233c5d5644b39c8f24743ae9b880_A_4, 1, _Subtract_509aa90668e7408bad7076496f9d5759_Out_2);
            float _Subtract_72c15d8c0496460ca2c6aaf585c41381_Out_2;
            Unity_Subtract_float(_SceneDepth_92d0d826f11444f38ddac1aa18b54491_Out_1, _Subtract_509aa90668e7408bad7076496f9d5759_Out_2, _Subtract_72c15d8c0496460ca2c6aaf585c41381_Out_2);
            float _Property_3a30c5a5cbf24fa6913c8ee537ee5f4b_Out_0 = _Fade_Depth;
            float _Divide_8b2505abc71b4c3f8954d6fb229e0865_Out_2;
            Unity_Divide_float(_Subtract_72c15d8c0496460ca2c6aaf585c41381_Out_2, _Property_3a30c5a5cbf24fa6913c8ee537ee5f4b_Out_0, _Divide_8b2505abc71b4c3f8954d6fb229e0865_Out_2);
            float _Saturate_3c60f55f62d842639e72ca2a20ce74df_Out_1;
            Unity_Saturate_float(_Divide_8b2505abc71b4c3f8954d6fb229e0865_Out_2, _Saturate_3c60f55f62d842639e72ca2a20ce74df_Out_1);
            surface.Alpha = _Saturate_3c60f55f62d842639e72ca2a20ce74df_Out_1;
            surface.AlphaClipThreshold = 0.5;
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
            output.WorldSpaceNormal =                           TransformObjectToWorldNormal(input.normalOS);
            output.ObjectSpaceTangent =                         input.tangentOS.xyz;
            output.ObjectSpacePosition =                        input.positionOS;
            output.WorldSpacePosition =                         TransformObjectToWorld(input.positionOS);
            output.TimeParameters =                             _TimeParameters.xyz;
        
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
        
            
        
        
        
        
        
            output.WorldSpacePosition = input.positionWS;
            output.ScreenPosition = ComputeScreenPos(TransformWorldToHClip(input.positionWS), _ProjectionParams.x);
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
            Name "DepthNormalsOnly"
            Tags
            {
                "LightMode" = "DepthNormalsOnly"
            }
        
        // Render State
        Cull [_Cull]
        ZTest LEqual
        ZWrite On
        
        // Debug
        // <None>
        
        // --------------------------------------------------
        // Pass
        
        HLSLPROGRAM
        
        // Pragmas
        #pragma target 2.0
        #pragma only_renderers gles gles3 glcore d3d11
        #pragma multi_compile_instancing
        #pragma vertex vert
        #pragma fragment frag
        
        // DotsInstancingOptions: <None>
        // HybridV1InjectedBuiltinProperties: <None>
        
        // Keywords
        #pragma shader_feature_local_fragment _ _ALPHATEST_ON
        // GraphKeywords: <None>
        
        // Defines
        
        #define ATTRIBUTES_NEED_NORMAL
        #define ATTRIBUTES_NEED_TANGENT
        #define ATTRIBUTES_NEED_TEXCOORD1
        #define VARYINGS_NEED_POSITION_WS
        #define VARYINGS_NEED_NORMAL_WS
        #define VARYINGS_NEED_TANGENT_WS
        #define FEATURES_GRAPH_VERTEX
        /* WARNING: $splice Could not find named fragment 'PassInstancing' */
        #define SHADERPASS SHADERPASS_DEPTHNORMALSONLY
        #define REQUIRE_DEPTH_TEXTURE
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
             float4 uv1 : TEXCOORD1;
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
             float3 WorldSpacePosition;
             float4 ScreenPosition;
        };
        struct VertexDescriptionInputs
        {
             float3 ObjectSpaceNormal;
             float3 WorldSpaceNormal;
             float3 ObjectSpaceTangent;
             float3 ObjectSpacePosition;
             float3 WorldSpacePosition;
             float3 TimeParameters;
        };
        struct PackedVaryings
        {
             float4 positionCS : SV_POSITION;
             float3 interp0 : INTERP0;
             float3 interp1 : INTERP1;
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
            output.interp0.xyz =  input.positionWS;
            output.interp1.xyz =  input.normalWS;
            output.interp2.xyzw =  input.tangentWS;
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
        float4 _Rotate_Projection;
        float _Noise_Scale;
        float _Noise_Speed;
        float _Noise_Height;
        float4 _Noise_Remap;
        float4 _Colour_Peak;
        float4 _Colour_Valley;
        float _Noise_Edge_1;
        float _Noise_Edge_2;
        float _Noise_Power;
        float _Base_Scale;
        float _Base_Speed;
        float _Base_Strength;
        float _Emission;
        float _Curvature_Radius;
        float _Fresnel_Power;
        float _Fresnel_opacity;
        float _Fade_Depth;
        CBUFFER_END
        
        // Object and Global properties
        
        // Graph Includes
        // GraphIncludes: <None>
        
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
        
        void Unity_Distance_float3(float3 A, float3 B, out float Out)
        {
            Out = distance(A, B);
        }
        
        void Unity_Divide_float(float A, float B, out float Out)
        {
            Out = A / B;
        }
        
        void Unity_Power_float(float A, float B, out float Out)
        {
            Out = pow(A, B);
        }
        
        void Unity_Multiply_float3_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A * B;
        }
        
        void Unity_Rotate_About_Axis_Degrees_float(float3 In, float3 Axis, float Rotation, out float3 Out)
        {
            Rotation = radians(Rotation);
        
            float s = sin(Rotation);
            float c = cos(Rotation);
            float one_minus_c = 1.0 - c;
        
            Axis = normalize(Axis);
        
            float3x3 rot_mat = { one_minus_c * Axis.x * Axis.x + c,            one_minus_c * Axis.x * Axis.y - Axis.z * s,     one_minus_c * Axis.z * Axis.x + Axis.y * s,
                                      one_minus_c * Axis.x * Axis.y + Axis.z * s,   one_minus_c * Axis.y * Axis.y + c,              one_minus_c * Axis.y * Axis.z - Axis.x * s,
                                      one_minus_c * Axis.z * Axis.x - Axis.y * s,   one_minus_c * Axis.y * Axis.z + Axis.x * s,     one_minus_c * Axis.z * Axis.z + c
                                    };
        
            Out = mul(rot_mat,  In);
        }
        
        void Unity_Multiply_float_float(float A, float B, out float Out)
        {
            Out = A * B;
        }
        
        void Unity_TilingAndOffset_float(float2 UV, float2 Tiling, float2 Offset, out float2 Out)
        {
            Out = UV * Tiling + Offset;
        }
        
        
        float2 Unity_GradientNoise_Dir_float(float2 p)
        {
            // Permutation and hashing used in webgl-nosie goo.gl/pX7HtC
            p = p % 289;
            // need full precision, otherwise half overflows when p > 1
            float x = float(34 * p.x + 1) * p.x % 289 + p.y;
            x = (34 * x + 1) * x % 289;
            x = frac(x / 41) * 2 - 1;
            return normalize(float2(x - floor(x + 0.5), abs(x) - 0.5));
        }
        
        void Unity_GradientNoise_float(float2 UV, float Scale, out float Out)
        {
            float2 p = UV * Scale;
            float2 ip = floor(p);
            float2 fp = frac(p);
            float d00 = dot(Unity_GradientNoise_Dir_float(ip), fp);
            float d01 = dot(Unity_GradientNoise_Dir_float(ip + float2(0, 1)), fp - float2(0, 1));
            float d10 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 0)), fp - float2(1, 0));
            float d11 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 1)), fp - float2(1, 1));
            fp = fp * fp * fp * (fp * (fp * 6 - 15) + 10);
            Out = lerp(lerp(d00, d01, fp.y), lerp(d10, d11, fp.y), fp.x) + 0.5;
        }
        
        void Unity_Add_float(float A, float B, out float Out)
        {
            Out = A + B;
        }
        
        void Unity_Saturate_float(float In, out float Out)
        {
            Out = saturate(In);
        }
        
        void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
        {
            RGBA = float4(R, G, B, A);
            RGB = float3(R, G, B);
            RG = float2(R, G);
        }
        
        void Unity_Remap_float(float In, float2 InMinMax, float2 OutMinMax, out float Out)
        {
            Out = OutMinMax.x + (In - InMinMax.x) * (OutMinMax.y - OutMinMax.x) / (InMinMax.y - InMinMax.x);
        }
        
        void Unity_Absolute_float(float In, out float Out)
        {
            Out = abs(In);
        }
        
        void Unity_Smoothstep_float(float Edge1, float Edge2, float In, out float Out)
        {
            Out = smoothstep(Edge1, Edge2, In);
        }
        
        void Unity_Add_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A + B;
        }
        
        void Unity_SceneDepth_Eye_float(float4 UV, out float Out)
        {
            if (unity_OrthoParams.w == 1.0)
            {
                Out = LinearEyeDepth(ComputeWorldSpacePosition(UV.xy, SHADERGRAPH_SAMPLE_SCENE_DEPTH(UV.xy), UNITY_MATRIX_I_VP), UNITY_MATRIX_V);
            }
            else
            {
                Out = LinearEyeDepth(SHADERGRAPH_SAMPLE_SCENE_DEPTH(UV.xy), _ZBufferParams);
            }
        }
        
        void Unity_Subtract_float(float A, float B, out float Out)
        {
            Out = A - B;
        }
        
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
            float _Distance_c01ba79505ea4a8891c3da5756fe9e5a_Out_2;
            Unity_Distance_float3(SHADERGRAPH_OBJECT_POSITION, IN.WorldSpacePosition, _Distance_c01ba79505ea4a8891c3da5756fe9e5a_Out_2);
            float _Property_d1be4d71eb4e4aae9337b9b402f45d63_Out_0 = _Curvature_Radius;
            float _Divide_03646e2359744ec38397913fc1d7c270_Out_2;
            Unity_Divide_float(_Distance_c01ba79505ea4a8891c3da5756fe9e5a_Out_2, _Property_d1be4d71eb4e4aae9337b9b402f45d63_Out_0, _Divide_03646e2359744ec38397913fc1d7c270_Out_2);
            float _Power_07f0eac51f1244fbb5c4966f586ac4dc_Out_2;
            Unity_Power_float(_Divide_03646e2359744ec38397913fc1d7c270_Out_2, 3, _Power_07f0eac51f1244fbb5c4966f586ac4dc_Out_2);
            float3 _Multiply_5ca41a1165784fbe980a8c3177fad7e1_Out_2;
            Unity_Multiply_float3_float3(IN.WorldSpaceNormal, (_Power_07f0eac51f1244fbb5c4966f586ac4dc_Out_2.xxx), _Multiply_5ca41a1165784fbe980a8c3177fad7e1_Out_2);
            float _Property_ef386ec2d5f4434a8a5f934ff230322f_Out_0 = _Noise_Edge_1;
            float _Property_147f1a2515e04a399eed34de35cf1107_Out_0 = _Noise_Edge_2;
            float4 _Property_b84368a6bae8433994c8bf5d771c01f4_Out_0 = _Rotate_Projection;
            float _Split_31db8d949ab24fd1b5ded76e6ecb6868_R_1 = _Property_b84368a6bae8433994c8bf5d771c01f4_Out_0[0];
            float _Split_31db8d949ab24fd1b5ded76e6ecb6868_G_2 = _Property_b84368a6bae8433994c8bf5d771c01f4_Out_0[1];
            float _Split_31db8d949ab24fd1b5ded76e6ecb6868_B_3 = _Property_b84368a6bae8433994c8bf5d771c01f4_Out_0[2];
            float _Split_31db8d949ab24fd1b5ded76e6ecb6868_A_4 = _Property_b84368a6bae8433994c8bf5d771c01f4_Out_0[3];
            float3 _RotateAboutAxis_6e7d2784bd02405faeb7bacb567d0731_Out_3;
            Unity_Rotate_About_Axis_Degrees_float(IN.WorldSpacePosition, (_Property_b84368a6bae8433994c8bf5d771c01f4_Out_0.xyz), _Split_31db8d949ab24fd1b5ded76e6ecb6868_A_4, _RotateAboutAxis_6e7d2784bd02405faeb7bacb567d0731_Out_3);
            float _Property_1b5acb9aca4b4c1ca8150917cb29e38d_Out_0 = _Noise_Speed;
            float _Multiply_a1f01de168c5412e848fa5a9a4f633d8_Out_2;
            Unity_Multiply_float_float(IN.TimeParameters.x, _Property_1b5acb9aca4b4c1ca8150917cb29e38d_Out_0, _Multiply_a1f01de168c5412e848fa5a9a4f633d8_Out_2);
            float2 _TilingAndOffset_3a22eccd71474e639594fce72cde2d02_Out_3;
            Unity_TilingAndOffset_float((_RotateAboutAxis_6e7d2784bd02405faeb7bacb567d0731_Out_3.xy), float2 (1, 1), (_Multiply_a1f01de168c5412e848fa5a9a4f633d8_Out_2.xx), _TilingAndOffset_3a22eccd71474e639594fce72cde2d02_Out_3);
            float _Property_e34f89cb08684afb94f0ac41ba675b11_Out_0 = _Noise_Scale;
            float _GradientNoise_71dea3d8ca7f493a820838ec4624d407_Out_2;
            Unity_GradientNoise_float(_TilingAndOffset_3a22eccd71474e639594fce72cde2d02_Out_3, _Property_e34f89cb08684afb94f0ac41ba675b11_Out_0, _GradientNoise_71dea3d8ca7f493a820838ec4624d407_Out_2);
            float2 _TilingAndOffset_b402f80311694eb4b5a4c3d07e71c615_Out_3;
            Unity_TilingAndOffset_float((_RotateAboutAxis_6e7d2784bd02405faeb7bacb567d0731_Out_3.xy), float2 (1, 1), float2 (0, 0), _TilingAndOffset_b402f80311694eb4b5a4c3d07e71c615_Out_3);
            float _GradientNoise_7cfc31faa781410090b11ae418c9e103_Out_2;
            Unity_GradientNoise_float(_TilingAndOffset_b402f80311694eb4b5a4c3d07e71c615_Out_3, _Property_e34f89cb08684afb94f0ac41ba675b11_Out_0, _GradientNoise_7cfc31faa781410090b11ae418c9e103_Out_2);
            float _Add_8d3a946d8f7848c0a6a4ee9e280c511d_Out_2;
            Unity_Add_float(_GradientNoise_71dea3d8ca7f493a820838ec4624d407_Out_2, _GradientNoise_7cfc31faa781410090b11ae418c9e103_Out_2, _Add_8d3a946d8f7848c0a6a4ee9e280c511d_Out_2);
            float _Divide_883697060c4b42898d76bc5325a5b568_Out_2;
            Unity_Divide_float(_Add_8d3a946d8f7848c0a6a4ee9e280c511d_Out_2, 2, _Divide_883697060c4b42898d76bc5325a5b568_Out_2);
            float _Saturate_c96331ef3b2642d39a446bce3d43f560_Out_1;
            Unity_Saturate_float(_Divide_883697060c4b42898d76bc5325a5b568_Out_2, _Saturate_c96331ef3b2642d39a446bce3d43f560_Out_1);
            float _Property_a5e2c659762f49e2826023553b233885_Out_0 = _Noise_Power;
            float _Power_fe5fa4a062ff4bac868501be2a7f055c_Out_2;
            Unity_Power_float(_Saturate_c96331ef3b2642d39a446bce3d43f560_Out_1, _Property_a5e2c659762f49e2826023553b233885_Out_0, _Power_fe5fa4a062ff4bac868501be2a7f055c_Out_2);
            float4 _Property_f466dd4679cc4567b14cecb45e839124_Out_0 = _Noise_Remap;
            float _Split_cfe4e3a30c93414694a4d7e49c708985_R_1 = _Property_f466dd4679cc4567b14cecb45e839124_Out_0[0];
            float _Split_cfe4e3a30c93414694a4d7e49c708985_G_2 = _Property_f466dd4679cc4567b14cecb45e839124_Out_0[1];
            float _Split_cfe4e3a30c93414694a4d7e49c708985_B_3 = _Property_f466dd4679cc4567b14cecb45e839124_Out_0[2];
            float _Split_cfe4e3a30c93414694a4d7e49c708985_A_4 = _Property_f466dd4679cc4567b14cecb45e839124_Out_0[3];
            float4 _Combine_c045c4c659354461848cd6c7d61e4be5_RGBA_4;
            float3 _Combine_c045c4c659354461848cd6c7d61e4be5_RGB_5;
            float2 _Combine_c045c4c659354461848cd6c7d61e4be5_RG_6;
            Unity_Combine_float(_Split_cfe4e3a30c93414694a4d7e49c708985_R_1, _Split_cfe4e3a30c93414694a4d7e49c708985_G_2, 0, 0, _Combine_c045c4c659354461848cd6c7d61e4be5_RGBA_4, _Combine_c045c4c659354461848cd6c7d61e4be5_RGB_5, _Combine_c045c4c659354461848cd6c7d61e4be5_RG_6);
            float4 _Combine_6de15c52675e489b874b27eaf16323df_RGBA_4;
            float3 _Combine_6de15c52675e489b874b27eaf16323df_RGB_5;
            float2 _Combine_6de15c52675e489b874b27eaf16323df_RG_6;
            Unity_Combine_float(_Split_cfe4e3a30c93414694a4d7e49c708985_B_3, _Split_cfe4e3a30c93414694a4d7e49c708985_A_4, 0, 0, _Combine_6de15c52675e489b874b27eaf16323df_RGBA_4, _Combine_6de15c52675e489b874b27eaf16323df_RGB_5, _Combine_6de15c52675e489b874b27eaf16323df_RG_6);
            float _Remap_192e92b0649c4e009e825f27b2499763_Out_3;
            Unity_Remap_float(_Power_fe5fa4a062ff4bac868501be2a7f055c_Out_2, _Combine_c045c4c659354461848cd6c7d61e4be5_RG_6, _Combine_6de15c52675e489b874b27eaf16323df_RG_6, _Remap_192e92b0649c4e009e825f27b2499763_Out_3);
            float _Absolute_d5fceabb74744431b85e0fdda3c8cf5c_Out_1;
            Unity_Absolute_float(_Remap_192e92b0649c4e009e825f27b2499763_Out_3, _Absolute_d5fceabb74744431b85e0fdda3c8cf5c_Out_1);
            float _Smoothstep_5b3511aa53f74a73b9b9614372a6af74_Out_3;
            Unity_Smoothstep_float(_Property_ef386ec2d5f4434a8a5f934ff230322f_Out_0, _Property_147f1a2515e04a399eed34de35cf1107_Out_0, _Absolute_d5fceabb74744431b85e0fdda3c8cf5c_Out_1, _Smoothstep_5b3511aa53f74a73b9b9614372a6af74_Out_3);
            float _Property_8fb0c3dbf4a84403a6068e70183a7ea4_Out_0 = _Base_Speed;
            float _Multiply_774f493cd66541e7ba6553802a499b79_Out_2;
            Unity_Multiply_float_float(IN.TimeParameters.x, _Property_8fb0c3dbf4a84403a6068e70183a7ea4_Out_0, _Multiply_774f493cd66541e7ba6553802a499b79_Out_2);
            float2 _TilingAndOffset_969b7b642fd04ed7b2592123a03eca18_Out_3;
            Unity_TilingAndOffset_float((_RotateAboutAxis_6e7d2784bd02405faeb7bacb567d0731_Out_3.xy), float2 (1, 1), (_Multiply_774f493cd66541e7ba6553802a499b79_Out_2.xx), _TilingAndOffset_969b7b642fd04ed7b2592123a03eca18_Out_3);
            float _Property_e3b00c3a5e804e14a1e03e69aac49211_Out_0 = _Base_Scale;
            float _GradientNoise_04262dfbc1b540b1a9d9b997627f189b_Out_2;
            Unity_GradientNoise_float(_TilingAndOffset_969b7b642fd04ed7b2592123a03eca18_Out_3, _Property_e3b00c3a5e804e14a1e03e69aac49211_Out_0, _GradientNoise_04262dfbc1b540b1a9d9b997627f189b_Out_2);
            float _Property_17938a6d7e2f40dd8d0f1b984a9fbb59_Out_0 = _Base_Strength;
            float _Multiply_0854b1bc83aa4170a68f058b8cb96ff7_Out_2;
            Unity_Multiply_float_float(_GradientNoise_04262dfbc1b540b1a9d9b997627f189b_Out_2, _Property_17938a6d7e2f40dd8d0f1b984a9fbb59_Out_0, _Multiply_0854b1bc83aa4170a68f058b8cb96ff7_Out_2);
            float _Add_f82d9f056cbf456f911125a9574d865f_Out_2;
            Unity_Add_float(_Smoothstep_5b3511aa53f74a73b9b9614372a6af74_Out_3, _Multiply_0854b1bc83aa4170a68f058b8cb96ff7_Out_2, _Add_f82d9f056cbf456f911125a9574d865f_Out_2);
            float _Add_df54866b810e4151a1fde09a51f17b65_Out_2;
            Unity_Add_float(1, _Property_17938a6d7e2f40dd8d0f1b984a9fbb59_Out_0, _Add_df54866b810e4151a1fde09a51f17b65_Out_2);
            float _Divide_b2c87465e89040e4940d7d7f42943c3f_Out_2;
            Unity_Divide_float(_Add_f82d9f056cbf456f911125a9574d865f_Out_2, _Add_df54866b810e4151a1fde09a51f17b65_Out_2, _Divide_b2c87465e89040e4940d7d7f42943c3f_Out_2);
            float3 _Multiply_cc4eb1139ae74d4c85067f5171acc955_Out_2;
            Unity_Multiply_float3_float3(IN.ObjectSpaceNormal, (_Divide_b2c87465e89040e4940d7d7f42943c3f_Out_2.xxx), _Multiply_cc4eb1139ae74d4c85067f5171acc955_Out_2);
            float _Property_611696cf692e4bb19aaf7739c57cdd44_Out_0 = _Noise_Height;
            float3 _Multiply_da4791b114e34eceac3bacbb1043285e_Out_2;
            Unity_Multiply_float3_float3(_Multiply_cc4eb1139ae74d4c85067f5171acc955_Out_2, (_Property_611696cf692e4bb19aaf7739c57cdd44_Out_0.xxx), _Multiply_da4791b114e34eceac3bacbb1043285e_Out_2);
            float3 _Add_1af6468ff1e344348b74bd929f252cbf_Out_2;
            Unity_Add_float3(IN.ObjectSpacePosition, _Multiply_da4791b114e34eceac3bacbb1043285e_Out_2, _Add_1af6468ff1e344348b74bd929f252cbf_Out_2);
            float3 _Add_c7842509b95b4858bfbf1f91fea0a4c3_Out_2;
            Unity_Add_float3(_Multiply_5ca41a1165784fbe980a8c3177fad7e1_Out_2, _Add_1af6468ff1e344348b74bd929f252cbf_Out_2, _Add_c7842509b95b4858bfbf1f91fea0a4c3_Out_2);
            description.Position = _Add_c7842509b95b4858bfbf1f91fea0a4c3_Out_2;
            description.Normal = IN.ObjectSpaceNormal;
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
            float Alpha;
            float AlphaClipThreshold;
        };
        
        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            float _SceneDepth_92d0d826f11444f38ddac1aa18b54491_Out_1;
            Unity_SceneDepth_Eye_float(float4(IN.ScreenPosition.xy / IN.ScreenPosition.w, 0, 0), _SceneDepth_92d0d826f11444f38ddac1aa18b54491_Out_1);
            float4 _ScreenPosition_a43e7cd4d3c742149035c252ba0d4ec9_Out_0 = IN.ScreenPosition;
            float _Split_945e233c5d5644b39c8f24743ae9b880_R_1 = _ScreenPosition_a43e7cd4d3c742149035c252ba0d4ec9_Out_0[0];
            float _Split_945e233c5d5644b39c8f24743ae9b880_G_2 = _ScreenPosition_a43e7cd4d3c742149035c252ba0d4ec9_Out_0[1];
            float _Split_945e233c5d5644b39c8f24743ae9b880_B_3 = _ScreenPosition_a43e7cd4d3c742149035c252ba0d4ec9_Out_0[2];
            float _Split_945e233c5d5644b39c8f24743ae9b880_A_4 = _ScreenPosition_a43e7cd4d3c742149035c252ba0d4ec9_Out_0[3];
            float _Subtract_509aa90668e7408bad7076496f9d5759_Out_2;
            Unity_Subtract_float(_Split_945e233c5d5644b39c8f24743ae9b880_A_4, 1, _Subtract_509aa90668e7408bad7076496f9d5759_Out_2);
            float _Subtract_72c15d8c0496460ca2c6aaf585c41381_Out_2;
            Unity_Subtract_float(_SceneDepth_92d0d826f11444f38ddac1aa18b54491_Out_1, _Subtract_509aa90668e7408bad7076496f9d5759_Out_2, _Subtract_72c15d8c0496460ca2c6aaf585c41381_Out_2);
            float _Property_3a30c5a5cbf24fa6913c8ee537ee5f4b_Out_0 = _Fade_Depth;
            float _Divide_8b2505abc71b4c3f8954d6fb229e0865_Out_2;
            Unity_Divide_float(_Subtract_72c15d8c0496460ca2c6aaf585c41381_Out_2, _Property_3a30c5a5cbf24fa6913c8ee537ee5f4b_Out_0, _Divide_8b2505abc71b4c3f8954d6fb229e0865_Out_2);
            float _Saturate_3c60f55f62d842639e72ca2a20ce74df_Out_1;
            Unity_Saturate_float(_Divide_8b2505abc71b4c3f8954d6fb229e0865_Out_2, _Saturate_3c60f55f62d842639e72ca2a20ce74df_Out_1);
            surface.Alpha = _Saturate_3c60f55f62d842639e72ca2a20ce74df_Out_1;
            surface.AlphaClipThreshold = 0.5;
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
            output.WorldSpaceNormal =                           TransformObjectToWorldNormal(input.normalOS);
            output.ObjectSpaceTangent =                         input.tangentOS.xyz;
            output.ObjectSpacePosition =                        input.positionOS;
            output.WorldSpacePosition =                         TransformObjectToWorld(input.positionOS);
            output.TimeParameters =                             _TimeParameters.xyz;
        
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
        
            
        
        
        
        
        
            output.WorldSpacePosition = input.positionWS;
            output.ScreenPosition = ComputeScreenPos(TransformWorldToHClip(input.positionWS), _ProjectionParams.x);
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
            Name "ShadowCaster"
            Tags
            {
                "LightMode" = "ShadowCaster"
            }
        
        // Render State
        Cull [_Cull]
        ZTest LEqual
        ZWrite On
        ColorMask 0
        
        // Debug
        // <None>
        
        // --------------------------------------------------
        // Pass
        
        HLSLPROGRAM
        
        // Pragmas
        #pragma target 2.0
        #pragma only_renderers gles gles3 glcore d3d11
        #pragma multi_compile_instancing
        #pragma vertex vert
        #pragma fragment frag
        
        // DotsInstancingOptions: <None>
        // HybridV1InjectedBuiltinProperties: <None>
        
        // Keywords
        #pragma multi_compile _ _CASTING_PUNCTUAL_LIGHT_SHADOW
        #pragma shader_feature_local_fragment _ _ALPHATEST_ON
        // GraphKeywords: <None>
        
        // Defines
        
        #define ATTRIBUTES_NEED_NORMAL
        #define ATTRIBUTES_NEED_TANGENT
        #define VARYINGS_NEED_POSITION_WS
        #define VARYINGS_NEED_NORMAL_WS
        #define FEATURES_GRAPH_VERTEX
        /* WARNING: $splice Could not find named fragment 'PassInstancing' */
        #define SHADERPASS SHADERPASS_SHADOWCASTER
        #define REQUIRE_DEPTH_TEXTURE
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
             float3 positionWS;
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
             float3 WorldSpacePosition;
             float4 ScreenPosition;
        };
        struct VertexDescriptionInputs
        {
             float3 ObjectSpaceNormal;
             float3 WorldSpaceNormal;
             float3 ObjectSpaceTangent;
             float3 ObjectSpacePosition;
             float3 WorldSpacePosition;
             float3 TimeParameters;
        };
        struct PackedVaryings
        {
             float4 positionCS : SV_POSITION;
             float3 interp0 : INTERP0;
             float3 interp1 : INTERP1;
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
        float4 _Rotate_Projection;
        float _Noise_Scale;
        float _Noise_Speed;
        float _Noise_Height;
        float4 _Noise_Remap;
        float4 _Colour_Peak;
        float4 _Colour_Valley;
        float _Noise_Edge_1;
        float _Noise_Edge_2;
        float _Noise_Power;
        float _Base_Scale;
        float _Base_Speed;
        float _Base_Strength;
        float _Emission;
        float _Curvature_Radius;
        float _Fresnel_Power;
        float _Fresnel_opacity;
        float _Fade_Depth;
        CBUFFER_END
        
        // Object and Global properties
        
        // Graph Includes
        // GraphIncludes: <None>
        
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
        
        void Unity_Distance_float3(float3 A, float3 B, out float Out)
        {
            Out = distance(A, B);
        }
        
        void Unity_Divide_float(float A, float B, out float Out)
        {
            Out = A / B;
        }
        
        void Unity_Power_float(float A, float B, out float Out)
        {
            Out = pow(A, B);
        }
        
        void Unity_Multiply_float3_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A * B;
        }
        
        void Unity_Rotate_About_Axis_Degrees_float(float3 In, float3 Axis, float Rotation, out float3 Out)
        {
            Rotation = radians(Rotation);
        
            float s = sin(Rotation);
            float c = cos(Rotation);
            float one_minus_c = 1.0 - c;
        
            Axis = normalize(Axis);
        
            float3x3 rot_mat = { one_minus_c * Axis.x * Axis.x + c,            one_minus_c * Axis.x * Axis.y - Axis.z * s,     one_minus_c * Axis.z * Axis.x + Axis.y * s,
                                      one_minus_c * Axis.x * Axis.y + Axis.z * s,   one_minus_c * Axis.y * Axis.y + c,              one_minus_c * Axis.y * Axis.z - Axis.x * s,
                                      one_minus_c * Axis.z * Axis.x - Axis.y * s,   one_minus_c * Axis.y * Axis.z + Axis.x * s,     one_minus_c * Axis.z * Axis.z + c
                                    };
        
            Out = mul(rot_mat,  In);
        }
        
        void Unity_Multiply_float_float(float A, float B, out float Out)
        {
            Out = A * B;
        }
        
        void Unity_TilingAndOffset_float(float2 UV, float2 Tiling, float2 Offset, out float2 Out)
        {
            Out = UV * Tiling + Offset;
        }
        
        
        float2 Unity_GradientNoise_Dir_float(float2 p)
        {
            // Permutation and hashing used in webgl-nosie goo.gl/pX7HtC
            p = p % 289;
            // need full precision, otherwise half overflows when p > 1
            float x = float(34 * p.x + 1) * p.x % 289 + p.y;
            x = (34 * x + 1) * x % 289;
            x = frac(x / 41) * 2 - 1;
            return normalize(float2(x - floor(x + 0.5), abs(x) - 0.5));
        }
        
        void Unity_GradientNoise_float(float2 UV, float Scale, out float Out)
        {
            float2 p = UV * Scale;
            float2 ip = floor(p);
            float2 fp = frac(p);
            float d00 = dot(Unity_GradientNoise_Dir_float(ip), fp);
            float d01 = dot(Unity_GradientNoise_Dir_float(ip + float2(0, 1)), fp - float2(0, 1));
            float d10 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 0)), fp - float2(1, 0));
            float d11 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 1)), fp - float2(1, 1));
            fp = fp * fp * fp * (fp * (fp * 6 - 15) + 10);
            Out = lerp(lerp(d00, d01, fp.y), lerp(d10, d11, fp.y), fp.x) + 0.5;
        }
        
        void Unity_Add_float(float A, float B, out float Out)
        {
            Out = A + B;
        }
        
        void Unity_Saturate_float(float In, out float Out)
        {
            Out = saturate(In);
        }
        
        void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
        {
            RGBA = float4(R, G, B, A);
            RGB = float3(R, G, B);
            RG = float2(R, G);
        }
        
        void Unity_Remap_float(float In, float2 InMinMax, float2 OutMinMax, out float Out)
        {
            Out = OutMinMax.x + (In - InMinMax.x) * (OutMinMax.y - OutMinMax.x) / (InMinMax.y - InMinMax.x);
        }
        
        void Unity_Absolute_float(float In, out float Out)
        {
            Out = abs(In);
        }
        
        void Unity_Smoothstep_float(float Edge1, float Edge2, float In, out float Out)
        {
            Out = smoothstep(Edge1, Edge2, In);
        }
        
        void Unity_Add_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A + B;
        }
        
        void Unity_SceneDepth_Eye_float(float4 UV, out float Out)
        {
            if (unity_OrthoParams.w == 1.0)
            {
                Out = LinearEyeDepth(ComputeWorldSpacePosition(UV.xy, SHADERGRAPH_SAMPLE_SCENE_DEPTH(UV.xy), UNITY_MATRIX_I_VP), UNITY_MATRIX_V);
            }
            else
            {
                Out = LinearEyeDepth(SHADERGRAPH_SAMPLE_SCENE_DEPTH(UV.xy), _ZBufferParams);
            }
        }
        
        void Unity_Subtract_float(float A, float B, out float Out)
        {
            Out = A - B;
        }
        
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
            float _Distance_c01ba79505ea4a8891c3da5756fe9e5a_Out_2;
            Unity_Distance_float3(SHADERGRAPH_OBJECT_POSITION, IN.WorldSpacePosition, _Distance_c01ba79505ea4a8891c3da5756fe9e5a_Out_2);
            float _Property_d1be4d71eb4e4aae9337b9b402f45d63_Out_0 = _Curvature_Radius;
            float _Divide_03646e2359744ec38397913fc1d7c270_Out_2;
            Unity_Divide_float(_Distance_c01ba79505ea4a8891c3da5756fe9e5a_Out_2, _Property_d1be4d71eb4e4aae9337b9b402f45d63_Out_0, _Divide_03646e2359744ec38397913fc1d7c270_Out_2);
            float _Power_07f0eac51f1244fbb5c4966f586ac4dc_Out_2;
            Unity_Power_float(_Divide_03646e2359744ec38397913fc1d7c270_Out_2, 3, _Power_07f0eac51f1244fbb5c4966f586ac4dc_Out_2);
            float3 _Multiply_5ca41a1165784fbe980a8c3177fad7e1_Out_2;
            Unity_Multiply_float3_float3(IN.WorldSpaceNormal, (_Power_07f0eac51f1244fbb5c4966f586ac4dc_Out_2.xxx), _Multiply_5ca41a1165784fbe980a8c3177fad7e1_Out_2);
            float _Property_ef386ec2d5f4434a8a5f934ff230322f_Out_0 = _Noise_Edge_1;
            float _Property_147f1a2515e04a399eed34de35cf1107_Out_0 = _Noise_Edge_2;
            float4 _Property_b84368a6bae8433994c8bf5d771c01f4_Out_0 = _Rotate_Projection;
            float _Split_31db8d949ab24fd1b5ded76e6ecb6868_R_1 = _Property_b84368a6bae8433994c8bf5d771c01f4_Out_0[0];
            float _Split_31db8d949ab24fd1b5ded76e6ecb6868_G_2 = _Property_b84368a6bae8433994c8bf5d771c01f4_Out_0[1];
            float _Split_31db8d949ab24fd1b5ded76e6ecb6868_B_3 = _Property_b84368a6bae8433994c8bf5d771c01f4_Out_0[2];
            float _Split_31db8d949ab24fd1b5ded76e6ecb6868_A_4 = _Property_b84368a6bae8433994c8bf5d771c01f4_Out_0[3];
            float3 _RotateAboutAxis_6e7d2784bd02405faeb7bacb567d0731_Out_3;
            Unity_Rotate_About_Axis_Degrees_float(IN.WorldSpacePosition, (_Property_b84368a6bae8433994c8bf5d771c01f4_Out_0.xyz), _Split_31db8d949ab24fd1b5ded76e6ecb6868_A_4, _RotateAboutAxis_6e7d2784bd02405faeb7bacb567d0731_Out_3);
            float _Property_1b5acb9aca4b4c1ca8150917cb29e38d_Out_0 = _Noise_Speed;
            float _Multiply_a1f01de168c5412e848fa5a9a4f633d8_Out_2;
            Unity_Multiply_float_float(IN.TimeParameters.x, _Property_1b5acb9aca4b4c1ca8150917cb29e38d_Out_0, _Multiply_a1f01de168c5412e848fa5a9a4f633d8_Out_2);
            float2 _TilingAndOffset_3a22eccd71474e639594fce72cde2d02_Out_3;
            Unity_TilingAndOffset_float((_RotateAboutAxis_6e7d2784bd02405faeb7bacb567d0731_Out_3.xy), float2 (1, 1), (_Multiply_a1f01de168c5412e848fa5a9a4f633d8_Out_2.xx), _TilingAndOffset_3a22eccd71474e639594fce72cde2d02_Out_3);
            float _Property_e34f89cb08684afb94f0ac41ba675b11_Out_0 = _Noise_Scale;
            float _GradientNoise_71dea3d8ca7f493a820838ec4624d407_Out_2;
            Unity_GradientNoise_float(_TilingAndOffset_3a22eccd71474e639594fce72cde2d02_Out_3, _Property_e34f89cb08684afb94f0ac41ba675b11_Out_0, _GradientNoise_71dea3d8ca7f493a820838ec4624d407_Out_2);
            float2 _TilingAndOffset_b402f80311694eb4b5a4c3d07e71c615_Out_3;
            Unity_TilingAndOffset_float((_RotateAboutAxis_6e7d2784bd02405faeb7bacb567d0731_Out_3.xy), float2 (1, 1), float2 (0, 0), _TilingAndOffset_b402f80311694eb4b5a4c3d07e71c615_Out_3);
            float _GradientNoise_7cfc31faa781410090b11ae418c9e103_Out_2;
            Unity_GradientNoise_float(_TilingAndOffset_b402f80311694eb4b5a4c3d07e71c615_Out_3, _Property_e34f89cb08684afb94f0ac41ba675b11_Out_0, _GradientNoise_7cfc31faa781410090b11ae418c9e103_Out_2);
            float _Add_8d3a946d8f7848c0a6a4ee9e280c511d_Out_2;
            Unity_Add_float(_GradientNoise_71dea3d8ca7f493a820838ec4624d407_Out_2, _GradientNoise_7cfc31faa781410090b11ae418c9e103_Out_2, _Add_8d3a946d8f7848c0a6a4ee9e280c511d_Out_2);
            float _Divide_883697060c4b42898d76bc5325a5b568_Out_2;
            Unity_Divide_float(_Add_8d3a946d8f7848c0a6a4ee9e280c511d_Out_2, 2, _Divide_883697060c4b42898d76bc5325a5b568_Out_2);
            float _Saturate_c96331ef3b2642d39a446bce3d43f560_Out_1;
            Unity_Saturate_float(_Divide_883697060c4b42898d76bc5325a5b568_Out_2, _Saturate_c96331ef3b2642d39a446bce3d43f560_Out_1);
            float _Property_a5e2c659762f49e2826023553b233885_Out_0 = _Noise_Power;
            float _Power_fe5fa4a062ff4bac868501be2a7f055c_Out_2;
            Unity_Power_float(_Saturate_c96331ef3b2642d39a446bce3d43f560_Out_1, _Property_a5e2c659762f49e2826023553b233885_Out_0, _Power_fe5fa4a062ff4bac868501be2a7f055c_Out_2);
            float4 _Property_f466dd4679cc4567b14cecb45e839124_Out_0 = _Noise_Remap;
            float _Split_cfe4e3a30c93414694a4d7e49c708985_R_1 = _Property_f466dd4679cc4567b14cecb45e839124_Out_0[0];
            float _Split_cfe4e3a30c93414694a4d7e49c708985_G_2 = _Property_f466dd4679cc4567b14cecb45e839124_Out_0[1];
            float _Split_cfe4e3a30c93414694a4d7e49c708985_B_3 = _Property_f466dd4679cc4567b14cecb45e839124_Out_0[2];
            float _Split_cfe4e3a30c93414694a4d7e49c708985_A_4 = _Property_f466dd4679cc4567b14cecb45e839124_Out_0[3];
            float4 _Combine_c045c4c659354461848cd6c7d61e4be5_RGBA_4;
            float3 _Combine_c045c4c659354461848cd6c7d61e4be5_RGB_5;
            float2 _Combine_c045c4c659354461848cd6c7d61e4be5_RG_6;
            Unity_Combine_float(_Split_cfe4e3a30c93414694a4d7e49c708985_R_1, _Split_cfe4e3a30c93414694a4d7e49c708985_G_2, 0, 0, _Combine_c045c4c659354461848cd6c7d61e4be5_RGBA_4, _Combine_c045c4c659354461848cd6c7d61e4be5_RGB_5, _Combine_c045c4c659354461848cd6c7d61e4be5_RG_6);
            float4 _Combine_6de15c52675e489b874b27eaf16323df_RGBA_4;
            float3 _Combine_6de15c52675e489b874b27eaf16323df_RGB_5;
            float2 _Combine_6de15c52675e489b874b27eaf16323df_RG_6;
            Unity_Combine_float(_Split_cfe4e3a30c93414694a4d7e49c708985_B_3, _Split_cfe4e3a30c93414694a4d7e49c708985_A_4, 0, 0, _Combine_6de15c52675e489b874b27eaf16323df_RGBA_4, _Combine_6de15c52675e489b874b27eaf16323df_RGB_5, _Combine_6de15c52675e489b874b27eaf16323df_RG_6);
            float _Remap_192e92b0649c4e009e825f27b2499763_Out_3;
            Unity_Remap_float(_Power_fe5fa4a062ff4bac868501be2a7f055c_Out_2, _Combine_c045c4c659354461848cd6c7d61e4be5_RG_6, _Combine_6de15c52675e489b874b27eaf16323df_RG_6, _Remap_192e92b0649c4e009e825f27b2499763_Out_3);
            float _Absolute_d5fceabb74744431b85e0fdda3c8cf5c_Out_1;
            Unity_Absolute_float(_Remap_192e92b0649c4e009e825f27b2499763_Out_3, _Absolute_d5fceabb74744431b85e0fdda3c8cf5c_Out_1);
            float _Smoothstep_5b3511aa53f74a73b9b9614372a6af74_Out_3;
            Unity_Smoothstep_float(_Property_ef386ec2d5f4434a8a5f934ff230322f_Out_0, _Property_147f1a2515e04a399eed34de35cf1107_Out_0, _Absolute_d5fceabb74744431b85e0fdda3c8cf5c_Out_1, _Smoothstep_5b3511aa53f74a73b9b9614372a6af74_Out_3);
            float _Property_8fb0c3dbf4a84403a6068e70183a7ea4_Out_0 = _Base_Speed;
            float _Multiply_774f493cd66541e7ba6553802a499b79_Out_2;
            Unity_Multiply_float_float(IN.TimeParameters.x, _Property_8fb0c3dbf4a84403a6068e70183a7ea4_Out_0, _Multiply_774f493cd66541e7ba6553802a499b79_Out_2);
            float2 _TilingAndOffset_969b7b642fd04ed7b2592123a03eca18_Out_3;
            Unity_TilingAndOffset_float((_RotateAboutAxis_6e7d2784bd02405faeb7bacb567d0731_Out_3.xy), float2 (1, 1), (_Multiply_774f493cd66541e7ba6553802a499b79_Out_2.xx), _TilingAndOffset_969b7b642fd04ed7b2592123a03eca18_Out_3);
            float _Property_e3b00c3a5e804e14a1e03e69aac49211_Out_0 = _Base_Scale;
            float _GradientNoise_04262dfbc1b540b1a9d9b997627f189b_Out_2;
            Unity_GradientNoise_float(_TilingAndOffset_969b7b642fd04ed7b2592123a03eca18_Out_3, _Property_e3b00c3a5e804e14a1e03e69aac49211_Out_0, _GradientNoise_04262dfbc1b540b1a9d9b997627f189b_Out_2);
            float _Property_17938a6d7e2f40dd8d0f1b984a9fbb59_Out_0 = _Base_Strength;
            float _Multiply_0854b1bc83aa4170a68f058b8cb96ff7_Out_2;
            Unity_Multiply_float_float(_GradientNoise_04262dfbc1b540b1a9d9b997627f189b_Out_2, _Property_17938a6d7e2f40dd8d0f1b984a9fbb59_Out_0, _Multiply_0854b1bc83aa4170a68f058b8cb96ff7_Out_2);
            float _Add_f82d9f056cbf456f911125a9574d865f_Out_2;
            Unity_Add_float(_Smoothstep_5b3511aa53f74a73b9b9614372a6af74_Out_3, _Multiply_0854b1bc83aa4170a68f058b8cb96ff7_Out_2, _Add_f82d9f056cbf456f911125a9574d865f_Out_2);
            float _Add_df54866b810e4151a1fde09a51f17b65_Out_2;
            Unity_Add_float(1, _Property_17938a6d7e2f40dd8d0f1b984a9fbb59_Out_0, _Add_df54866b810e4151a1fde09a51f17b65_Out_2);
            float _Divide_b2c87465e89040e4940d7d7f42943c3f_Out_2;
            Unity_Divide_float(_Add_f82d9f056cbf456f911125a9574d865f_Out_2, _Add_df54866b810e4151a1fde09a51f17b65_Out_2, _Divide_b2c87465e89040e4940d7d7f42943c3f_Out_2);
            float3 _Multiply_cc4eb1139ae74d4c85067f5171acc955_Out_2;
            Unity_Multiply_float3_float3(IN.ObjectSpaceNormal, (_Divide_b2c87465e89040e4940d7d7f42943c3f_Out_2.xxx), _Multiply_cc4eb1139ae74d4c85067f5171acc955_Out_2);
            float _Property_611696cf692e4bb19aaf7739c57cdd44_Out_0 = _Noise_Height;
            float3 _Multiply_da4791b114e34eceac3bacbb1043285e_Out_2;
            Unity_Multiply_float3_float3(_Multiply_cc4eb1139ae74d4c85067f5171acc955_Out_2, (_Property_611696cf692e4bb19aaf7739c57cdd44_Out_0.xxx), _Multiply_da4791b114e34eceac3bacbb1043285e_Out_2);
            float3 _Add_1af6468ff1e344348b74bd929f252cbf_Out_2;
            Unity_Add_float3(IN.ObjectSpacePosition, _Multiply_da4791b114e34eceac3bacbb1043285e_Out_2, _Add_1af6468ff1e344348b74bd929f252cbf_Out_2);
            float3 _Add_c7842509b95b4858bfbf1f91fea0a4c3_Out_2;
            Unity_Add_float3(_Multiply_5ca41a1165784fbe980a8c3177fad7e1_Out_2, _Add_1af6468ff1e344348b74bd929f252cbf_Out_2, _Add_c7842509b95b4858bfbf1f91fea0a4c3_Out_2);
            description.Position = _Add_c7842509b95b4858bfbf1f91fea0a4c3_Out_2;
            description.Normal = IN.ObjectSpaceNormal;
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
            float Alpha;
            float AlphaClipThreshold;
        };
        
        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            float _SceneDepth_92d0d826f11444f38ddac1aa18b54491_Out_1;
            Unity_SceneDepth_Eye_float(float4(IN.ScreenPosition.xy / IN.ScreenPosition.w, 0, 0), _SceneDepth_92d0d826f11444f38ddac1aa18b54491_Out_1);
            float4 _ScreenPosition_a43e7cd4d3c742149035c252ba0d4ec9_Out_0 = IN.ScreenPosition;
            float _Split_945e233c5d5644b39c8f24743ae9b880_R_1 = _ScreenPosition_a43e7cd4d3c742149035c252ba0d4ec9_Out_0[0];
            float _Split_945e233c5d5644b39c8f24743ae9b880_G_2 = _ScreenPosition_a43e7cd4d3c742149035c252ba0d4ec9_Out_0[1];
            float _Split_945e233c5d5644b39c8f24743ae9b880_B_3 = _ScreenPosition_a43e7cd4d3c742149035c252ba0d4ec9_Out_0[2];
            float _Split_945e233c5d5644b39c8f24743ae9b880_A_4 = _ScreenPosition_a43e7cd4d3c742149035c252ba0d4ec9_Out_0[3];
            float _Subtract_509aa90668e7408bad7076496f9d5759_Out_2;
            Unity_Subtract_float(_Split_945e233c5d5644b39c8f24743ae9b880_A_4, 1, _Subtract_509aa90668e7408bad7076496f9d5759_Out_2);
            float _Subtract_72c15d8c0496460ca2c6aaf585c41381_Out_2;
            Unity_Subtract_float(_SceneDepth_92d0d826f11444f38ddac1aa18b54491_Out_1, _Subtract_509aa90668e7408bad7076496f9d5759_Out_2, _Subtract_72c15d8c0496460ca2c6aaf585c41381_Out_2);
            float _Property_3a30c5a5cbf24fa6913c8ee537ee5f4b_Out_0 = _Fade_Depth;
            float _Divide_8b2505abc71b4c3f8954d6fb229e0865_Out_2;
            Unity_Divide_float(_Subtract_72c15d8c0496460ca2c6aaf585c41381_Out_2, _Property_3a30c5a5cbf24fa6913c8ee537ee5f4b_Out_0, _Divide_8b2505abc71b4c3f8954d6fb229e0865_Out_2);
            float _Saturate_3c60f55f62d842639e72ca2a20ce74df_Out_1;
            Unity_Saturate_float(_Divide_8b2505abc71b4c3f8954d6fb229e0865_Out_2, _Saturate_3c60f55f62d842639e72ca2a20ce74df_Out_1);
            surface.Alpha = _Saturate_3c60f55f62d842639e72ca2a20ce74df_Out_1;
            surface.AlphaClipThreshold = 0.5;
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
            output.WorldSpaceNormal =                           TransformObjectToWorldNormal(input.normalOS);
            output.ObjectSpaceTangent =                         input.tangentOS.xyz;
            output.ObjectSpacePosition =                        input.positionOS;
            output.WorldSpacePosition =                         TransformObjectToWorld(input.positionOS);
            output.TimeParameters =                             _TimeParameters.xyz;
        
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
        
            
        
        
        
        
        
            output.WorldSpacePosition = input.positionWS;
            output.ScreenPosition = ComputeScreenPos(TransformWorldToHClip(input.positionWS), _ProjectionParams.x);
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
        #pragma target 2.0
        #pragma only_renderers gles gles3 glcore d3d11
        #pragma multi_compile_instancing
        #pragma vertex vert
        #pragma fragment frag
        
        // DotsInstancingOptions: <None>
        // HybridV1InjectedBuiltinProperties: <None>
        
        // Keywords
        #pragma shader_feature_local_fragment _ _ALPHATEST_ON
        // GraphKeywords: <None>
        
        // Defines
        
        #define ATTRIBUTES_NEED_NORMAL
        #define ATTRIBUTES_NEED_TANGENT
        #define VARYINGS_NEED_POSITION_WS
        #define FEATURES_GRAPH_VERTEX
        /* WARNING: $splice Could not find named fragment 'PassInstancing' */
        #define SHADERPASS SHADERPASS_DEPTHONLY
        #define SCENESELECTIONPASS 1
        #define ALPHA_CLIP_THRESHOLD 1
        #define REQUIRE_DEPTH_TEXTURE
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
             float3 positionWS;
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
             float3 WorldSpacePosition;
             float4 ScreenPosition;
        };
        struct VertexDescriptionInputs
        {
             float3 ObjectSpaceNormal;
             float3 WorldSpaceNormal;
             float3 ObjectSpaceTangent;
             float3 ObjectSpacePosition;
             float3 WorldSpacePosition;
             float3 TimeParameters;
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
            output.interp0.xyz =  input.positionWS;
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
        float4 _Rotate_Projection;
        float _Noise_Scale;
        float _Noise_Speed;
        float _Noise_Height;
        float4 _Noise_Remap;
        float4 _Colour_Peak;
        float4 _Colour_Valley;
        float _Noise_Edge_1;
        float _Noise_Edge_2;
        float _Noise_Power;
        float _Base_Scale;
        float _Base_Speed;
        float _Base_Strength;
        float _Emission;
        float _Curvature_Radius;
        float _Fresnel_Power;
        float _Fresnel_opacity;
        float _Fade_Depth;
        CBUFFER_END
        
        // Object and Global properties
        
        // Graph Includes
        // GraphIncludes: <None>
        
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
        
        void Unity_Distance_float3(float3 A, float3 B, out float Out)
        {
            Out = distance(A, B);
        }
        
        void Unity_Divide_float(float A, float B, out float Out)
        {
            Out = A / B;
        }
        
        void Unity_Power_float(float A, float B, out float Out)
        {
            Out = pow(A, B);
        }
        
        void Unity_Multiply_float3_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A * B;
        }
        
        void Unity_Rotate_About_Axis_Degrees_float(float3 In, float3 Axis, float Rotation, out float3 Out)
        {
            Rotation = radians(Rotation);
        
            float s = sin(Rotation);
            float c = cos(Rotation);
            float one_minus_c = 1.0 - c;
        
            Axis = normalize(Axis);
        
            float3x3 rot_mat = { one_minus_c * Axis.x * Axis.x + c,            one_minus_c * Axis.x * Axis.y - Axis.z * s,     one_minus_c * Axis.z * Axis.x + Axis.y * s,
                                      one_minus_c * Axis.x * Axis.y + Axis.z * s,   one_minus_c * Axis.y * Axis.y + c,              one_minus_c * Axis.y * Axis.z - Axis.x * s,
                                      one_minus_c * Axis.z * Axis.x - Axis.y * s,   one_minus_c * Axis.y * Axis.z + Axis.x * s,     one_minus_c * Axis.z * Axis.z + c
                                    };
        
            Out = mul(rot_mat,  In);
        }
        
        void Unity_Multiply_float_float(float A, float B, out float Out)
        {
            Out = A * B;
        }
        
        void Unity_TilingAndOffset_float(float2 UV, float2 Tiling, float2 Offset, out float2 Out)
        {
            Out = UV * Tiling + Offset;
        }
        
        
        float2 Unity_GradientNoise_Dir_float(float2 p)
        {
            // Permutation and hashing used in webgl-nosie goo.gl/pX7HtC
            p = p % 289;
            // need full precision, otherwise half overflows when p > 1
            float x = float(34 * p.x + 1) * p.x % 289 + p.y;
            x = (34 * x + 1) * x % 289;
            x = frac(x / 41) * 2 - 1;
            return normalize(float2(x - floor(x + 0.5), abs(x) - 0.5));
        }
        
        void Unity_GradientNoise_float(float2 UV, float Scale, out float Out)
        {
            float2 p = UV * Scale;
            float2 ip = floor(p);
            float2 fp = frac(p);
            float d00 = dot(Unity_GradientNoise_Dir_float(ip), fp);
            float d01 = dot(Unity_GradientNoise_Dir_float(ip + float2(0, 1)), fp - float2(0, 1));
            float d10 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 0)), fp - float2(1, 0));
            float d11 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 1)), fp - float2(1, 1));
            fp = fp * fp * fp * (fp * (fp * 6 - 15) + 10);
            Out = lerp(lerp(d00, d01, fp.y), lerp(d10, d11, fp.y), fp.x) + 0.5;
        }
        
        void Unity_Add_float(float A, float B, out float Out)
        {
            Out = A + B;
        }
        
        void Unity_Saturate_float(float In, out float Out)
        {
            Out = saturate(In);
        }
        
        void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
        {
            RGBA = float4(R, G, B, A);
            RGB = float3(R, G, B);
            RG = float2(R, G);
        }
        
        void Unity_Remap_float(float In, float2 InMinMax, float2 OutMinMax, out float Out)
        {
            Out = OutMinMax.x + (In - InMinMax.x) * (OutMinMax.y - OutMinMax.x) / (InMinMax.y - InMinMax.x);
        }
        
        void Unity_Absolute_float(float In, out float Out)
        {
            Out = abs(In);
        }
        
        void Unity_Smoothstep_float(float Edge1, float Edge2, float In, out float Out)
        {
            Out = smoothstep(Edge1, Edge2, In);
        }
        
        void Unity_Add_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A + B;
        }
        
        void Unity_SceneDepth_Eye_float(float4 UV, out float Out)
        {
            if (unity_OrthoParams.w == 1.0)
            {
                Out = LinearEyeDepth(ComputeWorldSpacePosition(UV.xy, SHADERGRAPH_SAMPLE_SCENE_DEPTH(UV.xy), UNITY_MATRIX_I_VP), UNITY_MATRIX_V);
            }
            else
            {
                Out = LinearEyeDepth(SHADERGRAPH_SAMPLE_SCENE_DEPTH(UV.xy), _ZBufferParams);
            }
        }
        
        void Unity_Subtract_float(float A, float B, out float Out)
        {
            Out = A - B;
        }
        
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
            float _Distance_c01ba79505ea4a8891c3da5756fe9e5a_Out_2;
            Unity_Distance_float3(SHADERGRAPH_OBJECT_POSITION, IN.WorldSpacePosition, _Distance_c01ba79505ea4a8891c3da5756fe9e5a_Out_2);
            float _Property_d1be4d71eb4e4aae9337b9b402f45d63_Out_0 = _Curvature_Radius;
            float _Divide_03646e2359744ec38397913fc1d7c270_Out_2;
            Unity_Divide_float(_Distance_c01ba79505ea4a8891c3da5756fe9e5a_Out_2, _Property_d1be4d71eb4e4aae9337b9b402f45d63_Out_0, _Divide_03646e2359744ec38397913fc1d7c270_Out_2);
            float _Power_07f0eac51f1244fbb5c4966f586ac4dc_Out_2;
            Unity_Power_float(_Divide_03646e2359744ec38397913fc1d7c270_Out_2, 3, _Power_07f0eac51f1244fbb5c4966f586ac4dc_Out_2);
            float3 _Multiply_5ca41a1165784fbe980a8c3177fad7e1_Out_2;
            Unity_Multiply_float3_float3(IN.WorldSpaceNormal, (_Power_07f0eac51f1244fbb5c4966f586ac4dc_Out_2.xxx), _Multiply_5ca41a1165784fbe980a8c3177fad7e1_Out_2);
            float _Property_ef386ec2d5f4434a8a5f934ff230322f_Out_0 = _Noise_Edge_1;
            float _Property_147f1a2515e04a399eed34de35cf1107_Out_0 = _Noise_Edge_2;
            float4 _Property_b84368a6bae8433994c8bf5d771c01f4_Out_0 = _Rotate_Projection;
            float _Split_31db8d949ab24fd1b5ded76e6ecb6868_R_1 = _Property_b84368a6bae8433994c8bf5d771c01f4_Out_0[0];
            float _Split_31db8d949ab24fd1b5ded76e6ecb6868_G_2 = _Property_b84368a6bae8433994c8bf5d771c01f4_Out_0[1];
            float _Split_31db8d949ab24fd1b5ded76e6ecb6868_B_3 = _Property_b84368a6bae8433994c8bf5d771c01f4_Out_0[2];
            float _Split_31db8d949ab24fd1b5ded76e6ecb6868_A_4 = _Property_b84368a6bae8433994c8bf5d771c01f4_Out_0[3];
            float3 _RotateAboutAxis_6e7d2784bd02405faeb7bacb567d0731_Out_3;
            Unity_Rotate_About_Axis_Degrees_float(IN.WorldSpacePosition, (_Property_b84368a6bae8433994c8bf5d771c01f4_Out_0.xyz), _Split_31db8d949ab24fd1b5ded76e6ecb6868_A_4, _RotateAboutAxis_6e7d2784bd02405faeb7bacb567d0731_Out_3);
            float _Property_1b5acb9aca4b4c1ca8150917cb29e38d_Out_0 = _Noise_Speed;
            float _Multiply_a1f01de168c5412e848fa5a9a4f633d8_Out_2;
            Unity_Multiply_float_float(IN.TimeParameters.x, _Property_1b5acb9aca4b4c1ca8150917cb29e38d_Out_0, _Multiply_a1f01de168c5412e848fa5a9a4f633d8_Out_2);
            float2 _TilingAndOffset_3a22eccd71474e639594fce72cde2d02_Out_3;
            Unity_TilingAndOffset_float((_RotateAboutAxis_6e7d2784bd02405faeb7bacb567d0731_Out_3.xy), float2 (1, 1), (_Multiply_a1f01de168c5412e848fa5a9a4f633d8_Out_2.xx), _TilingAndOffset_3a22eccd71474e639594fce72cde2d02_Out_3);
            float _Property_e34f89cb08684afb94f0ac41ba675b11_Out_0 = _Noise_Scale;
            float _GradientNoise_71dea3d8ca7f493a820838ec4624d407_Out_2;
            Unity_GradientNoise_float(_TilingAndOffset_3a22eccd71474e639594fce72cde2d02_Out_3, _Property_e34f89cb08684afb94f0ac41ba675b11_Out_0, _GradientNoise_71dea3d8ca7f493a820838ec4624d407_Out_2);
            float2 _TilingAndOffset_b402f80311694eb4b5a4c3d07e71c615_Out_3;
            Unity_TilingAndOffset_float((_RotateAboutAxis_6e7d2784bd02405faeb7bacb567d0731_Out_3.xy), float2 (1, 1), float2 (0, 0), _TilingAndOffset_b402f80311694eb4b5a4c3d07e71c615_Out_3);
            float _GradientNoise_7cfc31faa781410090b11ae418c9e103_Out_2;
            Unity_GradientNoise_float(_TilingAndOffset_b402f80311694eb4b5a4c3d07e71c615_Out_3, _Property_e34f89cb08684afb94f0ac41ba675b11_Out_0, _GradientNoise_7cfc31faa781410090b11ae418c9e103_Out_2);
            float _Add_8d3a946d8f7848c0a6a4ee9e280c511d_Out_2;
            Unity_Add_float(_GradientNoise_71dea3d8ca7f493a820838ec4624d407_Out_2, _GradientNoise_7cfc31faa781410090b11ae418c9e103_Out_2, _Add_8d3a946d8f7848c0a6a4ee9e280c511d_Out_2);
            float _Divide_883697060c4b42898d76bc5325a5b568_Out_2;
            Unity_Divide_float(_Add_8d3a946d8f7848c0a6a4ee9e280c511d_Out_2, 2, _Divide_883697060c4b42898d76bc5325a5b568_Out_2);
            float _Saturate_c96331ef3b2642d39a446bce3d43f560_Out_1;
            Unity_Saturate_float(_Divide_883697060c4b42898d76bc5325a5b568_Out_2, _Saturate_c96331ef3b2642d39a446bce3d43f560_Out_1);
            float _Property_a5e2c659762f49e2826023553b233885_Out_0 = _Noise_Power;
            float _Power_fe5fa4a062ff4bac868501be2a7f055c_Out_2;
            Unity_Power_float(_Saturate_c96331ef3b2642d39a446bce3d43f560_Out_1, _Property_a5e2c659762f49e2826023553b233885_Out_0, _Power_fe5fa4a062ff4bac868501be2a7f055c_Out_2);
            float4 _Property_f466dd4679cc4567b14cecb45e839124_Out_0 = _Noise_Remap;
            float _Split_cfe4e3a30c93414694a4d7e49c708985_R_1 = _Property_f466dd4679cc4567b14cecb45e839124_Out_0[0];
            float _Split_cfe4e3a30c93414694a4d7e49c708985_G_2 = _Property_f466dd4679cc4567b14cecb45e839124_Out_0[1];
            float _Split_cfe4e3a30c93414694a4d7e49c708985_B_3 = _Property_f466dd4679cc4567b14cecb45e839124_Out_0[2];
            float _Split_cfe4e3a30c93414694a4d7e49c708985_A_4 = _Property_f466dd4679cc4567b14cecb45e839124_Out_0[3];
            float4 _Combine_c045c4c659354461848cd6c7d61e4be5_RGBA_4;
            float3 _Combine_c045c4c659354461848cd6c7d61e4be5_RGB_5;
            float2 _Combine_c045c4c659354461848cd6c7d61e4be5_RG_6;
            Unity_Combine_float(_Split_cfe4e3a30c93414694a4d7e49c708985_R_1, _Split_cfe4e3a30c93414694a4d7e49c708985_G_2, 0, 0, _Combine_c045c4c659354461848cd6c7d61e4be5_RGBA_4, _Combine_c045c4c659354461848cd6c7d61e4be5_RGB_5, _Combine_c045c4c659354461848cd6c7d61e4be5_RG_6);
            float4 _Combine_6de15c52675e489b874b27eaf16323df_RGBA_4;
            float3 _Combine_6de15c52675e489b874b27eaf16323df_RGB_5;
            float2 _Combine_6de15c52675e489b874b27eaf16323df_RG_6;
            Unity_Combine_float(_Split_cfe4e3a30c93414694a4d7e49c708985_B_3, _Split_cfe4e3a30c93414694a4d7e49c708985_A_4, 0, 0, _Combine_6de15c52675e489b874b27eaf16323df_RGBA_4, _Combine_6de15c52675e489b874b27eaf16323df_RGB_5, _Combine_6de15c52675e489b874b27eaf16323df_RG_6);
            float _Remap_192e92b0649c4e009e825f27b2499763_Out_3;
            Unity_Remap_float(_Power_fe5fa4a062ff4bac868501be2a7f055c_Out_2, _Combine_c045c4c659354461848cd6c7d61e4be5_RG_6, _Combine_6de15c52675e489b874b27eaf16323df_RG_6, _Remap_192e92b0649c4e009e825f27b2499763_Out_3);
            float _Absolute_d5fceabb74744431b85e0fdda3c8cf5c_Out_1;
            Unity_Absolute_float(_Remap_192e92b0649c4e009e825f27b2499763_Out_3, _Absolute_d5fceabb74744431b85e0fdda3c8cf5c_Out_1);
            float _Smoothstep_5b3511aa53f74a73b9b9614372a6af74_Out_3;
            Unity_Smoothstep_float(_Property_ef386ec2d5f4434a8a5f934ff230322f_Out_0, _Property_147f1a2515e04a399eed34de35cf1107_Out_0, _Absolute_d5fceabb74744431b85e0fdda3c8cf5c_Out_1, _Smoothstep_5b3511aa53f74a73b9b9614372a6af74_Out_3);
            float _Property_8fb0c3dbf4a84403a6068e70183a7ea4_Out_0 = _Base_Speed;
            float _Multiply_774f493cd66541e7ba6553802a499b79_Out_2;
            Unity_Multiply_float_float(IN.TimeParameters.x, _Property_8fb0c3dbf4a84403a6068e70183a7ea4_Out_0, _Multiply_774f493cd66541e7ba6553802a499b79_Out_2);
            float2 _TilingAndOffset_969b7b642fd04ed7b2592123a03eca18_Out_3;
            Unity_TilingAndOffset_float((_RotateAboutAxis_6e7d2784bd02405faeb7bacb567d0731_Out_3.xy), float2 (1, 1), (_Multiply_774f493cd66541e7ba6553802a499b79_Out_2.xx), _TilingAndOffset_969b7b642fd04ed7b2592123a03eca18_Out_3);
            float _Property_e3b00c3a5e804e14a1e03e69aac49211_Out_0 = _Base_Scale;
            float _GradientNoise_04262dfbc1b540b1a9d9b997627f189b_Out_2;
            Unity_GradientNoise_float(_TilingAndOffset_969b7b642fd04ed7b2592123a03eca18_Out_3, _Property_e3b00c3a5e804e14a1e03e69aac49211_Out_0, _GradientNoise_04262dfbc1b540b1a9d9b997627f189b_Out_2);
            float _Property_17938a6d7e2f40dd8d0f1b984a9fbb59_Out_0 = _Base_Strength;
            float _Multiply_0854b1bc83aa4170a68f058b8cb96ff7_Out_2;
            Unity_Multiply_float_float(_GradientNoise_04262dfbc1b540b1a9d9b997627f189b_Out_2, _Property_17938a6d7e2f40dd8d0f1b984a9fbb59_Out_0, _Multiply_0854b1bc83aa4170a68f058b8cb96ff7_Out_2);
            float _Add_f82d9f056cbf456f911125a9574d865f_Out_2;
            Unity_Add_float(_Smoothstep_5b3511aa53f74a73b9b9614372a6af74_Out_3, _Multiply_0854b1bc83aa4170a68f058b8cb96ff7_Out_2, _Add_f82d9f056cbf456f911125a9574d865f_Out_2);
            float _Add_df54866b810e4151a1fde09a51f17b65_Out_2;
            Unity_Add_float(1, _Property_17938a6d7e2f40dd8d0f1b984a9fbb59_Out_0, _Add_df54866b810e4151a1fde09a51f17b65_Out_2);
            float _Divide_b2c87465e89040e4940d7d7f42943c3f_Out_2;
            Unity_Divide_float(_Add_f82d9f056cbf456f911125a9574d865f_Out_2, _Add_df54866b810e4151a1fde09a51f17b65_Out_2, _Divide_b2c87465e89040e4940d7d7f42943c3f_Out_2);
            float3 _Multiply_cc4eb1139ae74d4c85067f5171acc955_Out_2;
            Unity_Multiply_float3_float3(IN.ObjectSpaceNormal, (_Divide_b2c87465e89040e4940d7d7f42943c3f_Out_2.xxx), _Multiply_cc4eb1139ae74d4c85067f5171acc955_Out_2);
            float _Property_611696cf692e4bb19aaf7739c57cdd44_Out_0 = _Noise_Height;
            float3 _Multiply_da4791b114e34eceac3bacbb1043285e_Out_2;
            Unity_Multiply_float3_float3(_Multiply_cc4eb1139ae74d4c85067f5171acc955_Out_2, (_Property_611696cf692e4bb19aaf7739c57cdd44_Out_0.xxx), _Multiply_da4791b114e34eceac3bacbb1043285e_Out_2);
            float3 _Add_1af6468ff1e344348b74bd929f252cbf_Out_2;
            Unity_Add_float3(IN.ObjectSpacePosition, _Multiply_da4791b114e34eceac3bacbb1043285e_Out_2, _Add_1af6468ff1e344348b74bd929f252cbf_Out_2);
            float3 _Add_c7842509b95b4858bfbf1f91fea0a4c3_Out_2;
            Unity_Add_float3(_Multiply_5ca41a1165784fbe980a8c3177fad7e1_Out_2, _Add_1af6468ff1e344348b74bd929f252cbf_Out_2, _Add_c7842509b95b4858bfbf1f91fea0a4c3_Out_2);
            description.Position = _Add_c7842509b95b4858bfbf1f91fea0a4c3_Out_2;
            description.Normal = IN.ObjectSpaceNormal;
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
            float Alpha;
            float AlphaClipThreshold;
        };
        
        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            float _SceneDepth_92d0d826f11444f38ddac1aa18b54491_Out_1;
            Unity_SceneDepth_Eye_float(float4(IN.ScreenPosition.xy / IN.ScreenPosition.w, 0, 0), _SceneDepth_92d0d826f11444f38ddac1aa18b54491_Out_1);
            float4 _ScreenPosition_a43e7cd4d3c742149035c252ba0d4ec9_Out_0 = IN.ScreenPosition;
            float _Split_945e233c5d5644b39c8f24743ae9b880_R_1 = _ScreenPosition_a43e7cd4d3c742149035c252ba0d4ec9_Out_0[0];
            float _Split_945e233c5d5644b39c8f24743ae9b880_G_2 = _ScreenPosition_a43e7cd4d3c742149035c252ba0d4ec9_Out_0[1];
            float _Split_945e233c5d5644b39c8f24743ae9b880_B_3 = _ScreenPosition_a43e7cd4d3c742149035c252ba0d4ec9_Out_0[2];
            float _Split_945e233c5d5644b39c8f24743ae9b880_A_4 = _ScreenPosition_a43e7cd4d3c742149035c252ba0d4ec9_Out_0[3];
            float _Subtract_509aa90668e7408bad7076496f9d5759_Out_2;
            Unity_Subtract_float(_Split_945e233c5d5644b39c8f24743ae9b880_A_4, 1, _Subtract_509aa90668e7408bad7076496f9d5759_Out_2);
            float _Subtract_72c15d8c0496460ca2c6aaf585c41381_Out_2;
            Unity_Subtract_float(_SceneDepth_92d0d826f11444f38ddac1aa18b54491_Out_1, _Subtract_509aa90668e7408bad7076496f9d5759_Out_2, _Subtract_72c15d8c0496460ca2c6aaf585c41381_Out_2);
            float _Property_3a30c5a5cbf24fa6913c8ee537ee5f4b_Out_0 = _Fade_Depth;
            float _Divide_8b2505abc71b4c3f8954d6fb229e0865_Out_2;
            Unity_Divide_float(_Subtract_72c15d8c0496460ca2c6aaf585c41381_Out_2, _Property_3a30c5a5cbf24fa6913c8ee537ee5f4b_Out_0, _Divide_8b2505abc71b4c3f8954d6fb229e0865_Out_2);
            float _Saturate_3c60f55f62d842639e72ca2a20ce74df_Out_1;
            Unity_Saturate_float(_Divide_8b2505abc71b4c3f8954d6fb229e0865_Out_2, _Saturate_3c60f55f62d842639e72ca2a20ce74df_Out_1);
            surface.Alpha = _Saturate_3c60f55f62d842639e72ca2a20ce74df_Out_1;
            surface.AlphaClipThreshold = 0.5;
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
            output.WorldSpaceNormal =                           TransformObjectToWorldNormal(input.normalOS);
            output.ObjectSpaceTangent =                         input.tangentOS.xyz;
            output.ObjectSpacePosition =                        input.positionOS;
            output.WorldSpacePosition =                         TransformObjectToWorld(input.positionOS);
            output.TimeParameters =                             _TimeParameters.xyz;
        
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
        
            
        
        
        
        
        
            output.WorldSpacePosition = input.positionWS;
            output.ScreenPosition = ComputeScreenPos(TransformWorldToHClip(input.positionWS), _ProjectionParams.x);
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
        Cull [_Cull]
        
        // Debug
        // <None>
        
        // --------------------------------------------------
        // Pass
        
        HLSLPROGRAM
        
        // Pragmas
        #pragma target 2.0
        #pragma only_renderers gles gles3 glcore d3d11
        #pragma multi_compile_instancing
        #pragma vertex vert
        #pragma fragment frag
        
        // DotsInstancingOptions: <None>
        // HybridV1InjectedBuiltinProperties: <None>
        
        // Keywords
        #pragma shader_feature_local_fragment _ _ALPHATEST_ON
        // GraphKeywords: <None>
        
        // Defines
        
        #define ATTRIBUTES_NEED_NORMAL
        #define ATTRIBUTES_NEED_TANGENT
        #define VARYINGS_NEED_POSITION_WS
        #define FEATURES_GRAPH_VERTEX
        /* WARNING: $splice Could not find named fragment 'PassInstancing' */
        #define SHADERPASS SHADERPASS_DEPTHONLY
        #define SCENEPICKINGPASS 1
        #define ALPHA_CLIP_THRESHOLD 1
        #define REQUIRE_DEPTH_TEXTURE
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
             float3 positionWS;
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
             float3 WorldSpacePosition;
             float4 ScreenPosition;
        };
        struct VertexDescriptionInputs
        {
             float3 ObjectSpaceNormal;
             float3 WorldSpaceNormal;
             float3 ObjectSpaceTangent;
             float3 ObjectSpacePosition;
             float3 WorldSpacePosition;
             float3 TimeParameters;
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
            output.interp0.xyz =  input.positionWS;
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
        float4 _Rotate_Projection;
        float _Noise_Scale;
        float _Noise_Speed;
        float _Noise_Height;
        float4 _Noise_Remap;
        float4 _Colour_Peak;
        float4 _Colour_Valley;
        float _Noise_Edge_1;
        float _Noise_Edge_2;
        float _Noise_Power;
        float _Base_Scale;
        float _Base_Speed;
        float _Base_Strength;
        float _Emission;
        float _Curvature_Radius;
        float _Fresnel_Power;
        float _Fresnel_opacity;
        float _Fade_Depth;
        CBUFFER_END
        
        // Object and Global properties
        
        // Graph Includes
        // GraphIncludes: <None>
        
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
        
        void Unity_Distance_float3(float3 A, float3 B, out float Out)
        {
            Out = distance(A, B);
        }
        
        void Unity_Divide_float(float A, float B, out float Out)
        {
            Out = A / B;
        }
        
        void Unity_Power_float(float A, float B, out float Out)
        {
            Out = pow(A, B);
        }
        
        void Unity_Multiply_float3_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A * B;
        }
        
        void Unity_Rotate_About_Axis_Degrees_float(float3 In, float3 Axis, float Rotation, out float3 Out)
        {
            Rotation = radians(Rotation);
        
            float s = sin(Rotation);
            float c = cos(Rotation);
            float one_minus_c = 1.0 - c;
        
            Axis = normalize(Axis);
        
            float3x3 rot_mat = { one_minus_c * Axis.x * Axis.x + c,            one_minus_c * Axis.x * Axis.y - Axis.z * s,     one_minus_c * Axis.z * Axis.x + Axis.y * s,
                                      one_minus_c * Axis.x * Axis.y + Axis.z * s,   one_minus_c * Axis.y * Axis.y + c,              one_minus_c * Axis.y * Axis.z - Axis.x * s,
                                      one_minus_c * Axis.z * Axis.x - Axis.y * s,   one_minus_c * Axis.y * Axis.z + Axis.x * s,     one_minus_c * Axis.z * Axis.z + c
                                    };
        
            Out = mul(rot_mat,  In);
        }
        
        void Unity_Multiply_float_float(float A, float B, out float Out)
        {
            Out = A * B;
        }
        
        void Unity_TilingAndOffset_float(float2 UV, float2 Tiling, float2 Offset, out float2 Out)
        {
            Out = UV * Tiling + Offset;
        }
        
        
        float2 Unity_GradientNoise_Dir_float(float2 p)
        {
            // Permutation and hashing used in webgl-nosie goo.gl/pX7HtC
            p = p % 289;
            // need full precision, otherwise half overflows when p > 1
            float x = float(34 * p.x + 1) * p.x % 289 + p.y;
            x = (34 * x + 1) * x % 289;
            x = frac(x / 41) * 2 - 1;
            return normalize(float2(x - floor(x + 0.5), abs(x) - 0.5));
        }
        
        void Unity_GradientNoise_float(float2 UV, float Scale, out float Out)
        {
            float2 p = UV * Scale;
            float2 ip = floor(p);
            float2 fp = frac(p);
            float d00 = dot(Unity_GradientNoise_Dir_float(ip), fp);
            float d01 = dot(Unity_GradientNoise_Dir_float(ip + float2(0, 1)), fp - float2(0, 1));
            float d10 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 0)), fp - float2(1, 0));
            float d11 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 1)), fp - float2(1, 1));
            fp = fp * fp * fp * (fp * (fp * 6 - 15) + 10);
            Out = lerp(lerp(d00, d01, fp.y), lerp(d10, d11, fp.y), fp.x) + 0.5;
        }
        
        void Unity_Add_float(float A, float B, out float Out)
        {
            Out = A + B;
        }
        
        void Unity_Saturate_float(float In, out float Out)
        {
            Out = saturate(In);
        }
        
        void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
        {
            RGBA = float4(R, G, B, A);
            RGB = float3(R, G, B);
            RG = float2(R, G);
        }
        
        void Unity_Remap_float(float In, float2 InMinMax, float2 OutMinMax, out float Out)
        {
            Out = OutMinMax.x + (In - InMinMax.x) * (OutMinMax.y - OutMinMax.x) / (InMinMax.y - InMinMax.x);
        }
        
        void Unity_Absolute_float(float In, out float Out)
        {
            Out = abs(In);
        }
        
        void Unity_Smoothstep_float(float Edge1, float Edge2, float In, out float Out)
        {
            Out = smoothstep(Edge1, Edge2, In);
        }
        
        void Unity_Add_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A + B;
        }
        
        void Unity_SceneDepth_Eye_float(float4 UV, out float Out)
        {
            if (unity_OrthoParams.w == 1.0)
            {
                Out = LinearEyeDepth(ComputeWorldSpacePosition(UV.xy, SHADERGRAPH_SAMPLE_SCENE_DEPTH(UV.xy), UNITY_MATRIX_I_VP), UNITY_MATRIX_V);
            }
            else
            {
                Out = LinearEyeDepth(SHADERGRAPH_SAMPLE_SCENE_DEPTH(UV.xy), _ZBufferParams);
            }
        }
        
        void Unity_Subtract_float(float A, float B, out float Out)
        {
            Out = A - B;
        }
        
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
            float _Distance_c01ba79505ea4a8891c3da5756fe9e5a_Out_2;
            Unity_Distance_float3(SHADERGRAPH_OBJECT_POSITION, IN.WorldSpacePosition, _Distance_c01ba79505ea4a8891c3da5756fe9e5a_Out_2);
            float _Property_d1be4d71eb4e4aae9337b9b402f45d63_Out_0 = _Curvature_Radius;
            float _Divide_03646e2359744ec38397913fc1d7c270_Out_2;
            Unity_Divide_float(_Distance_c01ba79505ea4a8891c3da5756fe9e5a_Out_2, _Property_d1be4d71eb4e4aae9337b9b402f45d63_Out_0, _Divide_03646e2359744ec38397913fc1d7c270_Out_2);
            float _Power_07f0eac51f1244fbb5c4966f586ac4dc_Out_2;
            Unity_Power_float(_Divide_03646e2359744ec38397913fc1d7c270_Out_2, 3, _Power_07f0eac51f1244fbb5c4966f586ac4dc_Out_2);
            float3 _Multiply_5ca41a1165784fbe980a8c3177fad7e1_Out_2;
            Unity_Multiply_float3_float3(IN.WorldSpaceNormal, (_Power_07f0eac51f1244fbb5c4966f586ac4dc_Out_2.xxx), _Multiply_5ca41a1165784fbe980a8c3177fad7e1_Out_2);
            float _Property_ef386ec2d5f4434a8a5f934ff230322f_Out_0 = _Noise_Edge_1;
            float _Property_147f1a2515e04a399eed34de35cf1107_Out_0 = _Noise_Edge_2;
            float4 _Property_b84368a6bae8433994c8bf5d771c01f4_Out_0 = _Rotate_Projection;
            float _Split_31db8d949ab24fd1b5ded76e6ecb6868_R_1 = _Property_b84368a6bae8433994c8bf5d771c01f4_Out_0[0];
            float _Split_31db8d949ab24fd1b5ded76e6ecb6868_G_2 = _Property_b84368a6bae8433994c8bf5d771c01f4_Out_0[1];
            float _Split_31db8d949ab24fd1b5ded76e6ecb6868_B_3 = _Property_b84368a6bae8433994c8bf5d771c01f4_Out_0[2];
            float _Split_31db8d949ab24fd1b5ded76e6ecb6868_A_4 = _Property_b84368a6bae8433994c8bf5d771c01f4_Out_0[3];
            float3 _RotateAboutAxis_6e7d2784bd02405faeb7bacb567d0731_Out_3;
            Unity_Rotate_About_Axis_Degrees_float(IN.WorldSpacePosition, (_Property_b84368a6bae8433994c8bf5d771c01f4_Out_0.xyz), _Split_31db8d949ab24fd1b5ded76e6ecb6868_A_4, _RotateAboutAxis_6e7d2784bd02405faeb7bacb567d0731_Out_3);
            float _Property_1b5acb9aca4b4c1ca8150917cb29e38d_Out_0 = _Noise_Speed;
            float _Multiply_a1f01de168c5412e848fa5a9a4f633d8_Out_2;
            Unity_Multiply_float_float(IN.TimeParameters.x, _Property_1b5acb9aca4b4c1ca8150917cb29e38d_Out_0, _Multiply_a1f01de168c5412e848fa5a9a4f633d8_Out_2);
            float2 _TilingAndOffset_3a22eccd71474e639594fce72cde2d02_Out_3;
            Unity_TilingAndOffset_float((_RotateAboutAxis_6e7d2784bd02405faeb7bacb567d0731_Out_3.xy), float2 (1, 1), (_Multiply_a1f01de168c5412e848fa5a9a4f633d8_Out_2.xx), _TilingAndOffset_3a22eccd71474e639594fce72cde2d02_Out_3);
            float _Property_e34f89cb08684afb94f0ac41ba675b11_Out_0 = _Noise_Scale;
            float _GradientNoise_71dea3d8ca7f493a820838ec4624d407_Out_2;
            Unity_GradientNoise_float(_TilingAndOffset_3a22eccd71474e639594fce72cde2d02_Out_3, _Property_e34f89cb08684afb94f0ac41ba675b11_Out_0, _GradientNoise_71dea3d8ca7f493a820838ec4624d407_Out_2);
            float2 _TilingAndOffset_b402f80311694eb4b5a4c3d07e71c615_Out_3;
            Unity_TilingAndOffset_float((_RotateAboutAxis_6e7d2784bd02405faeb7bacb567d0731_Out_3.xy), float2 (1, 1), float2 (0, 0), _TilingAndOffset_b402f80311694eb4b5a4c3d07e71c615_Out_3);
            float _GradientNoise_7cfc31faa781410090b11ae418c9e103_Out_2;
            Unity_GradientNoise_float(_TilingAndOffset_b402f80311694eb4b5a4c3d07e71c615_Out_3, _Property_e34f89cb08684afb94f0ac41ba675b11_Out_0, _GradientNoise_7cfc31faa781410090b11ae418c9e103_Out_2);
            float _Add_8d3a946d8f7848c0a6a4ee9e280c511d_Out_2;
            Unity_Add_float(_GradientNoise_71dea3d8ca7f493a820838ec4624d407_Out_2, _GradientNoise_7cfc31faa781410090b11ae418c9e103_Out_2, _Add_8d3a946d8f7848c0a6a4ee9e280c511d_Out_2);
            float _Divide_883697060c4b42898d76bc5325a5b568_Out_2;
            Unity_Divide_float(_Add_8d3a946d8f7848c0a6a4ee9e280c511d_Out_2, 2, _Divide_883697060c4b42898d76bc5325a5b568_Out_2);
            float _Saturate_c96331ef3b2642d39a446bce3d43f560_Out_1;
            Unity_Saturate_float(_Divide_883697060c4b42898d76bc5325a5b568_Out_2, _Saturate_c96331ef3b2642d39a446bce3d43f560_Out_1);
            float _Property_a5e2c659762f49e2826023553b233885_Out_0 = _Noise_Power;
            float _Power_fe5fa4a062ff4bac868501be2a7f055c_Out_2;
            Unity_Power_float(_Saturate_c96331ef3b2642d39a446bce3d43f560_Out_1, _Property_a5e2c659762f49e2826023553b233885_Out_0, _Power_fe5fa4a062ff4bac868501be2a7f055c_Out_2);
            float4 _Property_f466dd4679cc4567b14cecb45e839124_Out_0 = _Noise_Remap;
            float _Split_cfe4e3a30c93414694a4d7e49c708985_R_1 = _Property_f466dd4679cc4567b14cecb45e839124_Out_0[0];
            float _Split_cfe4e3a30c93414694a4d7e49c708985_G_2 = _Property_f466dd4679cc4567b14cecb45e839124_Out_0[1];
            float _Split_cfe4e3a30c93414694a4d7e49c708985_B_3 = _Property_f466dd4679cc4567b14cecb45e839124_Out_0[2];
            float _Split_cfe4e3a30c93414694a4d7e49c708985_A_4 = _Property_f466dd4679cc4567b14cecb45e839124_Out_0[3];
            float4 _Combine_c045c4c659354461848cd6c7d61e4be5_RGBA_4;
            float3 _Combine_c045c4c659354461848cd6c7d61e4be5_RGB_5;
            float2 _Combine_c045c4c659354461848cd6c7d61e4be5_RG_6;
            Unity_Combine_float(_Split_cfe4e3a30c93414694a4d7e49c708985_R_1, _Split_cfe4e3a30c93414694a4d7e49c708985_G_2, 0, 0, _Combine_c045c4c659354461848cd6c7d61e4be5_RGBA_4, _Combine_c045c4c659354461848cd6c7d61e4be5_RGB_5, _Combine_c045c4c659354461848cd6c7d61e4be5_RG_6);
            float4 _Combine_6de15c52675e489b874b27eaf16323df_RGBA_4;
            float3 _Combine_6de15c52675e489b874b27eaf16323df_RGB_5;
            float2 _Combine_6de15c52675e489b874b27eaf16323df_RG_6;
            Unity_Combine_float(_Split_cfe4e3a30c93414694a4d7e49c708985_B_3, _Split_cfe4e3a30c93414694a4d7e49c708985_A_4, 0, 0, _Combine_6de15c52675e489b874b27eaf16323df_RGBA_4, _Combine_6de15c52675e489b874b27eaf16323df_RGB_5, _Combine_6de15c52675e489b874b27eaf16323df_RG_6);
            float _Remap_192e92b0649c4e009e825f27b2499763_Out_3;
            Unity_Remap_float(_Power_fe5fa4a062ff4bac868501be2a7f055c_Out_2, _Combine_c045c4c659354461848cd6c7d61e4be5_RG_6, _Combine_6de15c52675e489b874b27eaf16323df_RG_6, _Remap_192e92b0649c4e009e825f27b2499763_Out_3);
            float _Absolute_d5fceabb74744431b85e0fdda3c8cf5c_Out_1;
            Unity_Absolute_float(_Remap_192e92b0649c4e009e825f27b2499763_Out_3, _Absolute_d5fceabb74744431b85e0fdda3c8cf5c_Out_1);
            float _Smoothstep_5b3511aa53f74a73b9b9614372a6af74_Out_3;
            Unity_Smoothstep_float(_Property_ef386ec2d5f4434a8a5f934ff230322f_Out_0, _Property_147f1a2515e04a399eed34de35cf1107_Out_0, _Absolute_d5fceabb74744431b85e0fdda3c8cf5c_Out_1, _Smoothstep_5b3511aa53f74a73b9b9614372a6af74_Out_3);
            float _Property_8fb0c3dbf4a84403a6068e70183a7ea4_Out_0 = _Base_Speed;
            float _Multiply_774f493cd66541e7ba6553802a499b79_Out_2;
            Unity_Multiply_float_float(IN.TimeParameters.x, _Property_8fb0c3dbf4a84403a6068e70183a7ea4_Out_0, _Multiply_774f493cd66541e7ba6553802a499b79_Out_2);
            float2 _TilingAndOffset_969b7b642fd04ed7b2592123a03eca18_Out_3;
            Unity_TilingAndOffset_float((_RotateAboutAxis_6e7d2784bd02405faeb7bacb567d0731_Out_3.xy), float2 (1, 1), (_Multiply_774f493cd66541e7ba6553802a499b79_Out_2.xx), _TilingAndOffset_969b7b642fd04ed7b2592123a03eca18_Out_3);
            float _Property_e3b00c3a5e804e14a1e03e69aac49211_Out_0 = _Base_Scale;
            float _GradientNoise_04262dfbc1b540b1a9d9b997627f189b_Out_2;
            Unity_GradientNoise_float(_TilingAndOffset_969b7b642fd04ed7b2592123a03eca18_Out_3, _Property_e3b00c3a5e804e14a1e03e69aac49211_Out_0, _GradientNoise_04262dfbc1b540b1a9d9b997627f189b_Out_2);
            float _Property_17938a6d7e2f40dd8d0f1b984a9fbb59_Out_0 = _Base_Strength;
            float _Multiply_0854b1bc83aa4170a68f058b8cb96ff7_Out_2;
            Unity_Multiply_float_float(_GradientNoise_04262dfbc1b540b1a9d9b997627f189b_Out_2, _Property_17938a6d7e2f40dd8d0f1b984a9fbb59_Out_0, _Multiply_0854b1bc83aa4170a68f058b8cb96ff7_Out_2);
            float _Add_f82d9f056cbf456f911125a9574d865f_Out_2;
            Unity_Add_float(_Smoothstep_5b3511aa53f74a73b9b9614372a6af74_Out_3, _Multiply_0854b1bc83aa4170a68f058b8cb96ff7_Out_2, _Add_f82d9f056cbf456f911125a9574d865f_Out_2);
            float _Add_df54866b810e4151a1fde09a51f17b65_Out_2;
            Unity_Add_float(1, _Property_17938a6d7e2f40dd8d0f1b984a9fbb59_Out_0, _Add_df54866b810e4151a1fde09a51f17b65_Out_2);
            float _Divide_b2c87465e89040e4940d7d7f42943c3f_Out_2;
            Unity_Divide_float(_Add_f82d9f056cbf456f911125a9574d865f_Out_2, _Add_df54866b810e4151a1fde09a51f17b65_Out_2, _Divide_b2c87465e89040e4940d7d7f42943c3f_Out_2);
            float3 _Multiply_cc4eb1139ae74d4c85067f5171acc955_Out_2;
            Unity_Multiply_float3_float3(IN.ObjectSpaceNormal, (_Divide_b2c87465e89040e4940d7d7f42943c3f_Out_2.xxx), _Multiply_cc4eb1139ae74d4c85067f5171acc955_Out_2);
            float _Property_611696cf692e4bb19aaf7739c57cdd44_Out_0 = _Noise_Height;
            float3 _Multiply_da4791b114e34eceac3bacbb1043285e_Out_2;
            Unity_Multiply_float3_float3(_Multiply_cc4eb1139ae74d4c85067f5171acc955_Out_2, (_Property_611696cf692e4bb19aaf7739c57cdd44_Out_0.xxx), _Multiply_da4791b114e34eceac3bacbb1043285e_Out_2);
            float3 _Add_1af6468ff1e344348b74bd929f252cbf_Out_2;
            Unity_Add_float3(IN.ObjectSpacePosition, _Multiply_da4791b114e34eceac3bacbb1043285e_Out_2, _Add_1af6468ff1e344348b74bd929f252cbf_Out_2);
            float3 _Add_c7842509b95b4858bfbf1f91fea0a4c3_Out_2;
            Unity_Add_float3(_Multiply_5ca41a1165784fbe980a8c3177fad7e1_Out_2, _Add_1af6468ff1e344348b74bd929f252cbf_Out_2, _Add_c7842509b95b4858bfbf1f91fea0a4c3_Out_2);
            description.Position = _Add_c7842509b95b4858bfbf1f91fea0a4c3_Out_2;
            description.Normal = IN.ObjectSpaceNormal;
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
            float Alpha;
            float AlphaClipThreshold;
        };
        
        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            float _SceneDepth_92d0d826f11444f38ddac1aa18b54491_Out_1;
            Unity_SceneDepth_Eye_float(float4(IN.ScreenPosition.xy / IN.ScreenPosition.w, 0, 0), _SceneDepth_92d0d826f11444f38ddac1aa18b54491_Out_1);
            float4 _ScreenPosition_a43e7cd4d3c742149035c252ba0d4ec9_Out_0 = IN.ScreenPosition;
            float _Split_945e233c5d5644b39c8f24743ae9b880_R_1 = _ScreenPosition_a43e7cd4d3c742149035c252ba0d4ec9_Out_0[0];
            float _Split_945e233c5d5644b39c8f24743ae9b880_G_2 = _ScreenPosition_a43e7cd4d3c742149035c252ba0d4ec9_Out_0[1];
            float _Split_945e233c5d5644b39c8f24743ae9b880_B_3 = _ScreenPosition_a43e7cd4d3c742149035c252ba0d4ec9_Out_0[2];
            float _Split_945e233c5d5644b39c8f24743ae9b880_A_4 = _ScreenPosition_a43e7cd4d3c742149035c252ba0d4ec9_Out_0[3];
            float _Subtract_509aa90668e7408bad7076496f9d5759_Out_2;
            Unity_Subtract_float(_Split_945e233c5d5644b39c8f24743ae9b880_A_4, 1, _Subtract_509aa90668e7408bad7076496f9d5759_Out_2);
            float _Subtract_72c15d8c0496460ca2c6aaf585c41381_Out_2;
            Unity_Subtract_float(_SceneDepth_92d0d826f11444f38ddac1aa18b54491_Out_1, _Subtract_509aa90668e7408bad7076496f9d5759_Out_2, _Subtract_72c15d8c0496460ca2c6aaf585c41381_Out_2);
            float _Property_3a30c5a5cbf24fa6913c8ee537ee5f4b_Out_0 = _Fade_Depth;
            float _Divide_8b2505abc71b4c3f8954d6fb229e0865_Out_2;
            Unity_Divide_float(_Subtract_72c15d8c0496460ca2c6aaf585c41381_Out_2, _Property_3a30c5a5cbf24fa6913c8ee537ee5f4b_Out_0, _Divide_8b2505abc71b4c3f8954d6fb229e0865_Out_2);
            float _Saturate_3c60f55f62d842639e72ca2a20ce74df_Out_1;
            Unity_Saturate_float(_Divide_8b2505abc71b4c3f8954d6fb229e0865_Out_2, _Saturate_3c60f55f62d842639e72ca2a20ce74df_Out_1);
            surface.Alpha = _Saturate_3c60f55f62d842639e72ca2a20ce74df_Out_1;
            surface.AlphaClipThreshold = 0.5;
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
            output.WorldSpaceNormal =                           TransformObjectToWorldNormal(input.normalOS);
            output.ObjectSpaceTangent =                         input.tangentOS.xyz;
            output.ObjectSpacePosition =                        input.positionOS;
            output.WorldSpacePosition =                         TransformObjectToWorld(input.positionOS);
            output.TimeParameters =                             _TimeParameters.xyz;
        
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
        
            
        
        
        
        
        
            output.WorldSpacePosition = input.positionWS;
            output.ScreenPosition = ComputeScreenPos(TransformWorldToHClip(input.positionWS), _ProjectionParams.x);
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
            Name "DepthNormals"
            Tags
            {
                "LightMode" = "DepthNormalsOnly"
            }
        
        // Render State
        Cull [_Cull]
        ZTest LEqual
        ZWrite On
        
        // Debug
        // <None>
        
        // --------------------------------------------------
        // Pass
        
        HLSLPROGRAM
        
        // Pragmas
        #pragma target 2.0
        #pragma only_renderers gles gles3 glcore d3d11
        #pragma multi_compile_instancing
        #pragma multi_compile_fog
        #pragma instancing_options renderinglayer
        #pragma vertex vert
        #pragma fragment frag
        
        // DotsInstancingOptions: <None>
        // HybridV1InjectedBuiltinProperties: <None>
        
        // Keywords
        #pragma shader_feature_fragment _ _SURFACE_TYPE_TRANSPARENT
        #pragma shader_feature_local_fragment _ _ALPHAPREMULTIPLY_ON
        #pragma shader_feature_local_fragment _ _ALPHATEST_ON
        // GraphKeywords: <None>
        
        // Defines
        
        #define ATTRIBUTES_NEED_NORMAL
        #define ATTRIBUTES_NEED_TANGENT
        #define VARYINGS_NEED_POSITION_WS
        #define VARYINGS_NEED_NORMAL_WS
        #define FEATURES_GRAPH_VERTEX
        /* WARNING: $splice Could not find named fragment 'PassInstancing' */
        #define SHADERPASS SHADERPASS_DEPTHNORMALSONLY
        #define REQUIRE_DEPTH_TEXTURE
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
             float3 positionWS;
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
             float3 WorldSpacePosition;
             float4 ScreenPosition;
        };
        struct VertexDescriptionInputs
        {
             float3 ObjectSpaceNormal;
             float3 WorldSpaceNormal;
             float3 ObjectSpaceTangent;
             float3 ObjectSpacePosition;
             float3 WorldSpacePosition;
             float3 TimeParameters;
        };
        struct PackedVaryings
        {
             float4 positionCS : SV_POSITION;
             float3 interp0 : INTERP0;
             float3 interp1 : INTERP1;
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
        float4 _Rotate_Projection;
        float _Noise_Scale;
        float _Noise_Speed;
        float _Noise_Height;
        float4 _Noise_Remap;
        float4 _Colour_Peak;
        float4 _Colour_Valley;
        float _Noise_Edge_1;
        float _Noise_Edge_2;
        float _Noise_Power;
        float _Base_Scale;
        float _Base_Speed;
        float _Base_Strength;
        float _Emission;
        float _Curvature_Radius;
        float _Fresnel_Power;
        float _Fresnel_opacity;
        float _Fade_Depth;
        CBUFFER_END
        
        // Object and Global properties
        
        // Graph Includes
        // GraphIncludes: <None>
        
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
        
        void Unity_Distance_float3(float3 A, float3 B, out float Out)
        {
            Out = distance(A, B);
        }
        
        void Unity_Divide_float(float A, float B, out float Out)
        {
            Out = A / B;
        }
        
        void Unity_Power_float(float A, float B, out float Out)
        {
            Out = pow(A, B);
        }
        
        void Unity_Multiply_float3_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A * B;
        }
        
        void Unity_Rotate_About_Axis_Degrees_float(float3 In, float3 Axis, float Rotation, out float3 Out)
        {
            Rotation = radians(Rotation);
        
            float s = sin(Rotation);
            float c = cos(Rotation);
            float one_minus_c = 1.0 - c;
        
            Axis = normalize(Axis);
        
            float3x3 rot_mat = { one_minus_c * Axis.x * Axis.x + c,            one_minus_c * Axis.x * Axis.y - Axis.z * s,     one_minus_c * Axis.z * Axis.x + Axis.y * s,
                                      one_minus_c * Axis.x * Axis.y + Axis.z * s,   one_minus_c * Axis.y * Axis.y + c,              one_minus_c * Axis.y * Axis.z - Axis.x * s,
                                      one_minus_c * Axis.z * Axis.x - Axis.y * s,   one_minus_c * Axis.y * Axis.z + Axis.x * s,     one_minus_c * Axis.z * Axis.z + c
                                    };
        
            Out = mul(rot_mat,  In);
        }
        
        void Unity_Multiply_float_float(float A, float B, out float Out)
        {
            Out = A * B;
        }
        
        void Unity_TilingAndOffset_float(float2 UV, float2 Tiling, float2 Offset, out float2 Out)
        {
            Out = UV * Tiling + Offset;
        }
        
        
        float2 Unity_GradientNoise_Dir_float(float2 p)
        {
            // Permutation and hashing used in webgl-nosie goo.gl/pX7HtC
            p = p % 289;
            // need full precision, otherwise half overflows when p > 1
            float x = float(34 * p.x + 1) * p.x % 289 + p.y;
            x = (34 * x + 1) * x % 289;
            x = frac(x / 41) * 2 - 1;
            return normalize(float2(x - floor(x + 0.5), abs(x) - 0.5));
        }
        
        void Unity_GradientNoise_float(float2 UV, float Scale, out float Out)
        {
            float2 p = UV * Scale;
            float2 ip = floor(p);
            float2 fp = frac(p);
            float d00 = dot(Unity_GradientNoise_Dir_float(ip), fp);
            float d01 = dot(Unity_GradientNoise_Dir_float(ip + float2(0, 1)), fp - float2(0, 1));
            float d10 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 0)), fp - float2(1, 0));
            float d11 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 1)), fp - float2(1, 1));
            fp = fp * fp * fp * (fp * (fp * 6 - 15) + 10);
            Out = lerp(lerp(d00, d01, fp.y), lerp(d10, d11, fp.y), fp.x) + 0.5;
        }
        
        void Unity_Add_float(float A, float B, out float Out)
        {
            Out = A + B;
        }
        
        void Unity_Saturate_float(float In, out float Out)
        {
            Out = saturate(In);
        }
        
        void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
        {
            RGBA = float4(R, G, B, A);
            RGB = float3(R, G, B);
            RG = float2(R, G);
        }
        
        void Unity_Remap_float(float In, float2 InMinMax, float2 OutMinMax, out float Out)
        {
            Out = OutMinMax.x + (In - InMinMax.x) * (OutMinMax.y - OutMinMax.x) / (InMinMax.y - InMinMax.x);
        }
        
        void Unity_Absolute_float(float In, out float Out)
        {
            Out = abs(In);
        }
        
        void Unity_Smoothstep_float(float Edge1, float Edge2, float In, out float Out)
        {
            Out = smoothstep(Edge1, Edge2, In);
        }
        
        void Unity_Add_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A + B;
        }
        
        void Unity_SceneDepth_Eye_float(float4 UV, out float Out)
        {
            if (unity_OrthoParams.w == 1.0)
            {
                Out = LinearEyeDepth(ComputeWorldSpacePosition(UV.xy, SHADERGRAPH_SAMPLE_SCENE_DEPTH(UV.xy), UNITY_MATRIX_I_VP), UNITY_MATRIX_V);
            }
            else
            {
                Out = LinearEyeDepth(SHADERGRAPH_SAMPLE_SCENE_DEPTH(UV.xy), _ZBufferParams);
            }
        }
        
        void Unity_Subtract_float(float A, float B, out float Out)
        {
            Out = A - B;
        }
        
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
            float _Distance_c01ba79505ea4a8891c3da5756fe9e5a_Out_2;
            Unity_Distance_float3(SHADERGRAPH_OBJECT_POSITION, IN.WorldSpacePosition, _Distance_c01ba79505ea4a8891c3da5756fe9e5a_Out_2);
            float _Property_d1be4d71eb4e4aae9337b9b402f45d63_Out_0 = _Curvature_Radius;
            float _Divide_03646e2359744ec38397913fc1d7c270_Out_2;
            Unity_Divide_float(_Distance_c01ba79505ea4a8891c3da5756fe9e5a_Out_2, _Property_d1be4d71eb4e4aae9337b9b402f45d63_Out_0, _Divide_03646e2359744ec38397913fc1d7c270_Out_2);
            float _Power_07f0eac51f1244fbb5c4966f586ac4dc_Out_2;
            Unity_Power_float(_Divide_03646e2359744ec38397913fc1d7c270_Out_2, 3, _Power_07f0eac51f1244fbb5c4966f586ac4dc_Out_2);
            float3 _Multiply_5ca41a1165784fbe980a8c3177fad7e1_Out_2;
            Unity_Multiply_float3_float3(IN.WorldSpaceNormal, (_Power_07f0eac51f1244fbb5c4966f586ac4dc_Out_2.xxx), _Multiply_5ca41a1165784fbe980a8c3177fad7e1_Out_2);
            float _Property_ef386ec2d5f4434a8a5f934ff230322f_Out_0 = _Noise_Edge_1;
            float _Property_147f1a2515e04a399eed34de35cf1107_Out_0 = _Noise_Edge_2;
            float4 _Property_b84368a6bae8433994c8bf5d771c01f4_Out_0 = _Rotate_Projection;
            float _Split_31db8d949ab24fd1b5ded76e6ecb6868_R_1 = _Property_b84368a6bae8433994c8bf5d771c01f4_Out_0[0];
            float _Split_31db8d949ab24fd1b5ded76e6ecb6868_G_2 = _Property_b84368a6bae8433994c8bf5d771c01f4_Out_0[1];
            float _Split_31db8d949ab24fd1b5ded76e6ecb6868_B_3 = _Property_b84368a6bae8433994c8bf5d771c01f4_Out_0[2];
            float _Split_31db8d949ab24fd1b5ded76e6ecb6868_A_4 = _Property_b84368a6bae8433994c8bf5d771c01f4_Out_0[3];
            float3 _RotateAboutAxis_6e7d2784bd02405faeb7bacb567d0731_Out_3;
            Unity_Rotate_About_Axis_Degrees_float(IN.WorldSpacePosition, (_Property_b84368a6bae8433994c8bf5d771c01f4_Out_0.xyz), _Split_31db8d949ab24fd1b5ded76e6ecb6868_A_4, _RotateAboutAxis_6e7d2784bd02405faeb7bacb567d0731_Out_3);
            float _Property_1b5acb9aca4b4c1ca8150917cb29e38d_Out_0 = _Noise_Speed;
            float _Multiply_a1f01de168c5412e848fa5a9a4f633d8_Out_2;
            Unity_Multiply_float_float(IN.TimeParameters.x, _Property_1b5acb9aca4b4c1ca8150917cb29e38d_Out_0, _Multiply_a1f01de168c5412e848fa5a9a4f633d8_Out_2);
            float2 _TilingAndOffset_3a22eccd71474e639594fce72cde2d02_Out_3;
            Unity_TilingAndOffset_float((_RotateAboutAxis_6e7d2784bd02405faeb7bacb567d0731_Out_3.xy), float2 (1, 1), (_Multiply_a1f01de168c5412e848fa5a9a4f633d8_Out_2.xx), _TilingAndOffset_3a22eccd71474e639594fce72cde2d02_Out_3);
            float _Property_e34f89cb08684afb94f0ac41ba675b11_Out_0 = _Noise_Scale;
            float _GradientNoise_71dea3d8ca7f493a820838ec4624d407_Out_2;
            Unity_GradientNoise_float(_TilingAndOffset_3a22eccd71474e639594fce72cde2d02_Out_3, _Property_e34f89cb08684afb94f0ac41ba675b11_Out_0, _GradientNoise_71dea3d8ca7f493a820838ec4624d407_Out_2);
            float2 _TilingAndOffset_b402f80311694eb4b5a4c3d07e71c615_Out_3;
            Unity_TilingAndOffset_float((_RotateAboutAxis_6e7d2784bd02405faeb7bacb567d0731_Out_3.xy), float2 (1, 1), float2 (0, 0), _TilingAndOffset_b402f80311694eb4b5a4c3d07e71c615_Out_3);
            float _GradientNoise_7cfc31faa781410090b11ae418c9e103_Out_2;
            Unity_GradientNoise_float(_TilingAndOffset_b402f80311694eb4b5a4c3d07e71c615_Out_3, _Property_e34f89cb08684afb94f0ac41ba675b11_Out_0, _GradientNoise_7cfc31faa781410090b11ae418c9e103_Out_2);
            float _Add_8d3a946d8f7848c0a6a4ee9e280c511d_Out_2;
            Unity_Add_float(_GradientNoise_71dea3d8ca7f493a820838ec4624d407_Out_2, _GradientNoise_7cfc31faa781410090b11ae418c9e103_Out_2, _Add_8d3a946d8f7848c0a6a4ee9e280c511d_Out_2);
            float _Divide_883697060c4b42898d76bc5325a5b568_Out_2;
            Unity_Divide_float(_Add_8d3a946d8f7848c0a6a4ee9e280c511d_Out_2, 2, _Divide_883697060c4b42898d76bc5325a5b568_Out_2);
            float _Saturate_c96331ef3b2642d39a446bce3d43f560_Out_1;
            Unity_Saturate_float(_Divide_883697060c4b42898d76bc5325a5b568_Out_2, _Saturate_c96331ef3b2642d39a446bce3d43f560_Out_1);
            float _Property_a5e2c659762f49e2826023553b233885_Out_0 = _Noise_Power;
            float _Power_fe5fa4a062ff4bac868501be2a7f055c_Out_2;
            Unity_Power_float(_Saturate_c96331ef3b2642d39a446bce3d43f560_Out_1, _Property_a5e2c659762f49e2826023553b233885_Out_0, _Power_fe5fa4a062ff4bac868501be2a7f055c_Out_2);
            float4 _Property_f466dd4679cc4567b14cecb45e839124_Out_0 = _Noise_Remap;
            float _Split_cfe4e3a30c93414694a4d7e49c708985_R_1 = _Property_f466dd4679cc4567b14cecb45e839124_Out_0[0];
            float _Split_cfe4e3a30c93414694a4d7e49c708985_G_2 = _Property_f466dd4679cc4567b14cecb45e839124_Out_0[1];
            float _Split_cfe4e3a30c93414694a4d7e49c708985_B_3 = _Property_f466dd4679cc4567b14cecb45e839124_Out_0[2];
            float _Split_cfe4e3a30c93414694a4d7e49c708985_A_4 = _Property_f466dd4679cc4567b14cecb45e839124_Out_0[3];
            float4 _Combine_c045c4c659354461848cd6c7d61e4be5_RGBA_4;
            float3 _Combine_c045c4c659354461848cd6c7d61e4be5_RGB_5;
            float2 _Combine_c045c4c659354461848cd6c7d61e4be5_RG_6;
            Unity_Combine_float(_Split_cfe4e3a30c93414694a4d7e49c708985_R_1, _Split_cfe4e3a30c93414694a4d7e49c708985_G_2, 0, 0, _Combine_c045c4c659354461848cd6c7d61e4be5_RGBA_4, _Combine_c045c4c659354461848cd6c7d61e4be5_RGB_5, _Combine_c045c4c659354461848cd6c7d61e4be5_RG_6);
            float4 _Combine_6de15c52675e489b874b27eaf16323df_RGBA_4;
            float3 _Combine_6de15c52675e489b874b27eaf16323df_RGB_5;
            float2 _Combine_6de15c52675e489b874b27eaf16323df_RG_6;
            Unity_Combine_float(_Split_cfe4e3a30c93414694a4d7e49c708985_B_3, _Split_cfe4e3a30c93414694a4d7e49c708985_A_4, 0, 0, _Combine_6de15c52675e489b874b27eaf16323df_RGBA_4, _Combine_6de15c52675e489b874b27eaf16323df_RGB_5, _Combine_6de15c52675e489b874b27eaf16323df_RG_6);
            float _Remap_192e92b0649c4e009e825f27b2499763_Out_3;
            Unity_Remap_float(_Power_fe5fa4a062ff4bac868501be2a7f055c_Out_2, _Combine_c045c4c659354461848cd6c7d61e4be5_RG_6, _Combine_6de15c52675e489b874b27eaf16323df_RG_6, _Remap_192e92b0649c4e009e825f27b2499763_Out_3);
            float _Absolute_d5fceabb74744431b85e0fdda3c8cf5c_Out_1;
            Unity_Absolute_float(_Remap_192e92b0649c4e009e825f27b2499763_Out_3, _Absolute_d5fceabb74744431b85e0fdda3c8cf5c_Out_1);
            float _Smoothstep_5b3511aa53f74a73b9b9614372a6af74_Out_3;
            Unity_Smoothstep_float(_Property_ef386ec2d5f4434a8a5f934ff230322f_Out_0, _Property_147f1a2515e04a399eed34de35cf1107_Out_0, _Absolute_d5fceabb74744431b85e0fdda3c8cf5c_Out_1, _Smoothstep_5b3511aa53f74a73b9b9614372a6af74_Out_3);
            float _Property_8fb0c3dbf4a84403a6068e70183a7ea4_Out_0 = _Base_Speed;
            float _Multiply_774f493cd66541e7ba6553802a499b79_Out_2;
            Unity_Multiply_float_float(IN.TimeParameters.x, _Property_8fb0c3dbf4a84403a6068e70183a7ea4_Out_0, _Multiply_774f493cd66541e7ba6553802a499b79_Out_2);
            float2 _TilingAndOffset_969b7b642fd04ed7b2592123a03eca18_Out_3;
            Unity_TilingAndOffset_float((_RotateAboutAxis_6e7d2784bd02405faeb7bacb567d0731_Out_3.xy), float2 (1, 1), (_Multiply_774f493cd66541e7ba6553802a499b79_Out_2.xx), _TilingAndOffset_969b7b642fd04ed7b2592123a03eca18_Out_3);
            float _Property_e3b00c3a5e804e14a1e03e69aac49211_Out_0 = _Base_Scale;
            float _GradientNoise_04262dfbc1b540b1a9d9b997627f189b_Out_2;
            Unity_GradientNoise_float(_TilingAndOffset_969b7b642fd04ed7b2592123a03eca18_Out_3, _Property_e3b00c3a5e804e14a1e03e69aac49211_Out_0, _GradientNoise_04262dfbc1b540b1a9d9b997627f189b_Out_2);
            float _Property_17938a6d7e2f40dd8d0f1b984a9fbb59_Out_0 = _Base_Strength;
            float _Multiply_0854b1bc83aa4170a68f058b8cb96ff7_Out_2;
            Unity_Multiply_float_float(_GradientNoise_04262dfbc1b540b1a9d9b997627f189b_Out_2, _Property_17938a6d7e2f40dd8d0f1b984a9fbb59_Out_0, _Multiply_0854b1bc83aa4170a68f058b8cb96ff7_Out_2);
            float _Add_f82d9f056cbf456f911125a9574d865f_Out_2;
            Unity_Add_float(_Smoothstep_5b3511aa53f74a73b9b9614372a6af74_Out_3, _Multiply_0854b1bc83aa4170a68f058b8cb96ff7_Out_2, _Add_f82d9f056cbf456f911125a9574d865f_Out_2);
            float _Add_df54866b810e4151a1fde09a51f17b65_Out_2;
            Unity_Add_float(1, _Property_17938a6d7e2f40dd8d0f1b984a9fbb59_Out_0, _Add_df54866b810e4151a1fde09a51f17b65_Out_2);
            float _Divide_b2c87465e89040e4940d7d7f42943c3f_Out_2;
            Unity_Divide_float(_Add_f82d9f056cbf456f911125a9574d865f_Out_2, _Add_df54866b810e4151a1fde09a51f17b65_Out_2, _Divide_b2c87465e89040e4940d7d7f42943c3f_Out_2);
            float3 _Multiply_cc4eb1139ae74d4c85067f5171acc955_Out_2;
            Unity_Multiply_float3_float3(IN.ObjectSpaceNormal, (_Divide_b2c87465e89040e4940d7d7f42943c3f_Out_2.xxx), _Multiply_cc4eb1139ae74d4c85067f5171acc955_Out_2);
            float _Property_611696cf692e4bb19aaf7739c57cdd44_Out_0 = _Noise_Height;
            float3 _Multiply_da4791b114e34eceac3bacbb1043285e_Out_2;
            Unity_Multiply_float3_float3(_Multiply_cc4eb1139ae74d4c85067f5171acc955_Out_2, (_Property_611696cf692e4bb19aaf7739c57cdd44_Out_0.xxx), _Multiply_da4791b114e34eceac3bacbb1043285e_Out_2);
            float3 _Add_1af6468ff1e344348b74bd929f252cbf_Out_2;
            Unity_Add_float3(IN.ObjectSpacePosition, _Multiply_da4791b114e34eceac3bacbb1043285e_Out_2, _Add_1af6468ff1e344348b74bd929f252cbf_Out_2);
            float3 _Add_c7842509b95b4858bfbf1f91fea0a4c3_Out_2;
            Unity_Add_float3(_Multiply_5ca41a1165784fbe980a8c3177fad7e1_Out_2, _Add_1af6468ff1e344348b74bd929f252cbf_Out_2, _Add_c7842509b95b4858bfbf1f91fea0a4c3_Out_2);
            description.Position = _Add_c7842509b95b4858bfbf1f91fea0a4c3_Out_2;
            description.Normal = IN.ObjectSpaceNormal;
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
            float Alpha;
            float AlphaClipThreshold;
        };
        
        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            float _SceneDepth_92d0d826f11444f38ddac1aa18b54491_Out_1;
            Unity_SceneDepth_Eye_float(float4(IN.ScreenPosition.xy / IN.ScreenPosition.w, 0, 0), _SceneDepth_92d0d826f11444f38ddac1aa18b54491_Out_1);
            float4 _ScreenPosition_a43e7cd4d3c742149035c252ba0d4ec9_Out_0 = IN.ScreenPosition;
            float _Split_945e233c5d5644b39c8f24743ae9b880_R_1 = _ScreenPosition_a43e7cd4d3c742149035c252ba0d4ec9_Out_0[0];
            float _Split_945e233c5d5644b39c8f24743ae9b880_G_2 = _ScreenPosition_a43e7cd4d3c742149035c252ba0d4ec9_Out_0[1];
            float _Split_945e233c5d5644b39c8f24743ae9b880_B_3 = _ScreenPosition_a43e7cd4d3c742149035c252ba0d4ec9_Out_0[2];
            float _Split_945e233c5d5644b39c8f24743ae9b880_A_4 = _ScreenPosition_a43e7cd4d3c742149035c252ba0d4ec9_Out_0[3];
            float _Subtract_509aa90668e7408bad7076496f9d5759_Out_2;
            Unity_Subtract_float(_Split_945e233c5d5644b39c8f24743ae9b880_A_4, 1, _Subtract_509aa90668e7408bad7076496f9d5759_Out_2);
            float _Subtract_72c15d8c0496460ca2c6aaf585c41381_Out_2;
            Unity_Subtract_float(_SceneDepth_92d0d826f11444f38ddac1aa18b54491_Out_1, _Subtract_509aa90668e7408bad7076496f9d5759_Out_2, _Subtract_72c15d8c0496460ca2c6aaf585c41381_Out_2);
            float _Property_3a30c5a5cbf24fa6913c8ee537ee5f4b_Out_0 = _Fade_Depth;
            float _Divide_8b2505abc71b4c3f8954d6fb229e0865_Out_2;
            Unity_Divide_float(_Subtract_72c15d8c0496460ca2c6aaf585c41381_Out_2, _Property_3a30c5a5cbf24fa6913c8ee537ee5f4b_Out_0, _Divide_8b2505abc71b4c3f8954d6fb229e0865_Out_2);
            float _Saturate_3c60f55f62d842639e72ca2a20ce74df_Out_1;
            Unity_Saturate_float(_Divide_8b2505abc71b4c3f8954d6fb229e0865_Out_2, _Saturate_3c60f55f62d842639e72ca2a20ce74df_Out_1);
            surface.Alpha = _Saturate_3c60f55f62d842639e72ca2a20ce74df_Out_1;
            surface.AlphaClipThreshold = 0.5;
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
            output.WorldSpaceNormal =                           TransformObjectToWorldNormal(input.normalOS);
            output.ObjectSpaceTangent =                         input.tangentOS.xyz;
            output.ObjectSpacePosition =                        input.positionOS;
            output.WorldSpacePosition =                         TransformObjectToWorld(input.positionOS);
            output.TimeParameters =                             _TimeParameters.xyz;
        
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
        
            
        
        
        
        
        
            output.WorldSpacePosition = input.positionWS;
            output.ScreenPosition = ComputeScreenPos(TransformWorldToHClip(input.positionWS), _ProjectionParams.x);
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
    }
    CustomEditorForRenderPipeline "UnityEditor.ShaderGraphUnlitGUI" "UnityEngine.Rendering.Universal.UniversalRenderPipelineAsset"
    CustomEditor "UnityEditor.ShaderGraph.GenericShaderGraphMaterialGUI"
    FallBack "Hidden/Shader Graph/FallbackError"
}