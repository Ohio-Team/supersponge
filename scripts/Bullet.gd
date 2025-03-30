extends Area2D
@onready var player = get_tree().get_first_node_in_group("Player")
const SPEED = 70.0
const JUMP_VELOCITY = -400.0
var hurt_player = true

# Get the gravity from the project settings to be synced with RigidBody nodes.
@export var direction:Vector2

func _ready():
	BMOD.play_sfx(preload("res://assets/sfx/shoot.tres"))
	

#func _process(delta):
#	for body in get_overlapping_bodies():
#		if body == player:
#			if player.state == "attack":
#				hurt_player = false
#				position.x -= 2 * -direction.x
#				direction = -direction
#				$Bullet.flip_h = -direction.x
#			elif player.state != "dying" and !player.invincible and hurt_player == true:
#					Singleton.health -= 1
#					player.state = "hurt"

func _physics_process(delta):
	position.x += 2 * direction.x


func _on_timer_timeout():
	queue_free()
	
func _on_body_entered(body):
	if body == player:
			if player.state == "attack":
				hurt_player = false
				position.x -= 2 * -direction.x
				direction = -direction
				$Bullet.flip_h = -direction.x
	elif player.state != "dying" and !player.invincible and hurt_player == true:
					Singleton.health -= 1
					player.state = "hurt"
