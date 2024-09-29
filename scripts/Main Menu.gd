extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	DiscordRPC.app_id = 1178087314182897784 # Application ID
	DiscordRPC.details = "In The Menus"
	DiscordRPC.state = "About to get ohio mode"
	DiscordRPC.large_image = "bigimage"
	#DiscordRPC.large_image_text = "Try it now!"
	#DiscordRPC.small_image = "boss" # Image key from "Art Assets"
	#DiscordRPC.small_image_text = "Fighting the end boss! D:"

	DiscordRPC.start_timestamp = int(Time.get_unix_time_from_system()) # "02:46 elapsed"
	DiscordRPC.refresh() # Always refresh after changing the values!
	
	Singleton.inmenu = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	MusicPlayer.stop_song()
	MusicPlayer.play_song("res://assets/music/sb-title.mp3")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
