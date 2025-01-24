extends CharacterBody3D


@export var SPEED = 12.0
@export var level:Node3D

var mouse_sensitivity := 0.001
var twist_input := 0.0
var state : String = "Idle"
var pitch_input := 0.0
@onready var doomthing := %Bobby

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
	
	if Singleton.health <= 0:
		Singleton.health = 3
		Singleton.deaths += 1
		get_tree().reload_current_scene()
	
	var input_dir = Input.get_vector("left","right","front","back")
	var direction = ($TwistPivot.basis * Vector3(Ui.joystick.posVector.x, 0, Ui.joystick.posVector.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	move_and_slide()
	if Input.is_action_just_pressed("pause"):
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
	if Input.is_action_just_pressed("attack"):
		BMOD.play_sfx(preload("res://assets/sfx/shoot.tres"))
		var bullet = preload("res://scenes/3d/bullet3d.tscn")
		var newbullet = bullet.instantiate()
		var forward_direction = -$TwistPivot.transform.basis.z.normalized()
		newbullet.direction = forward_direction
		newbullet.position = $TwistPivot/PitchPivot/Camera3D.global_position
		if get_tree().current_scene:
			get_tree().current_scene.add_child(newbullet)
	twist_input = 0.0
	pitch_input = 0.0
	# level.update_ui_distance(distance)
	if %Bobby.animation != "Heal" and %Bobby.animation != "Hurt":
		%Bobby.play("Idle")
func _unhandled_input(event):
	if event is InputEventMouseMotion:
			twist_input = -event.relative.x * mouse_sensitivity
			pitch_input = -event.relative.y * mouse_sensitivity
	if event is InputEventJoypadMotion:
		twist_input = - Input.get_joy_axis(0,JOY_AXIS_RIGHT_X) * 0.1
		pitch_input = - Input.get_joy_axis(0,JOY_AXIS_RIGHT_Y) * 0.1
