extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	Singleton.save_game()
	MusicPlayer.play_song("res://assets/music/fakebob.ogg")
	Singleton.hasgun = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
