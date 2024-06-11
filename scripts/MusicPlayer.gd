extends Node

@onready var player = $AudioStreamPlayer
var current_song
# Called when the node enters the scene tree for the first time.
func play_song(song):
	if !player.playing or !current_song == song:
		player.stop()
		player.stream = load(song)
		current_song = song
		player.play()
func stop_song():
	player.stop()
