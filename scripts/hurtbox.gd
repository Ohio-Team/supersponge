extends Area2D

@onready var player = get_tree().get_first_node_in_group("Player")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	if body == player:
		if player.state != "dying":
			Singleton.health = 0
			player.state = "hurt"
	if body.is_in_group("Enemy"):
		BMOD.play_sfx_2d(preload("res://assets/sfx/scream.tres"),body.position)
		body.queue_free()
