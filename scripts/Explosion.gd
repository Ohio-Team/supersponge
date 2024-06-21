extends AnimatedSprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	play("default")
	BMOD.play_sfx_2d(preload("res://assets/sfx/bart.tres"),position)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	await animation_finished
	queue_free()
