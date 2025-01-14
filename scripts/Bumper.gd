extends Area2D

@onready var player = get_tree().get_first_node_in_group("Player")
@export var bounce_force:int = -1000
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	BMOD.play_sfx(preload("res://assets/sfx/spring.tres"))
	body.velocity.y = bounce_force
