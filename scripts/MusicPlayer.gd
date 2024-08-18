extends Node

@onready var player = $AudioStreamPlayer
@onready var modplayer = $ModPlayer
var current_song
# Called when the node enters the scene tree for the first time.
func play_song(song):
	if !player.playing or !current_song == song:
		modplayer.stop()
		player.stop()
		player.stream = load(song)
		current_song = song
		player.play()
func stop_song():
	player.stop()

func play_mod(song):
	if !modplayer.playing or !current_song == song:
		player.stop()
		modplayer.stop()
		modplayer.file = song
		current_song = song
		modplayer.play()
		
func stop_mod():
	modplayer.stop()
