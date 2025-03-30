shader_type canvas_item;

uniform vec2 motion = vec2(0.0); uniform float scale = 1.0; uniform vec2 offset = vec2(0.0);

void vertex(){  UV = (VERTEX + offset + TIME * motion) * TEXTURE_PIXEL_SIZE * (1.0/scale); }

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
