extends Area2D

@onready var player = get_tree().get_first_node_in_group("Player")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body

func _on_body_entered(body):
	if body == player:
			BMOD.play_sfx(preload("res://assets/sfx/collect.tres"))
			queue_free()
			Singleton.spatulas += 1
	
