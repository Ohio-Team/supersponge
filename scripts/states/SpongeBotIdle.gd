extends State

@onready var player = get_tree().get_first_node_in_group("Player")
@onready var spongebot = get_parent().get_parent()

var dir: Vector2

func Enter():
	await Singleton.wait(2)

func Physics_Update(delta):
	if spongebot:
		if spongebot.position.distance_to(player.position) < 100:
			Transitioned.emit(self, "Homing")

func _on_spongebot_body_entered(body):
	if body == player:
		if player.state == "groundpound" or player.state == "attack":
			Singleton.do_explosion(spongebot.position)
			spongebot.queue_free()
		else:
			if player.state != "dying" and !player.invincible:
				Singleton.health -= 1
				player.state = "hurt"


func _on_spongebot_area_entered(area):
	if area.is_in_group("Projectiles"):
		Singleton.do_explosion(spongebot.position)
		spongebot.queue_free()
