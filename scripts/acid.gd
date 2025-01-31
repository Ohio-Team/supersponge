extends Area2D

@onready var player = get_tree().get_first_node_in_group("Player")
@onready var time = randf_range(2,5)
# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.wait_time = time

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_body_entered(body):
	if body == player:
		if player.state != "dying" and !player.invincible:
			Singleton.health -= 1
			player.velocity.y += -1000
			player.state = "hurt"

func _on_timer_timeout() -> void:
	var bu = preload("res://scenes/2d/bubble.tscn")
	var bubble = bu.instantiate()
	var half_x = scale.x / 2
	bubble.position = Vector2(position.x+randf_range(-half_x,half_x),position.y)
	get_parent().add_child(bubble)
