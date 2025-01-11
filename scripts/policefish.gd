extends Area2D

@export var target:Node2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var direction := (target.position - position).normalized() * 2
	position += direction
