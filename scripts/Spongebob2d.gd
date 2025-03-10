@icon("res://assets/icons/sbicon.svg")
extends CharacterBody2D

const SPEED = 250.0
const JUMP_VELOCITY = -430.0

@onready var camera = $Camera2D
@onready var anim = $AnimatedSprite2D
@export var state = "idle"
@export var acceleration:float = 0.0
@export var invincible:bool = false
@export var camerashake:bool = false
var direction:float
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	pass

func inputs(direction, delta):
	if Singleton.acceptinput:
		if state == "hurt":
			BMOD.play_sfx(preload("res://assets/sfx/ouch.tres"))
			Input.start_joy_vibration(0,0.5,0.4,1)
			$Invincibility.start()
			velocity.x += SPEED * 4 * -direction
			velocity.y = -450
			anim.play("hurt")
			invincible = true
			if anim.animation_finished:
				state = "idle"
		if Input.is_action_just_pressed("attack") and state != "dying" and state != "hurt":
			if Singleton.hasgun == false:
				state = "attack"
				anim.play("attack")
				if !$Attack.playing:
					$Attack.play()
				$CollisionShape2D.shape.size = Vector2(48,35)
				position.y -= 5
				await $AnimatedSprite2D.animation_finished
				state = "idle"
				anim.play("idle")
				$CollisionShape2D.shape.size = Vector2(12,30)
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
					$CollisionShape2D.shape.size = Vector2(12,30)
		if Input.is_action_just_pressed("groundpound") and state != "dying" and state != "hurt" and not is_on_floor() and $Coyote.is_stopped():
				velocity.y = -JUMP_VELOCITY
				anim.play("groundpound")
				state = "groundpound"
				$CollisionShape2D.shape.size = Vector2(12,30)
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
	if !$Invincibility.is_stopped():
		$AnimatedSprite2D.self_modulate = Color("ffffff80")
	else:
		$AnimatedSprite2D.self_modulate = Color("ffffff")
	
	if camerashake:
		$Camera2D.offset = Vector2(randf_range(-1,1),randf_range(-49,-51))
	else:
		$Camera2D.offset = Vector2(0,-50)
	
	if Singleton.health <= 0:
		print("game over 💔")
		BMOD.play_sfx(preload("res://assets/sfx/death.tres"))
		Singleton.health = 3
		Singleton.spatulas -= 10
		state = "dying"
		Input.start_joy_vibration(0,0.5,0.5,1)
		anim.play("dying")
		await anim.animation_finished
		if get_tree():
			get_tree().reload_current_scene()
	if not is_on_floor():
		velocity.y += gravity * delta
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var prev_dir = direction
	direction = Input.get_axis("left", "right")
	inputs(direction,delta)
	if direction < 0:
		anim.flip_h = true
	elif direction > 0:
		anim.flip_h = false
	if direction and anim.animation != "hurt" and anim.animation != "turn" and anim.animation != "attack" and state != "dying":
		velocity.x = direction * SPEED * acceleration
		$AnimatedSprite2D.speed_scale = acceleration
		acceleration = lerpf(acceleration, 1, delta * 3)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED / 2)
		$AnimatedSprite2D.speed_scale = 1
		acceleration = lerpf(acceleration, 0, delta * 8)
	if velocity.x != 0 and anim.animation != "jump" and anim.animation != "fall" and anim.animation != "groundpound" and anim.animation != "hurt" and anim.animation != "attack" and state != "dying":
		anim.play("run")
		if !$Walk.playing and is_on_floor():
			$Walk.play()
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
	get_tree().current_scene.add_child(new_node)


func _on_timer_timeout() -> void:
	invincible = false


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and state != "dying":
		state = "hurt"
