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
	if spongebot.position.distance_to(target) < 3:
		Transitioned.emit(self, "Idle")
		
	if direction.x < 0:
		$"../../AnimatedSprite2D".flip_h = true
	else:
		$"../../AnimatedSprite2D".flip_h = false


func _on_spongebot_body_entered(body):
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
