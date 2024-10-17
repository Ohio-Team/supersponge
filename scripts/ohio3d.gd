extends CharacterBody3D

@onready var nav_agent = $NavigationAgent3D
@onready var player = get_tree().get_first_node_in_group("Player")
var SPEED = 30.0
var direction = Vector3()
func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y -= get_gravity().y * delta
	velocity = velocity.lerp(direction * 7, 50 * delta)
	move_and_slide()
func _on_timer_timeout() -> void:
	nav_agent.target_position = player.global_position
	direction = nav_agent.get_next_path_position() - global_position
	direction = direction.normalized()


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body == player:
		BMOD.play_sfx_3d(preload("res://assets/sfx/cjhurt.tres"),position)
		Singleton.health -= 1

func _on_area_3d_area_entered(area: Area3D) -> void:
	if area.is_in_group("Projectiles"):
		area.queue_free()
		var healththing = preload("res://scenes/3d/health.tscn")
		var newhealthth = healththing.instantiate()
		newhealthth.position = position
		get_tree().current_scene.add_child(newhealthth)
		BMOD.play_sfx_3d(preload("res://assets/sfx/ohioscreams.tres"),position)
		queue_free()
