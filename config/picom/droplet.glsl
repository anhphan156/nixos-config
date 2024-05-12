#version 330

in vec2 texcoord;
uniform sampler2D tex;
uniform float time;

vec4 default_post_processing(vec4 c);

float gradient_noise(vec3 p);
float fbm(vec3 p, float octave, float persistence, float lacunartity);
vec3 hash33(vec3 p );
float hash21(vec2 p);
float smin( float a, float b, float k );

vec4 window_shader() {

    // config
    float water_level = .33;
    float circle_radius = .3;


    vec4 c = texelFetch(tex, ivec2(texcoord), 0);
    c = default_post_processing(c);

    vec2 texSize = textureSize(tex, 0);
    vec2 uv = texcoord / texSize;
    uv.x *= texSize.x/texSize.y;
    uv.y = 1.0 - uv.y;

    float t = time * 0.001;

    float d = uv.y - fbm(vec3(uv.x, 0.0, t * .5), 2.0, 0.5, 3.0) - water_level;
    
    vec2 duv = fract(uv * vec2(3.35,1.0)) / vec2(3.35, 1.0);

    vec2 did = floor(uv * vec2(3.35,1.0));
    duv.y = fract(duv.y + t * .5);
    duv = fract(duv);
    duv = min(duv, 1.0 - duv) * 2.0;
    
    float dd = length(duv - vec2(.15, hash21(did) + .5));
        
    vec3 col = vec3(smoothstep(0.05, 0.051, smin(d, dd, .02)));
    
    col = 1.0 - col;
    vec4 cc = mix(
        mix(c, vec4(.2,.3,.8,1.), vec4(col, 1.0)), 
        c, 
        smoothstep(circle_radius, circle_radius + .001, length(uv - vec2(.887, .5)))
    );
        
    return cc;
}

float smin( float a, float b, float k )
{
    k *= 1.0;
    float r = exp2(-a/k) + exp2(-b/k);
    return -k*log2(r);
}

float fbm(vec3 p, float octave, float persistence, float lacunartity){
    float amp = .5;
    float freq = 0.3;
    float total = 0.0;
    float normalization = 0.0;

    for(int i = 0; i < 99; i += 1){
        total += gradient_noise(p * freq) * amp;

        normalization += amp;

        amp *= persistence; 
        freq *= lacunartity;

        if(i >= int(octave)) break;
    }

    return total / normalization;
}
vec3 hash33(vec3 p ){
    p = vec3( dot(p,vec3(127.1,311.7, 74.7)),
			  dot(p,vec3(269.5,183.3,246.1)),
			  dot(p,vec3(113.5,271.9,124.6)));

	return -1.0 + 2.0*fract(sin(p)*43758.5453123);
}

float hash21(vec2 p){
    p = 50. * fract(p * .3183099 + vec2(.71, .113));
    return -1. + 2.* fract(p.x * p.y * (p.x + p.y));
}

float gradient_noise(vec3 p){
    vec3 i = floor( p );
    vec3 f = fract( p );

    vec3 u = f*f*(3.0-2.0*f);

    return mix( mix( mix( dot( hash33( i + vec3(0.0,0.0,0.0) ), f - vec3(0.0,0.0,0.0) ),
                          dot( hash33( i + vec3(1.0,0.0,0.0) ), f - vec3(1.0,0.0,0.0) ), u.x),
                     mix( dot( hash33( i + vec3(0.0,1.0,0.0) ), f - vec3(0.0,1.0,0.0) ), 
                          dot( hash33( i + vec3(1.0,1.0,0.0) ), f - vec3(1.0,1.0,0.0) ), u.x), u.y), 
                     mix( mix( dot( hash33( i + vec3(0.0,0.0,1.0) ), f - vec3(0.0,0.0,1.0) ),                         
                               dot( hash33( i + vec3(1.0,0.0,1.0) ), f - vec3(1.0,0.0,1.0) ), u.x),                   
                          mix( dot( hash33( i + vec3(0.0,1.0,1.0) ), f - vec3(0.0,1.0,1.0) ),                         
                               dot( hash33( i + vec3(1.0,1.0,1.0) ), f - vec3(1.0,1.0,1.0) ), u.x), u.y), u.z );
}
