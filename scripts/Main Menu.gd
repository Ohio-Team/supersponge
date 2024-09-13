extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	Singleton.inmenu = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	MusicPlayer.play_song("res://assets/music/sb-title.mp3")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
