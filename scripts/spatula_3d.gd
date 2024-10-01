extends Area3D

func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("Player"):
		BMOD.play_sfx_3d(preload("res://assets/sfx/collect.tres"),position)
		Singleton.spatulas += 1
		queue_free()
