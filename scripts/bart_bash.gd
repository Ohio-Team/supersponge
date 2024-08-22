extends Node2D
var bartcounter : int = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	MusicPlayer.play_song("res://assets/music/bartbash.mp3")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if bartcounter == 32 and is_instance_valid($Window):
		$Window.show()
		if !$Window.canmove and $Window.visible:
			MusicPlayer.stop_song()
			await Singleton.wait(5)
		if !$Window.canmove and $Window.visible and $Window.visible:
			MusicPlayer.play_song("res://assets/music/evilbartbash.wav")
			OS.alert("You shouldnt have done that.","Ohio Alert")
			OS.alert("Let's see if you can bash me.","Ohio Alert")
			OS.alert("(Before we start, we recommend minimizing other tabs so you dont lose bart)")
			$Window.canmove = true
	else:
		return
func switch() -> void:
		$Window.canmove = false
		MusicPlayer.stop_song()
		$AudioStreamPlayer.play()
		await $AudioStreamPlayer.finished
		get_tree().change_scene_to_file("res://scenes/3d/level6.tscn")
