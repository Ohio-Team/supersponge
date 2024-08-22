extends Window

var canmove : bool = false
@onready var screen_size = DisplayServer.screen_get_size()
@onready var speed = Vector2i(randf_range(-30,30),randf_range(-30, 30))

func _ready() -> void:
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if canmove:
		position += speed
		if position.x < 0:
			position.x = -position.x
			speed = Vector2i(randf_range(-30,30),randf_range(-30,30))
		if position.x > DisplayServer.screen_get_size().x:
			position.x = -position.x
			speed = Vector2i(randf_range(-30,30),randf_range(-30,30))
		if position.y < 0:
			position.y = -position.y
			speed = Vector2i(randf_range(-30,30),randf_range(-30,30))
		if position.y > DisplayServer.screen_get_size().y:
			position.y = -position.y
			speed = Vector2i(randf_range(-30,30),randf_range(-30,30))
		if position.x > DisplayServer.screen_get_size().x * 2 or position.x < -DisplayServer.screen_get_size().x * 2 or position.y > DisplayServer.screen_get_size().y * 2 or position.y < -DisplayServer.screen_get_size().y * 2:
			position = Vector2i(0,0)


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and mouse_entered and canmove:
		hide()
		get_parent().switch()
		queue_free()
