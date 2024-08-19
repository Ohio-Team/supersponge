extends Node2D
var bartcounter : int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	MusicPlayer.play_song("res://assets/music/bartbash.mp3")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if bartcounter == 32:
		$Window.show()
		MusicPlayer.stop_song()
		await Singleton.wait(5)
		$Window/Camera2D/Window.show()
		await Singleton.wait(2)
		get_tree().quit()
