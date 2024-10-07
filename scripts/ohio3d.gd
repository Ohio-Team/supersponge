extends CharacterBody3D

@onready var nav_agent = $NavigationAgent3D
@onready var player = get_tree().get_first_node_in_group("Player")
var SPEED = 10.0
var direction = Vector3()
func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y -= get_gravity().y * delta
	velocity = velocity.lerp(direction * 2, 50 * delta)
	move_and_slide()
func _on_timer_timeout() -> void:
	nav_agent.target_position = player.global_position
	direction = nav_agent.get_next_path_position() - global_position
	direction = direction.normalized()


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body == player and player.state == "groundpound":
		BMOD.play_sfx_3d(preload("res://assets/sfx/jumpscare.tres"),position)
		queue_free()
