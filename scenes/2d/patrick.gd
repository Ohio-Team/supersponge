extends Area2D

@export var speed:float = 5
func _process(delta):
	rotate(speed * delta)
