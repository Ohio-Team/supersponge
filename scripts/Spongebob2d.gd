extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -500.0

@onready var anim = $AnimatedSprite2D
@export var state = "idle"
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		anim.play("jump")
		state = "jump"
	if Input.is_action_just_pressed("jump") and not is_on_floor():
		velocity.y = -JUMP_VELOCITY
		anim.play("groundpound")
		state = "groundpound"
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().change_scene_to_file("res://scenes/Main Menu.tscn")
	if velocity.y > 0 and anim.animation != "groundpound" and not is_on_floor():
		anim.play("fall")
		state = "fall"
	if anim.animation == "fall" or anim.animation == "groundpound" and is_on_floor():
		anim.play("land")
		state = "fall"
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("left", "right")
	if direction == -1:
		anim.flip_h = true
	elif direction == 1:
		anim.flip_h = false
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	if velocity.x != 0 and anim.animation != "jump" and anim.animation != "fall" and anim.animation != "groundpound":
		anim.play("run")
		state = "run"
	if velocity.x == 0 and velocity.y == 0:
		anim.play("idle")
		state = "idle"
	move_and_slide()
