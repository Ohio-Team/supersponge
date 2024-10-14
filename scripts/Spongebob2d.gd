@icon("res://assets/icons/sbicon.svg")
extends CharacterBody2D

const SPEED = 250.0
const JUMP_VELOCITY = -430.0

@onready var camera = $Camera2D
@onready var anim = $AnimatedSprite2D
@export var state = "idle"
@export var invincible:bool = false

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	pass

func inputs(direction):
	if Singleton.acceptinput:
		if state == "hurt":
			BMOD.play_sfx(preload("res://assets/sfx/ouch.tres"))
			$Invincibility.start()
			velocity.x = SPEED * 4
			velocity.y = -450
			anim.play("hurt")
			invincible = true
			if anim.animation_finished:
				state = "idle"
		if Input.is_action_just_pressed("attack") and state != "dying" and state != "hurt":
			if Singleton.hasgun == false:
				state = "attack"
				anim.play("attack")
				BMOD.play_sfx(preload("res://assets/sfx/net.tres"))
				await $AnimatedSprite2D.animation_finished
				state = "idle"
				anim.play("idle")
			else:
				generate_bullet()
	# Handle jump.
		if Input.is_action_just_pressed("jump"):
			if state != "hurt" and state != "dying":
				if is_on_floor() or !$Coyote.is_stopped():
					velocity.y = JUMP_VELOCITY
					BMOD.play_sfx(preload("res://assets/sfx/jump.tres"))
					anim.play("jump")
					state = "jump"
		if Input.is_action_just_pressed("jump") and state != "dying" and not is_on_floor() and $Coyote.is_stopped():
				velocity.y = -JUMP_VELOCITY
				anim.play("groundpound")
				state = "groundpound"
		if Input.is_action_just_released("jump"):
			if velocity.y < 0 and state != "groundpound" and !$Coyote.is_stopped():
				velocity.y = 0
		if velocity.y > 0 and anim.animation != "groundpound" and anim.animation != "hurt"  and anim.animation != "attack" and state != "dying" and not is_on_floor():
			anim.play("fall")
			state = "fall"
		if anim.animation == "fall" or anim.animation == "groundpound" and anim.animation != "attack" and state != "dying" and is_on_floor():
			anim.play("land")
			state = "land"

func _physics_process(delta):
	# Add the gravity.
	if Singleton.health <= 0:
		print("game over 💔")
		BMOD.play_sfx(preload("res://assets/sfx/death.tres"))
		Singleton.lifes -= 1
		Singleton.health = 3
		Singleton.spatulas -= 10
		state = "dying"
		anim.play("dying")
		await anim.animation_finished
		if get_tree():
			get_tree().reload_current_scene()
	if not is_on_floor():
		velocity.y += gravity * delta
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Ui.joystick.posVector.x
	inputs(direction)
	if direction < 0:
		anim.flip_h = true
	elif direction > 0:
		anim.flip_h = false
	if direction and anim.animation != "hurt" and anim.animation != "attack" and state != "dying":
		velocity.x = lerp(velocity.x,direction * SPEED,delta * 8)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED / 2)
	if velocity.x != 0 and anim.animation != "jump" and anim.animation != "fall" and anim.animation != "groundpound" and anim.animation != "hurt" and anim.animation != "attack" and state != "dying":
		anim.play("run")
		if (!BMOD.sfx_playing.has(preload("res://assets/sfx/walk.tres")) and !BMOD.sfx_playing.has(preload("res://assets/sfx/dialog.tres"))) and is_on_floor():
			BMOD.play_sfx(preload("res://assets/sfx/walk.tres"))
		state = "walking"
	if velocity.x == 0 and velocity.y == 0 and anim.animation != "attack" and state != "dying":
		anim.play("idle")
		state = "idle"
		
	var was_on_floor = is_on_floor()
	move_and_slide()
	if was_on_floor and not is_on_floor():
		$Coyote.start()
func generate_bullet():
	var direction:int
	if $AnimatedSprite2D.flip_h:
		direction = -1
	else:
		direction = 1
	var bullet = preload("res://scenes/2d/bullet.tscn")
	var new_node = bullet.instantiate()
	new_node.direction.x = direction
	new_node.position.x = position.x + 40 * direction
	new_node.position.y = position.y - 20
	get_tree().root.add_child(new_node)


func _on_timer_timeout() -> void:
	invincible = false
