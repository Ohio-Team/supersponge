extends Node3D


func _ready() -> void:
	DiscordRPC.details = "Spongebob Now In 3D"
	DiscordRPC.refresh()
	Singleton.save_game()
	Ui.create_dialog("Maybe I should find the Smiling Friends somewhere.","spongebob")
	MusicPlayer.play_song("res://assets/music/redsector.mp3")
