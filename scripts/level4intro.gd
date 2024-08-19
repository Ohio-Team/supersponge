extends Node2D


func _ready() -> void:
	MusicPlayer.stop_song()

func _on_audio_stream_player_finished() -> void:
	get_tree().change_scene_to_file("res://scenes/3d/level4.tscn")
