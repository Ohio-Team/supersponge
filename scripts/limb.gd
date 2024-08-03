extends CharacterBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$Sprite2D.frame = randi() % 6

func _physics_process(delta):
	$Sprite2D.rotation += delta
	velocity = Vector2(750, 0).rotated(rotation)
	move_and_slide()
