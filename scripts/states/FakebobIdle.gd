extends State

var movement_speed: float = 200.0
@onready var player:CharacterBody2D = get_tree().get_first_node_in_group("Player")
@onready var fakebob:CharacterBody2D = get_parent().get_parent()
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var nav_agent := $"../../NavigationAgent2D"

func Enter():
	pass

func Physics_Update(delta):
	if not fakebob.is_on_floor():
		if $"../../AnimatedSprite2D".animation != "jump":
			$"../../AnimatedSprite2D".play("fall")
		fakebob.velocity.y += gravity * delta
	
	var dir = fakebob.to_local(nav_agent.get_next_path_position()).normalized()
	if fakebob.is_on_floor():
		$"../../AnimatedSprite2D".play("default")
	fakebob.velocity.x = dir.x * movement_speed
	
	if dir.y < 0 and fakebob.is_on_floor():
		$"../../AnimatedSprite2D".play("jump")
		fakebob.velocity.y = -430.0
	fakebob.move_and_slide()

func _on_navtimer_timeout():
	nav_agent.target_position = player.global_position
