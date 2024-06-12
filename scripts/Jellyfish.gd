extends Area2D

@onready var player = get_parent().get_node("Spongebob")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$AnimatedSprite2D.play("default")
	if $AnimatedSprite2D.animation_finished:
		position.x -= 1


func _on_body_entered(body):
	if body == player:
		if player.state == "groundpound" or player.state == "attack":
			queue_free()
		else:
			Singleton.lifes -= 1
			player.state = "hurt"
			print(player.state)
