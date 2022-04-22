using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;

namespace LiquidVolumeFX {

    public class LiquidVolumeDepthPrePassRenderFeature : ScriptableRendererFeature {

        static class ShaderParams {
            public static int RTBackBuffer = Shader.PropertyToID("_VLBackBufferTexture");
            public static int RTFrontBuffer = Shader.PropertyToID("_VLFrontBufferTexture");
            public static int FlaskThickness = Shader.PropertyToID("_FlaskThickness");
            public static int ForcedInvisible = Shader.PropertyToID("_LVForcedInvisible");
            public const string SKW_FP_RENDER_TEXTURE = "LIQUID_VOLUME_FP_RENDER_TEXTURES";
        }

        enum Pass {
            BackBuffer = 0,
            FrontBuffer = 1
        }

        public readonly static List<LiquidVolume> lvBackRenderers = new List<LiquidVolume>();
        public readonly static List<LiquidVolume> lvFrontRenderers = new List<LiquidVolume>();

        public static void AddLiquidToBackRenderers(LiquidVolume lv) {
            if (lv == null || lv.topology != TOPOLOGY.Irregular || lvBackRenderers.Contains(lv)) return;
            lvBackRenderers.Add(lv);
        }

        public static void RemoveLiquidFromBackRenderers(LiquidVolume lv) {
            if (lv == null || !lvBackRenderers.Contains(lv)) return;
            lvBackRenderers.Remove(lv);
        }

        public static void AddLiquidToFrontRenderers(LiquidVolume lv) {
            if (lv == null || lv.topology != TOPOLOGY.Irregular || lvFrontRenderers.Contains(lv)) return;
            lvFrontRenderers.Add(lv);
        }

        public static void RemoveLiquidFromFrontRenderers(LiquidVolume lv) {
            if (lv == null || !lvFrontRenderers.Contains(lv)) return;
            lvFrontRenderers.Remove(lv);
        }

        class DepthPass : ScriptableRenderPass {

            const string profilerTag = "LiquidVolumeDepthPrePass";

            Material mat;
            int targetId;
            int passId;
            List<LiquidVolume> lvRenderers;
            public ScriptableRenderer renderer;
            public bool interleavedRendering;

            public DepthPass(Material mat, Pass pass, RenderPassEvent renderPassEvent) {
                this.renderPassEvent = renderPassEvent;
                this.mat = mat;
                switch (pass) {
                    case Pass.BackBuffer:
                        targetId = ShaderParams.RTBackBuffer;
                        passId = (int)Pass.BackBuffer;
                        lvRenderers = lvBackRenderers;
                        break;
                    case Pass.FrontBuffer:
                        targetId = ShaderParams.RTFrontBuffer;
                        passId = (int)Pass.FrontBuffer;
                        lvRenderers = lvFrontRenderers;
                        break;
                }
            }

            public void Setup(LiquidVolumeDepthPrePassRenderFeature feature, ScriptableRenderer renderer) {
                this.renderer = renderer;
                this.interleavedRendering = feature.interleavedRendering;
            }

            public override void Configure(CommandBuffer cmd, RenderTextureDescriptor cameraTextureDescriptor) {
                cameraTextureDescriptor.colorFormat = LiquidVolume.useFPRenderTextures ? RenderTextureFormat.RHalf : RenderTextureFormat.ARGB32;
                cameraTextureDescriptor.sRGB = false;
                cameraTextureDescriptor.depthBufferBits = 16;
                cmd.GetTemporaryRT(targetId, cameraTextureDescriptor);
                if (!interleavedRendering) {
                    ConfigureTarget(targetId);
                }
            }

            public override void Execute(ScriptableRenderContext context, ref RenderingData renderingData) {

                if (lvRenderers == null) return;

                CommandBuffer cmd = CommandBufferPool.Get(profilerTag);
                cmd.Clear();
                cmd.SetGlobalFloat(ShaderParams.ForcedInvisible, 0);

                Camera cam = renderingData.cameraData.camera;
                if (interleavedRendering) {
                    RenderTargetIdentifier destination = new RenderTargetIdentifier(targetId, 0, CubemapFace.Unknown, -1);
                    lvRenderers.ForEach((LiquidVolume lv) => {
                        if (lv != null && lv.isActiveAndEnabled) {
                            cmd.SetRenderTarget(destination);
                            if (LiquidVolume.useFPRenderTextures) {
                                cmd.ClearRenderTarget(true, true, new Color(cam.farClipPlane, 0, 0, 0), 1f);
                                cmd.EnableShaderKeyword(ShaderParams.SKW_FP_RENDER_TEXTURE);
                            } else {
                                cmd.ClearRenderTarget(true, true, new Color(0.9882353f, 0.4470558f, 0.75f, 0f), 1f);
                                cmd.DisableShaderKeyword(ShaderParams.SKW_FP_RENDER_TEXTURE);
                            }
                            cmd.SetGlobalFloat(ShaderParams.FlaskThickness, 1.0f - lv.flaskThickness);
                            cmd.DrawRenderer(lv.mr, mat, lv.subMeshIndex >= 0 ? lv.subMeshIndex : 0, passId);
                            // draw back face
                            cmd.SetRenderTarget(renderer.cameraColorTarget, renderer.cameraDepthTarget);
                            // draw liquid
                            cmd.DrawRenderer(lv.mr, lv.liqMat, lv.subMeshIndex >= 0 ? lv.subMeshIndex : 0, shaderPass: 1);
                        }
                    });
                    cmd.SetGlobalFloat(ShaderParams.ForcedInvisible, 1);
                } else {
                    // accumulate back face depths into custom rt
                    if (LiquidVolume.useFPRenderTextures) {
                        cmd.ClearRenderTarget(true, true, new Color(cam.farClipPlane, 0, 0, 0), 1f);
                        cmd.EnableShaderKeyword(ShaderParams.SKW_FP_RENDER_TEXTURE);
                    } else {
                        cmd.ClearRenderTarget(true, true, new Color(0.9882353f, 0.4470558f, 0.75f, 0f), 1f);
                        cmd.DisableShaderKeyword(ShaderParams.SKW_FP_RENDER_TEXTURE);
                    }

                    lvRenderers.ForEach((LiquidVolume lv) => {
                        if (lv != null && lv.isActiveAndEnabled) {
                            cmd.SetGlobalFloat(ShaderParams.FlaskThickness, 1.0f - lv.flaskThickness);
                            cmd.DrawRenderer(lv.mr, mat, lv.subMeshIndex >= 0 ? lv.subMeshIndex : 0, passId);
                        }
                    });
                }

                context.ExecuteCommandBuffer(cmd);

                CommandBufferPool.Release(cmd);
            }

            public override void FrameCleanup(CommandBuffer cmd) {
                cmd.ReleaseTemporaryRT(targetId);
            }
        }


        [SerializeField, HideInInspector]
        Shader shader;

        public static bool installed;
        Material mat;
        DepthPass backPass, frontPass;

        [Tooltip("Renders each irregular liquid volume completely before rendering the next one.")]
        public bool interleavedRendering;

        public RenderPassEvent renderPassEvent = RenderPassEvent.BeforeRenderingTransparents;

        private void OnDestroy() { 
            Shader.SetGlobalFloat(ShaderParams.ForcedInvisible, 0);
            CoreUtils.Destroy(mat);
        }

        public override void Create() {
            name = "Liquid Volume Depth PrePass";
            shader = Shader.Find("LiquidVolume/DepthPrePass");
            if (shader == null) {
                return;
            }
            mat = CoreUtils.CreateEngineMaterial(shader);
            backPass = new DepthPass(mat, Pass.BackBuffer, renderPassEvent);
            frontPass = new DepthPass(mat, Pass.FrontBuffer, renderPassEvent);
        }

        // This method is called when setting up the renderer once per-camera.
        public override void AddRenderPasses(ScriptableRenderer renderer, ref RenderingData renderingData) {
            installed = true;
            if (backPass != null && lvBackRenderers.Count > 0) {
                backPass.Setup(this, renderer);
                renderer.EnqueuePass(backPass);
            }
            if (frontPass != null && lvFrontRenderers.Count > 0) {
                frontPass.Setup(this, renderer);
                frontPass.renderer = renderer;
                renderer.EnqueuePass(frontPass);
            }
        }
    }
}
