extends Node

@onready var player = $AudioStreamPlayer
var current_song:String
var last_song:String
# Called when the node enters the scene tree for the first time.
func play_song(song):
	if !player.playing or !current_song == song:
		player.stop()
		player.stream = load(song)
		current_song = song
		player.play()
func stop_song():
	last_song = current_song
	player.stop()

func _process(delta: float) -> void:
	if get_tree().paused:
		if current_song != "res://assets/music/pause.mp3":
			stop_song()
		play_song("res://assets/music/pause.mp3")
	else:
		if last_song:
			play_song(last_song)
