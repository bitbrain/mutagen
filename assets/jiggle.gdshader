
shader_type canvas_item;

uniform vec4 text_color : source_color = vec4(1.0, 1.0, 1.0, 1.0);

uniform float warp_frequency : hint_range(0.0, 50.0) = 10.0;
uniform float warp_amplitude : hint_range(0.0, 50.0) = 5.0;
uniform float warp_speed : hint_range(0.0, 10.0) = 2.0;

void vertex() {
	VERTEX.y += sin(UV.x * warp_frequency + TIME * warp_speed) * warp_amplitude;
}

void fragment() {
	float original_alpha = texture(TEXTURE, UV).a;
	
	COLOR = vec4(text_color.rgb, original_alpha * text_color.a);
}