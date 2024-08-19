extends Button
class_name Menu_Button

@export var scene : PackedScene

func _ready() -> void:
	pressed.connect(power)
	
func power() -> void:
	get_tree().change_scene_to_packed(scene)
