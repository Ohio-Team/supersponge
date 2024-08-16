extends CharacterBody2D

@onready var player: CharacterBody2D = get_tree().get_first_node_in_group("Player")

# Called when the node enters the scene tree for the first time.
func _ready():
	$Sprite2D.frame = randi() % 6

func _physics_process(delta):
	$Sprite2D.rotation += delta
	velocity = Vector2(750, 0).rotated(rotation)
	move_and_slide()


func _on_timer_timeout() -> void:
	queue_free()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body == player:
			if player.state != "dying":
				Singleton.health -= 1
				player.state = "hurt"
