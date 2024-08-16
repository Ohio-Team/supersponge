extends State

@onready var fakebob:CharacterBody2D = get_parent().get_parent()
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func Enter():
	$"../../AnimatedSprite2D".play("hurt")
	
func Physics_Update(delta: float):
	$"../../AnimatedSprite2D".rotate(delta * 3)
	await $"../../AnimatedSprite2D".animation_finished
	Transitioned.emit(self, "Idle")
