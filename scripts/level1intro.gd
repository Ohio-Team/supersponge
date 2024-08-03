extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	MusicPlayer.stop_song()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_audio_stream_player_finished():
	get_tree().change_scene_to_file("res://scenes/2d/level1.tscn")
