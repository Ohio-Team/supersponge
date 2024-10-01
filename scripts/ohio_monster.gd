extends CharacterBody3D

@onready var nav_agent = $NavigationAgent3D
@onready var player = get_tree().get_first_node_in_group("Player")
var SPEED = 10.0
var direction = Vector3()
func _physics_process(delta: float) -> void:
	velocity = velocity.lerp(direction,10)
	move_and_slide()
func _on_timer_timeout() -> void:
	nav_agent.target_position = player.position
	direction = nav_agent.get_next_path_position() - global_transform.origin
	direction = direction.normalized()
