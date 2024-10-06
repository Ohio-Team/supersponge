extends CharacterBody3D

@onready var nav_agent = $NavigationAgent3D
@onready var player = get_tree().get_first_node_in_group("Player")
var SPEED = 10.0
var direction = Vector3()
func _physics_process(delta: float) -> void:
	velocity = velocity.lerp(direction * 6, 50 * delta)
	move_and_slide()
func _on_timer_timeout() -> void:
	nav_agent.target_position = player.global_position
	direction = nav_agent.get_next_path_position() - global_position
	direction = direction.normalized()


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("Player"):
		BMOD.play_sfx(preload("res://assets/sfx/jumpscare.tres"))
		OS.alert("ONLY IN OHIO! OOOH!","Ohio Alert!")
		OS.alert("ONLY IN OHIO! OOOH!","Ohio Alert!")
		if get_tree():
			get_tree().reload_current_scene()
