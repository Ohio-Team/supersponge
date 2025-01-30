extends Node2D

@export var after_cutscene:PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	MusicPlayer.stop_song()
	$VideoStreamPlayer.connect("finished", gotonext)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_anything_pressed():
		gotonext()

func gotonext():
	get_tree().change_scene_to_packed(after_cutscene)
