shader_type canvas_item;

uniform float alpha = 0.0;

void fragment() {
	vec4 color = texture(TEXTURE, UV);
	vec4 white_color = vec4(1.0, 1.0, 1.0, color.a);
	color.rgb = mix(color.rgb, white_color.rgb, alpha);
	COLOR = color;
}