extends Node2D

var posVector: Vector2
@export var deadzone = 15

func _ready() -> void:
	if OS.get_name() != "Android":
		queue_free()
