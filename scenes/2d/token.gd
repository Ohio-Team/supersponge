extends Area2D
@onready var player = get_tree().get_first_node_in_group("Player")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	
	
func _on_body_entered(body):
	if body == player:
		print("token collected")
		BMOD.play_sfx(preload("res://assets/sfx/fuel.tres"))
		queue_free()


@export var frequency = 6: 
	set(float): 1000
@export var amplitude = 50: 
	set(float): 1 
var time = 0

func _physics_process(delta: float) -> void:
	time += delta
	var movement = cos(time*frequency)*amplitude
	position.y+=movement * delta
