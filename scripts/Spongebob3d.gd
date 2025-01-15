@icon("res://assets/icons/sbicon.svg")
class_name spunchbob extends CharacterBody3D

@export var SPEED = 20.0
@onready var animation_tree = $AnimationTree
@onready var camera : ThirdPersonCamera = $ThirdPersonCamera
@export var JUMP_VELOCITY = 9.8
var state = "run"

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
func _ready():
	$ThirdPersonCamera.mouse_x_sensitiveness = Singleton.mouse_sensitivity
	$ThirdPersonCamera.mouse_y_sensitiveness = Singleton.mouse_sensitivity
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(delta):
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		state = "jump"
		
	if Input.is_action_just_pressed("groundpound") and not is_on_floor():
		animation_tree["parameters/state/transition_request"] = "butt"
		state = "groundpound"
		velocity.y = -JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("left", "right", "front", "back")
	var direction = ((camera._camera_rotation_pivot.basis * Vector3(Ui.joystick.posVector.x, 0, Ui.joystick.posVector.y))).normalized()
	if direction:
		if is_on_floor():
			animation_tree["parameters/state/transition_request"] = "walking"
			$sponebob.rotation.y = direction.x - direction.z
			state = "walking"
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	elif direction == Vector3(0,0,0) and velocity.y == 0 and animation_tree["parameters/state/current_state"] != "weed":
		velocity.x = move_toward(velocity.x, 0, SPEED)
		animation_tree["parameters/state/transition_request"] = "idle"
		state = "idle"
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
