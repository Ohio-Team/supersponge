extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	DiscordRPC.app_id = 182897784 # Application ID
	DiscordRPC.details = "In The Menus"
	DiscordRPC.state = "Just started"
	DiscordRPC.large_image = "bigimage"
	DiscordRPC.start_timestamp = int(Time.get_unix_time_from_system())
	DiscordRPC.refresh()
	
	Singleton.inmenu = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	MusicPlayer.stop_song()
	MusicPlayer.play_song("res://assets/music/sb-title.mp3")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
