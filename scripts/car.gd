extends VehicleBody3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	steering = move_toward(steering, Input.get_axis("right","left") * 0.8, delta * 2.5)
	engine_force = Input.get_axis("back","front") * 200
	if position.y < -1:
		get_tree().reload_current_scene()
