extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	DiscordRPC.details = "In the Ohio Sewers"
	DiscordRPC.refresh()
	Singleton.save_game()
	MusicPlayer.play_song("res://assets/music/sewers.wav")
	Ui._clear_dialog()
	Ui.create_dialog("where the [b]ohio[/b] am i","spongebob")
	Singleton.hasgun = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
