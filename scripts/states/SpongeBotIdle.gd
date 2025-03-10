extends State

@onready var player = get_tree().get_first_node_in_group("Player")
@onready var spongebot = get_parent().get_parent()

var dir: Vector2

func Enter():
	await Singleton.wait(2)

func Physics_Update(delta):
	if spongebot:
		if spongebot.position.distance_to(player.position) < 100 and !player.invincible:
			Transitioned.emit(self, "Homing")
		for body in spongebot.get_overlapping_bodies():
			if body == player:
				if player.state == "groundpound" or player.state == "attack" or player.state == "fall" or player.state == "land":
					if player.state != "attack":
						player.state = "fall"
						player.velocity.y = -510
					Singleton.do_explosion(spongebot.position)
					spongebot.queue_free()
				elif player.state != "dying" and !player.invincible:
					Singleton.health -= 1
					player.state = "hurt"
				
func _on_spongebot_area_entered(area):
	if area.is_in_group("Projectiles"):
		Singleton.do_explosion(spongebot.position)
		spongebot.queue_free()
