extends VehicleBody3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	steering = move_toward(steering, Ui.joystick.x * 0.8, delta * 2.5)
	engine_force = Input.get_axis("back","front") * 200
	if position.y < -1 or Singleton.fuel < 0:
		get_tree().reload_current_scene()
		
	if (Ui.joystick.y > 0.1 or Ui.joystick.y < 0):
		Singleton.fuel -= delta * 10
