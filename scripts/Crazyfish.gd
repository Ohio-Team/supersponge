extends CharacterBody2D

@onready var player = get_tree().get_first_node_in_group("Player")
@onready var bullet = "res://scenes/2d/enemy_bullet.tscn"
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var startmoving:bool = false

func _ready():
	$AnimatedSprite2D.play("default")

func _physics_process(delta):
	var direction = (player.position - position).normalized()
	
	var distance = position.distance_to(player.position)
	if not is_on_floor():
		velocity.y += gravity * delta
		
	move_and_slide()
	for body in $hitzone.get_overlapping_bodies():
		if body == player:
			if player.state == "groundpound" or player.state == "attack" or player.state == "fall" or player.state == "land":
				Singleton.do_explosion(position)
				queue_free()
			elif player.state != "dying" and !player.invincible:
					Singleton.health -= 1
					player.state = "hurt"
	for body in $laserzone.get_overlapping_bodies():
		if body == player:
			generate_bullet()
			$laserzone/CollisionShape2D2.queue_free()

			
func generate_bullet():
	var direction:int
	if $AnimatedSprite2D.flip_h:
		direction = -1
	else:
		direction = 1
	var bullet = preload("res://scenes/2d/enemy_bullet.tscn")
	var new_node = bullet.instantiate()
	new_node.direction.x = direction
	new_node.position.x = position.x + 40 * direction
	new_node.position.y = position.y - 20
	get_tree().current_scene.add_child(new_node)


func _on_hitzone_area_entered(area: Area2D) -> void:
		if area.is_in_group("Projectiles"):
			Singleton.do_explosion(position)
			queue_free()
