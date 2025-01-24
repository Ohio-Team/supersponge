extends CharacterBody2D

var movement_speed: float = 220.0
@onready var player:CharacterBody2D = get_tree().get_first_node_in_group("Player")
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var nav_agent := $NavigationAgent2D
func _ready():
	$AnimatedSprite2D.rotation = 0

func _process(delta):
	if not is_on_floor():
		if $AnimatedSprite2D.animation != "jump" or $AnimatedSprite2D.animation != "hurt":
			$AnimatedSprite2D.play("fall")
		velocity.y += gravity * delta
	
	var dir = to_local(nav_agent.get_next_path_position()).normalized()
	if is_on_floor():
		$AnimatedSprite2D.play("default")
	velocity.x = dir.x * movement_speed
	
	if dir.y < 0 and is_on_floor():
		$AnimatedSprite2D.play("jump")
		BMOD.play_sfx(preload("res://assets/sfx/fakejump.tres"))
		velocity.y = -430.0

	move_and_slide()
	
	for body in $Area2D.get_overlapping_bodies():
		if body == player:
			if player.state != "dying" and !player.invincible and player.state != "attack" and player.state != "groundpound":
				Singleton.health -= 1
				player.state = "hurt"
			if player.state == "attack" or player.state == "groundpound":
				Singleton.do_explosion(position)
				queue_free()
	
	if dir.x < 0:
		$AnimatedSprite2D.flip_h = true
	else:
		$AnimatedSprite2D.flip_h = false
func _on_navtimer_timeout():
	nav_agent.target_position = player.global_position


func _on_area_2d_area_entered(area):
	if area.is_in_group("Projectiles"):
		$AnimatedSprite2D.play("hurt")
		Singleton.do_explosion(position)
		queue_free()
