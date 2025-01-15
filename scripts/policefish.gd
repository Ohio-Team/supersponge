extends Area2D

@export var target:Node2D
@onready var health:int = randi_range(1, 5)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var direction := (target.position - position).normalized() * 2
	position += direction

func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if health != 0:
			health -= 1
			BMOD.play_sfx(preload("res://assets/sfx/cjhurt.tres"))
		else:
			Singleton.do_explosion(position)
			get_parent().police += 1
			queue_free()
