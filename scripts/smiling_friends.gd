extends Sprite3D

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("Player"):
		$"../AnimationPlayer".play("Cutscene")

func switch_scene():
	get_tree().change_scene_to_file("res://scenes/2d/bart_bash.tscn")
