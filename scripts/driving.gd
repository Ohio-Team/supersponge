extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Singleton.fuel = 100.0
	Ui.create_dialog("Okay. Let's drive there. [shake]I GREW UP FOR THIS!")
	MusicPlayer.play_song("res://assets/music/driving.mp3")
