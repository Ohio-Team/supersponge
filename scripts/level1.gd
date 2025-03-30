extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	DiscordRPC.details = "Walking on Bikini Bottom... TWO!"
	DiscordRPC.refresh()
	Singleton.inmenu = false
	Singleton.hasgun = false
	Singleton.save_game()
	Ui._clear_dialog()
	MusicPlayer.play_song("res://assets/music/Unreal Tournament - Foregone Destruction.mp3")
	Ui.create_dialog("Here we go. Let's save [b]my ohio hometown 2.[b]", "spongebob")
	await Ui.dialog_finished
	Ui.create_dialog("HOW TO GET 2 MILLION DOLLARS USING THIS SIMPLE GUIDE  
		  -LIKE THE VIDEO 
		  -SUBSCRIBE  
		  -HIT THAT BELL   
		  -SHARE THE VIDEO  
		  -CLICK THE LINK BELOW " , "sandy+")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
