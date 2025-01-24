extends State

var movement_speed: float = 220.0
@onready var player:CharacterBody2D = get_tree().get_first_node_in_group("Player")
@onready var fakebob:CharacterBody2D = get_parent().get_parent()
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var nav_agent := $"../../NavigationAgent2D"
var idlingtime : float
var cooldown : float
func Enter():
	cooldown = 3
	idlingtime = randf_range(5,10)
	$"../../AnimatedSprite2D".rotation = 0

func Physics_Update(delta):
	if not fakebob.is_on_floor():
		if $"../../AnimatedSprite2D".animation != "jump" or $"../../AnimatedSprite2D".animation != "hurt":
			$"../../AnimatedSprite2D".play("fall")
		fakebob.velocity.y += gravity * delta
	
	var dir = fakebob.to_local(nav_agent.get_next_path_position()).normalized()
	if fakebob.is_on_floor():
		$"../../AnimatedSprite2D".play("default")
	if fakebob.position.distance_to(dir) > 20:
		fakebob.velocity.x = dir.x * movement_speed
	print(fakebob.global_position.distance_to(nav_agent.get_next_path_position()))
	if dir.y < 0 and fakebob.is_on_floor():
		$"../../AnimatedSprite2D".play("jump")
		BMOD.play_sfx(preload("res://assets/sfx/fakejump.tres"))
		fakebob.velocity.y = -430.0
		
	if idlingtime > 0:
		idlingtime -= delta
	else:
		Transitioned.emit(self, "Attack")
		
	if cooldown > 0:
		cooldown -= delta
		
	if cooldown > 0 and cooldown < 0.03:
		$"../../AnimatedSprite2D/AnimationPlayer".play("flash")
		BMOD.play_sfx(preload("res://assets/sfx/bossvulnerable.tres"))
	
	fakebob.move_and_slide()
	
	for body in $"../../Area2D".get_overlapping_bodies():
		if body == player:
			if player.state != "dying" and !player.invincible and player.state != "attack":
				Singleton.health -= 1
				player.state = "hurt"
			if player.state == "attack":
				Transitioned.emit(self, "Hurt")
				BMOD.play_sfx(preload("res://assets/sfx/bart.tres"))
	
	if dir.x < 0:
		$"../../AnimatedSprite2D".flip_h = true
	else:
		$"../../AnimatedSprite2D".flip_h = false
func _on_navtimer_timeout():
	nav_agent.target_position = player.global_position

func _on_area_2d_area_entered(area):
	if area.is_in_group("Projectiles") and $"../../AnimatedSprite2D".animation != "jump" and $"../../AnimatedSprite2D".animation != "hurt" and $"../../AnimatedSprite2D".animation != "attack" and cooldown < 0:
		$"../../AnimatedSprite2D".play("hurt")
		Transitioned.emit(self, "Hurt")
		BMOD.play_sfx(preload("res://assets/sfx/bart.tres"))
