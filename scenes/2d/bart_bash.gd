extends Node2D
var bartcounter : int = 0
var increasingthing : float = 0.0
# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	MusicPlayer.play_song("res://assets/music/bartbash.mp3")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if bartcounter == 32:
		$Window.show()
		$Window.position = lerp(Vector2(326,74), Vector2(300,74), increasingthing)
		if increasingthing != 1:
			increasingthing += 0.1
		MusicPlayer.stop_song()
		if $Window.position == Vector2i(300,74):
			await Singleton.wait(5)
			$Window/Camera2D/Window.show()
			await Singleton.wait(2)
			get_tree().quit()
