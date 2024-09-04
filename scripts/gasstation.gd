extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	MusicPlayer.play_song("res://assets/music/night.ogg")
