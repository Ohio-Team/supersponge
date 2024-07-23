extends CharacterBody2D

var movement_speed: float = 200.0

@onready var player:CharacterBody2D = get_tree().get_first_node_in_group("Player")
@onready var nav_agent := $NavigationAgent2D as NavigationAgent2D
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	var dir = to_local(nav_agent.get_next_path_position()).normalized()
	velocity = dir * movement_speed
	move_and_slide()
	
func _on_timer_timeout():
	nav_agent.target_position = player.global_position
