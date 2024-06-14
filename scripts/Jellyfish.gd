extends Area2D

@onready var player = get_parent().get_node("Spongebob")
var direction = 1
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$AnimatedSprite2D.play("default")
	if $AnimatedSprite2D.animation_finished:
		position.x -= 0.8 * direction
	if direction == -1:
		$AnimatedSprite2D.flip_h = true
	elif direction == 1:
		$AnimatedSprite2D.flip_h  = false


func _on_body_entered(body):
	if body == player:
		print(player.state)
		if player.state == "groundpound" or player.state == "attack" or player.state == "fall" or player.state == "land":
			player.state = "jump"
			player.velocity.y = -400
			queue_free()
		else:
			Singleton.health -= 1
			player.state = "hurt"

	if body != player:
		direction = -direction
