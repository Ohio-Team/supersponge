extends Node2D
var bartcounter : int = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	DiscordRPC.details = "CLICK THE BART!!"
	DiscordRPC.large_image = "barting"
	DiscordRPC.refresh()
	Singleton.save_game()
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	MusicPlayer.play_song("res://assets/music/bartbash.ogg")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if bartcounter == 32 and is_instance_valid($Window):
		$Window.show()
		if !$Window.canmove and $Window.visible:
			MusicPlayer.stop_song()
			Input.start_joy_vibration(0,0.5,0.4,0)
			await Singleton.wait(5)
		if !$Window.canmove and $Window.visible and $Window.visible:
			Input.stop_joy_vibration(0)
			MusicPlayer.play_song("res://assets/music/evilbartbash.ogg")
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
		$Subtitles.show()
		await $AudioStreamPlayer.finished
		get_tree().change_scene_to_file("res://scenes/3d/level6.tscn")
