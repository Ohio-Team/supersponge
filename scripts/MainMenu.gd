extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	DiscordRPC.app_id = 1178087314182897784 # Application ID
	DiscordRPC.details = "In The Menus"
	DiscordRPC.state = "Just started"
	DiscordRPC.large_image = "bigimage"
	DiscordRPC.start_timestamp = int(Time.get_unix_time_from_system())
	DiscordRPC.refresh()
	$Buttons.modulate = Color(1, 1, 1, 0)
	$Buttons.hide()
	Singleton.inmenu = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	MusicPlayer.stop_song()
	MusicPlayer.play_song("res://assets/music/sb-title.mp3")
	loads()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_anything_pressed() and !$Buttons.visible:
		BMOD.play_sfx(preload("res://assets/sfx/funnybuttons/buttons.tres"))
		$RichTextLabel2.hide()
		$Buttons.show()
		$Buttons/Menu_Button3.grab_focus()
	if $Buttons.visible:
		$Buttons.modulate = lerp($Buttons.modulate,Color(1, 1, 1),delta * 10)

func loads():
	if not FileAccess.file_exists("user://tom.save"):
		$Buttons/Menu_Button.disabled = true
		return
	
	var save_file = FileAccess.open("user://tom.save", FileAccess.READ)
	while save_file.get_position() < save_file.get_length():
		var json_string = save_file.get_line()
		var json = JSON.new()
		var parse_result = json.parse(json_string)
		if not parse_result == OK:
			print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
			continue
		
		var data = json.get_data()
		if data["gamebeaten"] == true:
			$Buttons/Menu_Button4.visible = true
			$Buttons/Menu_Button4.disabled = false
