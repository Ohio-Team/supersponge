extends CharacterBody2D

@onready var player = get_tree().get_first_node_in_group("Player")
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var startmoving:bool = false

func _ready():
	$AnimatedSprite2D.play("default")

func _physics_process(delta):
	var direction = (player.position - position).normalized()
	
	var distance = position.distance_to(player.position)
	
	if distance < 150 and !player.invincible:
		startmoving = true
	else:
		startmoving = false
	
	if not is_on_floor():
		velocity.y += gravity * delta
		
	if startmoving:
		velocity.x = direction.x * 250
	else:
		velocity.x = 0
		
	move_and_slide()

func _on_hitzone_body_entered(body):
	if body == player:
		if player.state == "groundpound" or player.state == "attack" or player.state == "fall" or player.state == "land":
			Singleton.do_explosion(position)
			queue_free()
		elif player.state != "dying" and !player.invincible:
				Singleton.health -= 1
				player.state = "hurt"
