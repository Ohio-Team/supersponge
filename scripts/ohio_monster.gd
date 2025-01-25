extends CharacterBody3D

@onready var nav_agent = $NavigationAgent3D
@onready var player = get_tree().get_first_node_in_group("Player")
var istired = -1
var SPEED = 10.0
var direction = Vector3()
func _physics_process(delta: float) -> void:
	velocity = velocity.lerp(direction * 6, 50 * delta)
	move_and_slide()
func _on_timer_timeout() -> void:
	if !istired == 1:
		nav_agent.target_position = player.global_position
		direction = nav_agent.get_next_path_position() - global_position
		direction = direction.normalized()

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("Player") and istired != 1:
		Input.start_joy_vibration(0,1,1,1)
		BMOD.play_sfx(preload("res://assets/sfx/jumpscare.tres"))
		OS.alert("ONLY IN OHIO! OOOH!","Ohio Alert!")
		OS.alert("ONLY IN OHIO! OOOH!","Ohio Alert!")
		if get_tree():
			Singleton.deaths += 1
			get_tree().reload_current_scene()


func _on_tired_timer_timeout() -> void:
	istired = -istired
	if istired == 1:
		Ui.create_dialog("The Ohio Monster is tired, take a chance and move quick","kanye")
