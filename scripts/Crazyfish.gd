extends CharacterBody2D

@onready var player = get_parent().get_parent().get_node("Spongebob")
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var startmoving:bool = false

func _ready():
	$AnimatedSprite2D.play("default")

func _physics_process(delta):
	var direction = (player.position - position).normalized()
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		
	if startmoving:
		velocity.x = direction.x * 250
		
	move_and_slide()

func _on_visiblezone_entered(body):
	if body == player:
		startmoving = true

func _on_hitzone_body_entered(body):
	if body == player:
		if player.state == "groundpound" or player.state == "attack" or player.state == "land":
			Singleton.do_explosion(position)
			queue_free()
		else:
			if player.state != "dying":
				Singleton.health -= 1
				player.state = "hurt"
