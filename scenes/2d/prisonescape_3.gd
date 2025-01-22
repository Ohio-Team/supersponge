extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Singleton.save_game()
	$Spongebob.camerashake = true
	MusicPlayer.play_song("res://assets/music/escape.ogg")

func change():
	get_tree().change_scene_to_file("res://scenes/2d/prisonescape.tscn")
