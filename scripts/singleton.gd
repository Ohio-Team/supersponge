extends Node

@export var inmenu:bool = false
@export var lifes:int = 4
@export var health:int = 3
@export var spatulas:int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func create(node:PackedScene):
	var new_node = node.instantiate()
	add_child(new_node)

func do_explosion(pos:Vector2):
	var node = preload("res://scenes/2d/explosion.tscn")
	var new_node = node.instantiate()
	new_node.position = pos
	add_child(new_node)

func wait(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout
