﻿// Copyright (c) 2018 Indigo Bunting http://opensource.org/licenses/MIT
// Author: Andrey Shlapkov

 Shader "IndigoBunting/SpriteSolidColor"
 {
     Properties
     {
         [PerRendererData] _MainTex ("Sprite Texture", 2D) = "white" {}
         [HideInInspector] _Color ("Tint", Color) = (1,1,1,1)
     }
 
     SubShader
     {
         Tags
         { 
             "Queue"="Transparent" 
             "IgnoreProjector"="True" 
             "RenderType"="Transparent" 
             "PreviewType"="Plane"
             "CanUseSpriteAtlas"="True"
         }
 
         Cull Off
         Lighting Off
         ZWrite Off
         Fog { Mode Off }
         Blend One OneMinusSrcAlpha
 
         Pass
         {
         CGPROGRAM
             #pragma vertex vert
             #pragma fragment frag
             
             struct appdata_t
             {
                 float4 vertex   : POSITION;
                 float4 color    : COLOR;
                 float2 texcoord : TEXCOORD0;
             };
 
             struct v2f
             {
                 float4 vertex   : SV_POSITION;
                 fixed4 color    : COLOR;
                 half2 texcoord  : TEXCOORD0;
             };
             
             fixed4 _Color;
 
             v2f vert(appdata_t IN)
             {
                 v2f OUT;
                 
                 OUT.vertex = UnityObjectToClipPos(IN.vertex);
                 OUT.texcoord = IN.texcoord;
                 OUT.color = IN.color;
 
                 return OUT;
             }
 
             sampler2D _MainTex;
 
             fixed4 frag(v2f IN) : COLOR
             {
                 fixed4 c = tex2D(_MainTex, IN.texcoord);
                 c.rgb = IN.color;
                 c.rgb *= c.a;
             
                 return c;
             }
         ENDCG
         }
     }
 }