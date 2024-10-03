extends Node3D


func _ready() -> void:
	if OS.get_name() != "Android":
		DiscordRPC.details = "Spongebob Now In 3D"
		DiscordRPC.refresh()
	Singleton.save_game()
	Ui.create_dialog("Maybe I should find the Smiling Friends somewhere.","spongebob")
	MusicPlayer.play_song("res://assets/music/redsector.mp3")
