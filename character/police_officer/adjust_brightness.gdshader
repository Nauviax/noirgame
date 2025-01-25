shader_type canvas_item;

uniform float brightness : hint_range(-1.0, 1.0) = 0.0;

void fragment() {
	// TODO Maybe animate?
	vec4 color = texture(TEXTURE, UV);
    color.rgb += brightness;
    COLOR = color;
}
