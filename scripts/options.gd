extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	Singleton.inmenu = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	MusicPlayer.play_song("res://assets/music/options.ogg")
	load_settings()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func load_settings():
	if not FileAccess.file_exists("user://settings.save"):
		return
		
	var save_file = FileAccess.open("user://settings.save", FileAccess.READ)
	while save_file.get_position() < save_file.get_length():
		var json_string = save_file.get_line()
		var json = JSON.new()
		var parse_result = json.parse(json_string)
		if not parse_result == OK:
			print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
			continue
		
		var data = json.get_data()
		$CheckButton.button_pressed = data["showfps"]
		$Master.value = data["Master"]
		$Music.value = data["Music"]
		$SFX.value = data["SFX"]
