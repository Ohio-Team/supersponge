extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	MusicPlayer.play_song("res://assets/music/sewers.mp3")
	Ui.create_dialog("where the [b]ohio[/b] am i","spongebob")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
