extends State

@onready var player = get_tree().get_first_node_in_group("Player")
@onready var spongebot = get_parent().get_parent()

var dir: Vector2

func Enter():
	await Singleton.wait(1)

func Update(delta):
	if spongebot.position.distance_to(player.position) < 100:
		Transitioned.emit(self, "Homing")
