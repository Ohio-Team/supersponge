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
		$Window.position = lerp(Vector2($Window.position), Vector2(-10,-5), 0.1)
		MusicPlayer.stop_song()
		if $Window.position == Vector2i(0,0):
			await Singleton.wait(5)
			$Window/Camera2D/Window.show()
			await Singleton.wait(2)
			$Window/Camera2D/Window.hide()
			$AudioStreamPlayer.play()
