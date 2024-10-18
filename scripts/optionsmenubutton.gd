extends Button

func _on_pressed() -> void:
	Singleton.inmenu = false
	BMOD.play_sfx(preload("res://assets/sfx/funnybuttons/buttons.tres"))
	var save_file = FileAccess.open("user://tom.save", FileAccess.READ)
	if not FileAccess.file_exists("user://tom.save"):
		get_tree().change_scene_to_file("res://scenes/Main Menu.tscn")
		return
	while save_file.get_position() < save_file.get_length():
		var json_string = save_file.get_line()
		var json = JSON.new()
		var parse_result = json.parse(json_string)
		if not parse_result == OK:
			print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
			continue
		
		var data = json.get_data()
		save_settings()
		get_tree().change_scene_to_file(data["current_scene"])
		
func settings():
	var dict = {
		"Music": $"../TabContainer/Audio/MarginContainer/ScrollContainer/VBoxContainer/Music".value,
		"SFX": $"../TabContainer/Audio/MarginContainer/ScrollContainer/VBoxContainer/SFX".value,
		"Master": $"../TabContainer/Audio/MarginContainer/ScrollContainer/VBoxContainer/Master".value,
		"showfps": $"../TabContainer/Misc/MarginContainer/ScrollContainer/BoxContainer/Fpsbutton".button_pressed,
		"showspeedrun": $"../TabContainer/Misc/MarginContainer/ScrollContainer/BoxContainer/Speedrunbutton".button_pressed,
		"mouse_sensitivity": $"../TabContainer/Misc/MarginContainer/ScrollContainer/BoxContainer/MouseSensitivity".value
	}
	return dict
	
func save_settings():
	var save_file = FileAccess.open("user://settings.save",FileAccess.WRITE)
	var game_data = settings()
	
	var json = JSON.stringify(game_data)
	save_file.store_line(json)
	Singleton.load_settings()
	print("settings saved")
