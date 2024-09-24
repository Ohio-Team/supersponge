extends Area2D

@onready var player := get_tree().get_first_node_in_group("Player")
var donda : float
var canopen : bool = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("front") and canopen:
		get_tree().change_scene_to_file("res://scenes/2d/fakebobfight.tscn")
	donda = delta


func _on_body_entered(body):
	if body == player:
		canopen = true
