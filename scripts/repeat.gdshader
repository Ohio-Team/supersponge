shader_type canvas_item;

const float speed = 0.01;

void fragment() {
	vec2 nv = vec2(UV.x + TIME * speed, UV.y);
	COLOR = texture(TEXTURE, nv);
}
