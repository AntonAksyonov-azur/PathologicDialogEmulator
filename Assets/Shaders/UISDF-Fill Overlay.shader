Shader "UI/SDF-Fill Overlay" {
	Properties {
		[PerRendererData] _MainTex ("Sprite Texture", 2D) = "white" {}
		_Color ("Color", Vector) = (1,1,1,1)
		_Gradient ("Gradient", Float) = 1
		_FillGradient ("Fill Gradient", Float) = 1
		_StencilComp ("Stencil Comparison", Float) = 8
		_Stencil ("Stencil ID", Float) = 0
		_StencilOp ("Stencil Operation", Float) = 0
		_StencilWriteMask ("Stencil Write Mask", Float) = 255
		_StencilReadMask ("Stencil Read Mask", Float) = 255
		_ColorMask ("Color Mask", Float) = 15
		[Toggle(UNITY_UI_ALPHACLIP)] _UseUIAlphaClip ("Use Alpha Clip", Float) = 0
	}
	SubShader {
		Tags { "CanUseSpriteAtlas" = "true" "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
		Pass {
			Name "Default"
			Tags { "CanUseSpriteAtlas" = "true" "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
			Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
			ColorMask 0 -1
			ZTest Always
			ZWrite Off
			Cull Off
			Stencil {
				ReadMask 0
				WriteMask 0
				Comp Disabled
				Pass Keep
				Fail Keep
				ZFail Keep
			}
			GpuProgramID 18902
			Program "vp" {
				SubProgram "d3d11 " {
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_0_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_COLOR0;
					in  vec2 in_TEXCOORD0;
					out vec4 vs_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    u_xlat0.xyz = max(in_COLOR0.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat0.xyz = log2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    vs_COLOR0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
					    vs_COLOR0.w = in_COLOR0.w;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD1 = in_POSITION0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "UNITY_UI_ALPHACLIP" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_0_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_COLOR0;
					in  vec2 in_TEXCOORD0;
					out vec4 vs_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    u_xlat0.xyz = max(in_COLOR0.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat0.xyz = log2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    vs_COLOR0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
					    vs_COLOR0.w = in_COLOR0.w;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD1 = in_POSITION0;
					    return;
					}"
				}
			}
			Program "fp" {
				SubProgram "d3d11 " {
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _Color;
						vec4 _TextureSampleAdd;
						vec4 _ClipRect;
						vec4 _MainTex_TexelSize;
						float _Gradient;
						float _FillGradient;
					};
					uniform  sampler2D _MainTex;
					in  vec4 vs_COLOR0;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					bvec2 u_xlatb1;
					vec2 u_xlat2;
					bvec2 u_xlatb2;
					vec2 u_xlat4;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xy = dFdx(vs_TEXCOORD0.xy);
					    u_xlat4.xy = dFdy(vs_TEXCOORD0.xy);
					    u_xlat0.xy = abs(u_xlat4.xy) + abs(u_xlat0.xy);
					    u_xlat0.xy = u_xlat0.xy * _MainTex_TexelSize.zw;
					    u_xlat0.xy = u_xlat0.xy / vec2(_Gradient);
					    u_xlat0.x = u_xlat0.y + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * 0.5;
					    u_xlat0.x = min(u_xlat0.x, 1.0);
					    u_xlat1 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat2.xy = u_xlat1.xy + vec2(-0.5, -1.0);
					    u_xlat6 = (-u_xlat1.y) + vs_COLOR0.y;
					    u_xlat0.w = u_xlat6 / _FillGradient;
					    u_xlat0.x = u_xlat2.x / u_xlat0.x;
					    u_xlat2.x = u_xlat2.y + vs_COLOR0.x;
					    u_xlat0.y = u_xlat2.x / _FillGradient;
					    u_xlat0.xyw = u_xlat0.xyw + vec3(0.5, 1.0, 1.0);
					    u_xlat0.xyw = clamp(u_xlat0.xyw, 0.0, 1.0);
					    u_xlat1 = _TextureSampleAdd + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat1 = u_xlat1 * _Color;
					    u_xlat4.x = u_xlat1.w * vs_COLOR0.w;
					    SV_Target0.xyz = u_xlat1.xyz;
					    u_xlat0.x = u_xlat0.x * u_xlat4.x;
					    u_xlat0.x = u_xlat0.y * u_xlat0.x;
					    u_xlat0.x = u_xlat0.w * u_xlat0.x;
					    u_xlatb2.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
					    u_xlat2.x = u_xlatb2.x ? float(1.0) : 0.0;
					    u_xlat2.y = u_xlatb2.y ? float(1.0) : 0.0;
					;
					    u_xlatb1.xy = greaterThanEqual(_ClipRect.zwzz, vs_TEXCOORD1.xyxx).xy;
					    u_xlat1.x = u_xlatb1.x ? float(1.0) : 0.0;
					    u_xlat1.y = u_xlatb1.y ? float(1.0) : 0.0;
					;
					    u_xlat2.xy = u_xlat2.xy * u_xlat1.xy;
					    u_xlat2.x = u_xlat2.y * u_xlat2.x;
					    SV_Target0.w = u_xlat2.x * u_xlat0.x;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "UNITY_UI_ALPHACLIP" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _Color;
						vec4 _TextureSampleAdd;
						vec4 _ClipRect;
						vec4 _MainTex_TexelSize;
						float _Gradient;
						float _FillGradient;
					};
					uniform  sampler2D _MainTex;
					in  vec4 vs_COLOR0;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					bvec2 u_xlatb1;
					vec2 u_xlat2;
					bvec2 u_xlatb2;
					vec2 u_xlat4;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xy = dFdx(vs_TEXCOORD0.xy);
					    u_xlat4.xy = dFdy(vs_TEXCOORD0.xy);
					    u_xlat0.xy = abs(u_xlat4.xy) + abs(u_xlat0.xy);
					    u_xlat0.xy = u_xlat0.xy * _MainTex_TexelSize.zw;
					    u_xlat0.xy = u_xlat0.xy / vec2(_Gradient);
					    u_xlat0.x = u_xlat0.y + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * 0.5;
					    u_xlat0.x = min(u_xlat0.x, 1.0);
					    u_xlat1 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat2.xy = u_xlat1.xy + vec2(-0.5, -1.0);
					    u_xlat6 = (-u_xlat1.y) + vs_COLOR0.y;
					    u_xlat0.w = u_xlat6 / _FillGradient;
					    u_xlat0.x = u_xlat2.x / u_xlat0.x;
					    u_xlat2.x = u_xlat2.y + vs_COLOR0.x;
					    u_xlat0.y = u_xlat2.x / _FillGradient;
					    u_xlat0.xyw = u_xlat0.xyw + vec3(0.5, 1.0, 1.0);
					    u_xlat0.xyw = clamp(u_xlat0.xyw, 0.0, 1.0);
					    u_xlat1 = _TextureSampleAdd + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat1 = u_xlat1 * _Color;
					    u_xlat4.x = u_xlat1.w * vs_COLOR0.w;
					    SV_Target0.xyz = u_xlat1.xyz;
					    u_xlat0.x = u_xlat0.x * u_xlat4.x;
					    u_xlat0.x = u_xlat0.y * u_xlat0.x;
					    u_xlat0.x = u_xlat0.w * u_xlat0.x;
					    u_xlatb2.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
					    u_xlat2.x = u_xlatb2.x ? float(1.0) : 0.0;
					    u_xlat2.y = u_xlatb2.y ? float(1.0) : 0.0;
					;
					    u_xlatb1.xy = greaterThanEqual(_ClipRect.zwzz, vs_TEXCOORD1.xyxx).xy;
					    u_xlat1.x = u_xlatb1.x ? float(1.0) : 0.0;
					    u_xlat1.y = u_xlatb1.y ? float(1.0) : 0.0;
					;
					    u_xlat2.xy = u_xlat2.xy * u_xlat1.xy;
					    u_xlat2.x = u_xlat2.y * u_xlat2.x;
					    u_xlat4.x = u_xlat0.x * u_xlat2.x + -0.00100000005;
					    u_xlat0.x = u_xlat2.x * u_xlat0.x;
					    SV_Target0.w = u_xlat0.x;
					    u_xlatb0 = u_xlat4.x<0.0;
					    if(((int(u_xlatb0) * int(0xffffffffu)))!=0){discard;}
					    return;
					}"
				}
			}
		}
	}
}