extends VehicleBody3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	steering = move_toward(steering, Input.get_axis("right","left") * 0.8, delta * 2.5)
	engine_force = Input.get_axis("back","front") * 200
	if position.y < -1 or Singleton.fuel < 0:
		get_tree().reload_current_scene()
		
	if Input.is_action_pressed("front") or Input.is_action_pressed("back"):
		Input.start_joy_vibration(0,0.3,0.3)
		Singleton.fuel -= delta * 10
	else:
		if Input.is_action_just_released("front") or Input.is_action_pressed("back"):
			Input.stop_joy_vibration(0)
