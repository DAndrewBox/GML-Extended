// Color Overlay Fragment Shader
varying vec4	v_vColour;
varying vec2	v_vTexcoord;
uniform vec3	u_color;
uniform float	u_blend;

void main() {
    vec4 texColor = texture2D(gm_BaseTexture, v_vTexcoord);
	vec4 mixColor = mix(v_vColour.rgb, u_color, u_blend);
    gl_FragColor = vec4(mixColor.r, mixColor.g, mixColor.b, texColor.a);
}