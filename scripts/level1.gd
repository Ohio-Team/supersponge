extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	Singleton.inmenu = false
	Singleton.save_game()
	Ui._clear_dialog()
	MusicPlayer.play_song("res://assets/music/jelly.mp3")
	Ui.create_dialog("Here we go. Let's save [b]my ohio hometown.[b]", "spongebob")
	await Ui.dialog_finished
	Ui.create_dialog("Watch out spongeboy. There's some [shake]oddities[/shake] ahead. You can press [b]X[/b] to attack.", "sandy+")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
