#ifndef TERRAIN_TO_MESH_VARIABLES_CGINC
#define TERRAIN_TO_MESH_VARIABLES_CGINC



#if defined(_T2M_LAYER_COUNT_3) 

    #define NEED_PAINT_MAP_2

#elif defined(_T2M_LAYER_COUNT_4)

    #define NEED_PAINT_MAP_2
    #define NEED_PAINT_MAP_3

#elif defined(_T2M_LAYER_COUNT_5)

    #define NEED_SPLAT_MAP_1

    #define NEED_PAINT_MAP_2
    #define NEED_PAINT_MAP_3
    #define NEED_PAINT_MAP_4

#elif defined(_T2M_LAYER_COUNT_6)

    #define NEED_SPLAT_MAP_1

    #define NEED_PAINT_MAP_2
    #define NEED_PAINT_MAP_3
    #define NEED_PAINT_MAP_4
    #define NEED_PAINT_MAP_5

#elif defined(_T2M_LAYER_COUNT_7)

    #define NEED_SPLAT_MAP_1

    #define NEED_PAINT_MAP_2
    #define NEED_PAINT_MAP_3
    #define NEED_PAINT_MAP_4
    #define NEED_PAINT_MAP_5
    #define NEED_PAINT_MAP_6

#elif defined(_T2M_LAYER_COUNT_8)

    #define NEED_SPLAT_MAP_1

    #define NEED_PAINT_MAP_2
    #define NEED_PAINT_MAP_3
    #define NEED_PAINT_MAP_4
    #define NEED_PAINT_MAP_5
    #define NEED_PAINT_MAP_6
    #define NEED_PAINT_MAP_7

#elif defined(_T2M_LAYER_COUNT_9)

    #define NEED_SPLAT_MAP_1
    #define NEED_SPLAT_MAP_2

    #define NEED_PAINT_MAP_2
    #define NEED_PAINT_MAP_3
    #define NEED_PAINT_MAP_4
    #define NEED_PAINT_MAP_5
    #define NEED_PAINT_MAP_6
    #define NEED_PAINT_MAP_7
    #define NEED_PAINT_MAP_8

#elif defined(_T2M_LAYER_COUNT_10)

    #define NEED_SPLAT_MAP_1
    #define NEED_SPLAT_MAP_2

    #define NEED_PAINT_MAP_2
    #define NEED_PAINT_MAP_3
    #define NEED_PAINT_MAP_4
    #define NEED_PAINT_MAP_5
    #define NEED_PAINT_MAP_6
    #define NEED_PAINT_MAP_7
    #define NEED_PAINT_MAP_8
    #define NEED_PAINT_MAP_9

#elif defined(_T2M_LAYER_COUNT_11)

    #define NEED_SPLAT_MAP_1
    #define NEED_SPLAT_MAP_2

    #define NEED_PAINT_MAP_2
    #define NEED_PAINT_MAP_3
    #define NEED_PAINT_MAP_4
    #define NEED_PAINT_MAP_5
    #define NEED_PAINT_MAP_6
    #define NEED_PAINT_MAP_7
    #define NEED_PAINT_MAP_8
    #define NEED_PAINT_MAP_9
    #define NEED_PAINT_MAP_10

#elif defined(_T2M_LAYER_COUNT_12)

    #define NEED_SPLAT_MAP_1
    #define NEED_SPLAT_MAP_2

    #define NEED_PAINT_MAP_2
    #define NEED_PAINT_MAP_3
    #define NEED_PAINT_MAP_4
    #define NEED_PAINT_MAP_5
    #define NEED_PAINT_MAP_6
    #define NEED_PAINT_MAP_7
    #define NEED_PAINT_MAP_8
    #define NEED_PAINT_MAP_9
    #define NEED_PAINT_MAP_10
    #define NEED_PAINT_MAP_11

#elif defined(_T2M_LAYER_COUNT_13)

    #define NEED_SPLAT_MAP_1
    #define NEED_SPLAT_MAP_2
    #define NEED_SPLAT_MAP_3

    #define NEED_PAINT_MAP_2
    #define NEED_PAINT_MAP_3
    #define NEED_PAINT_MAP_4
    #define NEED_PAINT_MAP_5
    #define NEED_PAINT_MAP_6
    #define NEED_PAINT_MAP_7
    #define NEED_PAINT_MAP_8
    #define NEED_PAINT_MAP_9
    #define NEED_PAINT_MAP_10
    #define NEED_PAINT_MAP_11
    #define NEED_PAINT_MAP_12

#elif defined(_T2M_LAYER_COUNT_14)

    #define NEED_SPLAT_MAP_1
    #define NEED_SPLAT_MAP_2
    #define NEED_SPLAT_MAP_3

    #define NEED_PAINT_MAP_2
    #define NEED_PAINT_MAP_3
    #define NEED_PAINT_MAP_4
    #define NEED_PAINT_MAP_5
    #define NEED_PAINT_MAP_6
    #define NEED_PAINT_MAP_7
    #define NEED_PAINT_MAP_8
    #define NEED_PAINT_MAP_9
    #define NEED_PAINT_MAP_10
    #define NEED_PAINT_MAP_11
    #define NEED_PAINT_MAP_12
    #define NEED_PAINT_MAP_13

#elif defined(_T2M_LAYER_COUNT_15)

    #define NEED_SPLAT_MAP_1
    #define NEED_SPLAT_MAP_2
    #define NEED_SPLAT_MAP_3

    #define NEED_PAINT_MAP_2
    #define NEED_PAINT_MAP_3
    #define NEED_PAINT_MAP_4
    #define NEED_PAINT_MAP_5
    #define NEED_PAINT_MAP_6
    #define NEED_PAINT_MAP_7
    #define NEED_PAINT_MAP_8
    #define NEED_PAINT_MAP_9
    #define NEED_PAINT_MAP_10
    #define NEED_PAINT_MAP_11
    #define NEED_PAINT_MAP_12
    #define NEED_PAINT_MAP_13
    #define NEED_PAINT_MAP_14

#elif defined(_T2M_LAYER_COUNT_16)

    #define NEED_SPLAT_MAP_1
    #define NEED_SPLAT_MAP_2
    #define NEED_SPLAT_MAP_3

    #define NEED_PAINT_MAP_2
    #define NEED_PAINT_MAP_3
    #define NEED_PAINT_MAP_4
    #define NEED_PAINT_MAP_5
    #define NEED_PAINT_MAP_6
    #define NEED_PAINT_MAP_7
    #define NEED_PAINT_MAP_8
    #define NEED_PAINT_MAP_9
    #define NEED_PAINT_MAP_10
    #define NEED_PAINT_MAP_11
    #define NEED_PAINT_MAP_12
    #define NEED_PAINT_MAP_13
    #define NEED_PAINT_MAP_14
    #define NEED_PAINT_MAP_15

#endif


#if defined(_T2M_TEXTURE_SAMPLE_TYPE_ARRAY)
    
    #define T2M_DECLARE_LAYER(l)                float4 _T2M_Layer_##l##_MapsUsage; float2 _T2M_Layer_##l##_uvScaleOffset;   float4 _T2M_Layer_##l##_ColorTint; float4 _T2M_Layer_##l##_MetallicOcclusionSmoothness; int _T2M_Layer_##l##_SmoothnessFromDiffuseAlpha; 
    #define T2M_DECALRE_NORMAL(l)               float _T2M_Layer_##l##_NormalScale;
    #define T2M_DECALRE_MASK(l)                 float4 _T2M_Layer_##l##_MaskMapRemapMin; float4 _T2M_Layer_##l##_MaskMapRemapMax;

#else

    #define T2M_DECLARE_LAYER(l)                TEXTURE2D(_T2M_Layer_##l##_Diffuse);   float2 _T2M_Layer_##l##_uvScaleOffset;   float4 _T2M_Layer_##l##_ColorTint; float4 _T2M_Layer_##l##_MetallicOcclusionSmoothness; int _T2M_Layer_##l##_SmoothnessFromDiffuseAlpha;
    #define T2M_DECALRE_NORMAL(l)               TEXTURE2D(_T2M_Layer_##l##_NormalMap); float _T2M_Layer_##l##_NormalScale;
    #define T2M_DECALRE_MASK(l)                 TEXTURE2D(_T2M_Layer_##l##_Mask);      float4 _T2M_Layer_##l##_MaskMapRemapMin; float4 _T2M_Layer_##l##_MaskMapRemapMax;

#endif



//Layer Count/////////////////////////////////////////////////////////////////////////////
int _T2M_Layer_Count;

//Holes///////////////////////////////////////////////////////////////////////////////////
#if defined(_ALPHATEST_ON)
    TEXTURE2D(_T2M_HolesMap); SAMPLER(sampler_T2M_HolesMap);
#endif


#if defined(_T2M_TEXTURE_SAMPLE_TYPE_ARRAY)
     
    TEXTURE2D_ARRAY(_T2M_SplatMaps2DArray);     SAMPLER(sampler_T2M_SplatMaps2DArray);
    TEXTURE2D_ARRAY(_T2M_DiffuseMaps2DArray);   SAMPLER(sampler_T2M_DiffuseMaps2DArray);
    TEXTURE2D_ARRAY(_T2M_NormalMaps2DArray);    SAMPLER(sampler_T2M_NormalMaps2DArray);
    TEXTURE2D_ARRAY(_T2M_MaskMaps2DArray);      SAMPLER(sampler_T2M_MaskMaps2DArray);

	float4 _T2M_Layer_0_MapsUsage;

#else

    //Splatmaps///////////////////////////////////////////////////////////////////////////////
    TEXTURE2D(_T2M_SplatMap_0); SAMPLER(sampler_T2M_SplatMap_0);

    #if defined(NEED_SPLAT_MAP_1)
        TEXTURE2D(_T2M_SplatMap_1);
    #endif

    #if defined(NEED_SPLAT_MAP_2)
        TEXTURE2D(_T2M_SplatMap_2);
    #endif

    #if defined(NEED_SPLAT_MAP_3)
        TEXTURE2D(_T2M_SplatMap_3);
    #endif


    //Layers//////////////////////////////////////////////////////////////////////////////////
    TEXTURE2D(_T2M_Layer_0_Diffuse); SAMPLER(sampler_T2M_Layer_0_Diffuse);

#endif


    float2 _T2M_Layer_0_uvScaleOffset;
    float4 _T2M_Layer_0_ColorTint;
    float4 _T2M_Layer_0_MetallicOcclusionSmoothness;
    int _T2M_Layer_0_SmoothnessFromDiffuseAlpha;

    #if defined(_T2M_LAYER_0_NORMAL)
        T2M_DECALRE_NORMAL(0)
    #endif
    #if defined(_T2M_LAYER_0_MASK) 
        T2M_DECALRE_MASK(0)
    #endif

    T2M_DECLARE_LAYER(1)
    #if defined(_T2M_LAYER_1_NORMAL)
        T2M_DECALRE_NORMAL(1)
    #endif
    #if defined(_T2M_LAYER_1_MASK) 
        T2M_DECALRE_MASK(1)
    #endif

    T2M_DECLARE_LAYER(2)
    #if defined(_T2M_LAYER_2_NORMAL)
        T2M_DECALRE_NORMAL(2)
    #endif
    #if defined(_T2M_LAYER_2_MASK) 
        T2M_DECALRE_MASK(2)
    #endif

    #ifdef NEED_PAINT_MAP_3
        T2M_DECLARE_LAYER(3)
        #if defined(_T2M_LAYER_3_NORMAL)
            T2M_DECALRE_NORMAL(3)
        #endif
        #if defined(_T2M_LAYER_3_MASK) 
            T2M_DECALRE_MASK(3)
        #endif
    #endif


    #if defined(NEED_SPLAT_MAP_1)
        #ifdef NEED_PAINT_MAP_4
            T2M_DECLARE_LAYER(4)
            #if defined(_T2M_LAYER_4_NORMAL)
                T2M_DECALRE_NORMAL(4)
            #endif
            #if defined(_T2M_LAYER_4_MASK) 
                T2M_DECALRE_MASK(4)
            #endif
        #endif

        #ifdef NEED_PAINT_MAP_5
            T2M_DECLARE_LAYER(5)
            #if defined(_T2M_LAYER_5_NORMAL)
                T2M_DECALRE_NORMAL(5)
            #endif
            #if defined(_T2M_LAYER_5_MASK) 
                T2M_DECALRE_MASK(5)
            #endif
        #endif

        #ifdef NEED_PAINT_MAP_6
            T2M_DECLARE_LAYER(6)
            #if defined(_T2M_LAYER_6_NORMAL)
                T2M_DECALRE_NORMAL(6)
            #endif
            #if defined(_T2M_LAYER_6_MASK) 
                T2M_DECALRE_MASK(6)
            #endif
        #endif

        #ifdef NEED_PAINT_MAP_7
            T2M_DECLARE_LAYER(7)
            #if defined(_T2M_LAYER_7_NORMAL)
                T2M_DECALRE_NORMAL(7)
            #endif
            #if defined(_T2M_LAYER_7_MASK) 
                T2M_DECALRE_MASK(7)
            #endif
        #endif        
    #endif

    #if defined(NEED_SPLAT_MAP_2)
        #ifdef NEED_PAINT_MAP_8
            T2M_DECLARE_LAYER(8)
            #if defined(_T2M_LAYER_8_NORMAL)
                T2M_DECALRE_NORMAL(8)
            #endif
            #if defined(_T2M_LAYER_8_MASK) 
                T2M_DECALRE_MASK(8)
            #endif
        #endif

        #ifdef NEED_PAINT_MAP_9
            T2M_DECLARE_LAYER(9)
            #if defined(_T2M_LAYER_9_NORMAL)
                T2M_DECALRE_NORMAL(9)
            #endif
            #if defined(_T2M_LAYER_9_MASK) 
                T2M_DECALRE_MASK(9)
            #endif
        #endif

        #ifdef NEED_PAINT_MAP_10
            T2M_DECLARE_LAYER(10)
            #if defined(_T2M_LAYER_10_NORMAL)
                T2M_DECALRE_NORMAL(10)
            #endif
            #if defined(_T2M_LAYER_10_MASK) 
                T2M_DECALRE_MASK(10)
            #endif
        #endif

        #ifdef NEED_PAINT_MAP_11
            T2M_DECLARE_LAYER(11)
            #if defined(_T2M_LAYER_11_NORMAL)
                T2M_DECALRE_NORMAL(11)
            #endif
            #if defined(_T2M_LAYER_11_MASK) 
                T2M_DECALRE_MASK(11)
            #endif
        #endif
    #endif

    #if defined(NEED_SPLAT_MAP_3)
        #ifdef NEED_PAINT_MAP_12
            T2M_DECLARE_LAYER(12)
            #if defined(_T2M_LAYER_12_NORMAL)
                T2M_DECALRE_NORMAL(12)
            #endif
            #if defined(_T2M_LAYER_12_MASK) 
                T2M_DECALRE_MASK(12)
            #endif
        #endif

        #ifdef NEED_PAINT_MAP_13
            T2M_DECLARE_LAYER(13)
            #if defined(_T2M_LAYER_13_NORMAL)
                T2M_DECALRE_NORMAL(13)
            #endif
            #if defined(_T2M_LAYER_13_MASK) 
                T2M_DECALRE_MASK(13)
            #endif
        #endif

        #ifdef NEED_PAINT_MAP_14
            T2M_DECLARE_LAYER(14)
            #if defined(_T2M_LAYER_14_NORMAL)
                T2M_DECALRE_NORMAL(14)
            #endif
            #if defined(_T2M_LAYER_14_MASK) 
                T2M_DECALRE_MASK(14)
            #endif
        #endif

        #ifdef NEED_PAINT_MAP_15
            T2M_DECLARE_LAYER(15)
            #if defined(_T2M_LAYER_15_NORMAL)
                T2M_DECALRE_NORMAL(15)
            #endif
            #if defined(_T2M_LAYER_15_MASK) 
                T2M_DECALRE_MASK(15)
            #endif
        #endif
    #endif

#endif
 