extends CharacterBody2D


const SPEED = 250.0
const JUMP_VELOCITY = -430.0

@onready var anim = $AnimatedSprite2D
@export var state = "idle"
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	pass

func inputs():
	if state == "hurt":
		BMOD.play_sfx(preload("res://assets/sfx/ouch.tres"))
		velocity.x = SPEED * 4
		velocity.y = -450
		anim.play("hurt")
		if anim.animation_finished:
			state = "idle"
	if Input.is_action_just_pressed("attack") and is_on_floor():
		state = "attack"
		anim.play("attack")
		await $AnimatedSprite2D.animation_finished
		state = "idle"
		anim.play("idle")
	# Handle jump.
	if Input.is_action_just_pressed("jump") and state != "hurt" and state != "dying" and is_on_floor():
		velocity.y = JUMP_VELOCITY
		anim.play("jump")
		state = "jump"
	if Input.is_action_just_pressed("jump") and state != "hurt" and state != "dying" and not is_on_floor():
		velocity.y = -JUMP_VELOCITY
		anim.play("groundpound")
		state = "groundpound"
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().change_scene_to_file("res://scenes/Main Menu.tscn")
	if velocity.y > 0 and anim.animation != "groundpound" and anim.animation != "hurt"  and anim.animation != "attack" and anim.animation != "dying" and  not is_on_floor():
		anim.play("fall")
		state = "fall"
	if anim.animation == "fall" or anim.animation == "groundpound" and anim.animation != "attack" and anim.animation != "dying" and is_on_floor():
		anim.play("land")
		state = "land"

func _physics_process(delta):
	# Add the gravity.
	inputs()
	if Singleton.health <= 0:
		print("game over 💔")
		Singleton.lifes -= 1
		Singleton.health = 3
		state = "dying"
		anim.play("dying")
		await anim.animation_finished
		if get_tree():
			get_tree().reload_current_scene()
	if not is_on_floor():
		velocity.y += gravity * delta
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("left", "right")
	if direction < 0:
		anim.flip_h = true
	elif direction == 1:
		anim.flip_h = false
	if direction and anim.animation != "hurt" and anim.animation != "attack" and anim.animation != "dying":
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	if velocity.x != 0 and anim.animation != "jump" and anim.animation != "fall" and anim.animation != "groundpound" and anim.animation != "hurt" and anim.animation != "attack" and anim.animation != "dying":
		anim.play("run")
	if velocity.x == 0 and velocity.y == 0 and anim.animation != "attack" and anim.animation != "dying":
		anim.play("idle")
		state = "idle"
	move_and_slide()
