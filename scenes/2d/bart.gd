extends Area2D

var speed : Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	speed = Vector2(randi_range(-10,10),randi_range(-10,10))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += speed

func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		Singleton.do_explosion(position)
		get_parent().get_parent().bartcounter += 1
		queue_free()


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	speed = -speed
