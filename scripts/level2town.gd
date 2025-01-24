extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	Singleton.hasgun = true
	MusicPlayer.play_song("res://assets/music/jelly.ogg")
	Ui.create_dialog("Now that you have the gun, let's find Fake Bob's base. Why don't try searching on the [b]ohio sewers[/b] first","sandy")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
