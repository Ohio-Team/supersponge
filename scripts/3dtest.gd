extends Node3D


func _ready() -> void:
	Singleton.save_game()
	MusicPlayer.play_song("res://assets/music/redsector.mp3")
