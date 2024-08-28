extends Area3D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	rotate_y(delta * 2)


func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("Player"):
		Singleton.fuel = 100
		BMOD.play_sfx_3d(preload("res://assets/sfx/fuel.tres"),position)
		queue_free()
