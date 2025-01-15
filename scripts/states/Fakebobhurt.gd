extends State

@onready var fakebob:CharacterBody2D = get_parent().get_parent()
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func Enter():
	fakebob.health -= 1
	fakebob.velocity = Vector2(0,0)
	$"../../AnimatedSprite2D".play("hurt")
	if fakebob.health <= 0:
		Ui.create_dialog("PLEASE. HAVE [b]OHIO[/b] MERCY.","fakebob")
		get_tree().change_scene_to_file("res://scenes/2d/chooseone_and_one_only.tscn")
		get_parent().queue_free()
	else:
		Ui.create_dialog("[shake]OHIO OHIO OHIO OHIO OHIO OHIO OHIO[/shake]","fakebob")
	
func Physics_Update(delta: float):
	$"../../AnimatedSprite2D".rotate(delta * 3)
	if not fakebob.is_on_floor():
		if $"../../AnimatedSprite2D".animation != "jump":
			$"../../AnimatedSprite2D".play("fall")
		fakebob.velocity.y += gravity * delta
	fakebob.move_and_slide()
	await $"../../AnimatedSprite2D".animation_finished
	Transitioned.emit(self, "Idle")
