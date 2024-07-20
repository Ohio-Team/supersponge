extends State

@onready var player = get_tree().get_first_node_in_group("Player")
@onready var spongebot = get_parent().get_parent()

var target:Vector2

func Enter():
	target = player.position

func Update(delta):
	var direction = (target - spongebot.position).normalized()
	if spongebot.position != target:
		spongebot.position.x += direction.x * 4
		spongebot.position.y += direction.y * 4
		print(spongebot.position.distance_to(target))
	if spongebot.position.distance_to(target) < 3:
		Transitioned.emit(self, "Idle")


func _on_spongebot_body_entered(body):
	if body == player:
		if player.state != "attack" or player.state != "groundpound":
			if player.state != "dying":
				player.state = "hurt"
				Singleton.health -= 1
		else:
			Singleton.do_explosion(spongebot.position)
			queue_free()
