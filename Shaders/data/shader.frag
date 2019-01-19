
#ifdef GL_ES
precision mediump float;
#endif

#define PROCESSING_COLOR_SHADER
#define PI 3.141592653579

uniform vec2 u_resolution;
uniform float u_time;

mat2 rotate2d(float _angle){
    return mat2(cos(_angle),-sin(_angle),
                sin(_angle),cos(_angle));
}

float circle(in vec2 _st, in float _radius){
    vec2 l = _st-vec2(0.5);
    return 1.0-smoothstep(_radius-(_radius*0.01),
                         _radius+(_radius*0.01),
                         dot(l,l)*4.0);
}

void main() {
    vec2 st = gl_FragCoord.st/u_resolution;
    vec3 color = vec3(0.0);

    st -= vec2(0.5);

    st = rotate2d( sin(u_time) * PI * 1.0 ) * st;

    st += vec2(0.5);

    st *= 3.0;
    st = fract(st);

    color = vec3(st, 0.0);
    color += vec3(circle(st, 0.25));

    gl_FragColor = vec4(color, 1.0);
}
