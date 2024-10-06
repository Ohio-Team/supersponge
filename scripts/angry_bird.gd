extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var clicked:bool = false

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if clicked:
		velocity += get_gravity() * delta
	
	move_and_slide()
func _on_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		clicked = true
		BMOD.play_sfx(preload("res://assets/sfx/yeehaw.tres"))
		velocity.y = -300
		velocity.x = 700
