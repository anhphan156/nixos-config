#version 330

in vec2 texcoord;             // texture coordinate of the fragment
uniform sampler2D tex;        // texture of the window
uniform float time;           // Time in miliseconds.

// Default window post-processing:
// 1) invert color
// 2) opacity / transparency
// 3) max-brightness clamping
// 4) rounded corners
vec4 default_post_processing(vec4 c);

float smin( float a, float b, float k )
{
    k *= 1.0;
    float r = exp2(-a/k) + exp2(-b/k);
    return -k*log2(r);
}

vec4 window_shader() {
    vec4 c = texelFetch(tex, ivec2(texcoord), 0);
    c = default_post_processing(c);

    vec2 texSize = textureSize(tex, 0);
    vec2 uv = texcoord / texSize;
    uv.x *= texSize.x/texSize.y;
    uv.y = fract(uv.y - time * -.0001) - .2;

    vec2 cuv = uv;
    //cuv = fract(uv * 3.) - .5;

    float anim = time * .001;
    float d = length(cuv - vec2(.2, sin(anim) * .05));
    d = smin(d, length(cuv - vec2(.2 - sin(anim) * .1, 0.0)), .02);
    d = smin(d, length(cuv - vec2(.25 - sin(anim) * .15, .2 + cos(anim) * .1)), .02);
    d = smin(d, length(cuv - vec2(.28 - sin(anim) * .05, .225 + cos(anim) * .012)), .02);
    float r = .04;
    float m = smoothstep(r, r+.001, d);

    c.xyz = mix(vec3(.5, .3, .9), c.xyz, m);

    return c;
}
