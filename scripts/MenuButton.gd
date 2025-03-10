extends Button
class_name Menu_Button

@export var scene : PackedScene

func _ready() -> void:
	pressed.connect(power)
	
	
func power() -> void:
	BMOD.play_sfx(preload("res://assets/sfx/funnybuttons/buttons.tres"))
	get_tree().change_scene_to_packed(scene)
	
	
func _on_mouse_entered() -> void:
	BMOD.play_sfx(preload("res://assets/sfx/menumove.tres"))


func _on_focus_entered() -> void:
	BMOD.play_sfx(preload("res://assets/sfx/menumove.tres"))
