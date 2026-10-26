#version 330
#extension GL_ARB_separate_shader_objects : require

// Game Forge darker-menus pack (copied from Command Forge no-moon): multiply the (already blurred) menu background by Factor.
// Used twice by assets/minecraft/post_effect/blur.json: once to darken (Factor < 1), once as a plain copy back (Factor 1).
uniform sampler2D InSampler;

layout(std140) uniform SamplerInfo {
    vec2 OutSize;
    vec2 InSize;
};

layout(std140) uniform DarkenConfig {
    float Factor;
};

layout(location = 0) in vec2 texCoord;

layout(location = 0) out vec4 fragColor;

void main() {
    vec4 c = texture(InSampler, texCoord);
    fragColor = vec4(c.rgb * Factor, c.a);
}
