extends CharacterBody3D


@export var SPEED = 12.0
@export var level:Node3D

var mouse_sensitivity := 0.001
var twist_input := 0.0
var pitch_input := 0.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(delta):
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle jump.
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = 10
	
	var input_dir = Input.get_vector("left","right","front","back")
	var direction = ($TwistPivot.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if OS.get_name() == "Android":
		direction = ($TwistPivot.basis * Vector3(Ui.joystick.posVector.x, 0, Ui.joystick.posVector.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
	if Input.is_action_just_pressed("ui_cancel"):
		if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	$TwistPivot.rotate_y(twist_input)
	$TwistPivot/PitchPivot.rotate_x(pitch_input)
	$TwistPivot/PitchPivot.rotation.x = clamp(
		$TwistPivot/PitchPivot.rotation.x,
		-0.7,
		0.7
	)
	twist_input = 0.0
	pitch_input = 0.0
	# level.update_ui_distance(distance)
func _unhandled_input(event: InputEvent):
	if event is InputEventMouseMotion:
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			twist_input = - event.relative.x * mouse_sensitivity
			pitch_input = - event.relative.y * mouse_sensitivity
