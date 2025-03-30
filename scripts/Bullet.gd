extends Area2D
@onready var player = get_tree().get_first_node_in_group("Player")

const SPEED = 70.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
@export var direction:Vector2

func _ready():
	$Bullet.flip_h = direction.x
	BMOD.play_sfx(preload("res://assets/sfx/shoot.tres"))
	

func _process(delta):
	for body in get_overlapping_bodies():
		if body == player:
			if player.state == "groundpound" or player.state == "attack" or player.state == "fall" or player.state == "walking" and !player.is_on_floor() or player.state == "land":
				$Bullet.flip_h = direction.x
			elif player.state != "dying" and !player.invincible:
					Singleton.health -= 1
					player.state = "hurt"

func _physics_process(delta):
	position.x += 2 * direction.x


func _on_timer_timeout():
	queue_free()
