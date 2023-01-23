// Color Overlay Fragment Shader
varying vec2	v_vTexcoord;
varying vec3	v_vColour;
uniform vec3	u_color;
uniform float	u_blend;

void main() {
    vec4 texColor = texture2D(gm_BaseTexture, v_vTexcoord);
	vec4 mixColor = vec4(mix(texColor.rgb, u_color.rgb, u_blend), texColor.a);
	
    gl_FragColor = vec4(mixColor.rgb, texColor.a);
}
