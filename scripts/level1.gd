extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	DiscordRPC.details = "Walking on Bikini Bottom"
	DiscordRPC.refresh()
	Singleton.inmenu = false
	Singleton.hasgun = false
	Singleton.save_game()
	Ui._clear_dialog()
	MusicPlayer.play_song("res://assets/music/jelly.ogg")
	Ui.create_dialog("Here we go. Let's save [b]my ohio hometown.[b]", "spongebob")
	await Ui.dialog_finished
	Ui.create_dialog("Watch out spongeboy. There's some [shake]oddities[/shake] ahead," , "sandy+")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
