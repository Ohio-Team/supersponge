extends Control

@export var after_cutscene:PackedScene
@onready var ptime:float = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	MusicPlayer.stop_song()
	$VideoStreamPlayer.connect("finished", gotonext)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	ptime += delta
	if ptime > 0.01 and Input.is_anything_pressed():
		gotonext()

func gotonext():
	get_tree().change_scene_to_packed(after_cutscene)
