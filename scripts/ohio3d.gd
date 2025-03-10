extends CharacterBody3D

@onready var nav_agent = $NavigationAgent3D
@onready var player = get_tree().get_first_node_in_group("Player")
var SPEED = 30.0
@onready var healthchance = randf_range(0,1)
var direction = Vector3()
func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y -= get_gravity().y * delta
	velocity = velocity.lerp(direction * 7, 50 * delta)
	move_and_slide()
	if position.y < 0:
		BMOD.play_sfx_3d(preload("res://assets/sfx/gib.tres"),position)
		queue_free()
func _on_timer_timeout() -> void:
	nav_agent.target_position = player.global_position
	direction = nav_agent.get_next_path_position() - global_position
	direction = direction.normalized()
	if nav_agent.target_position.y > position.y and is_on_floor():
		velocity.y = 10


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body == player:
		BMOD.play_sfx_3d(preload("res://assets/sfx/cjhurt.tres"),position)
		player.doomthing.play("Hurt")
		Singleton.health -= 1
		await player.doomthing.animation_finished
		player.doomthing.play("Idle")

func _on_area_3d_area_entered(area: Area3D) -> void:
	if area.is_in_group("Projectiles"):
		area.queue_free()
		if healthchance < 0.2:
			var healththing = preload("res://scenes/3d/health.tscn")
			var newhealthth = healththing.instantiate()
			newhealthth.position = position
			get_tree().current_scene.add_child(newhealthth)
		BMOD.play_sfx_3d(preload("res://assets/sfx/ohioscreams.tres"),position)
		queue_free()
