extends Node

@export var inmenu:bool = true
@export var lifes:int = 3

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func create(node:PackedScene):
	var new_node = node.instantiate()
	add_child(new_node)

func wait(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout
