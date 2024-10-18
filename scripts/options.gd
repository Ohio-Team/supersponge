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
		$TabContainer/Misc/MarginContainer/ScrollContainer/BoxContainer/Fpsbutton.button_pressed = data["showfps"]
		$TabContainer/Misc/MarginContainer/ScrollContainer/BoxContainer/Speedrunbutton.button_pressed = data["showspeedrun"]
		$TabContainer/Audio/MarginContainer/ScrollContainer/VBoxContainer/Master.value = data["Master"]
		$TabContainer/Audio/MarginContainer/ScrollContainer/VBoxContainer/Music.value = data["Music"]
		$TabContainer/Audio/MarginContainer/ScrollContainer/VBoxContainer/SFX.value = data["SFX"]
		$TabContainer/Misc/MarginContainer/ScrollContainer/BoxContainer/MouseSensitivity.value = data["mouse_sensitivity"]
		


func _on_tab_container_tab_changed(tab: int) -> void:
	BMOD.play_sfx(preload("res://assets/sfx/funnybuttons/buttons.tres"))
