extends CharacterBody2D


var hasclip:bool = false
var target:Vector2


func _ready() -> void:
	set_process_unhandled_input(true)

func _physics_process(delta: float) -> void:
	pass
	
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		BMOD.play_sfx(preload("res://assets/sfx/walk.tres"))
		move_and_collide(get_local_mouse_position())
