extends Button

func _on_pressed() -> void:
	Singleton.inmenu = false
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
		"Music": $"../Music".value,
		"SFX": $"../SFX".value,
		"Master": $"../Master".value,
		"showfps": $"../CheckButton".button_pressed
	}
	return dict
	
func save_settings():
	var save_file = FileAccess.open("user://settings.save",FileAccess.WRITE)
	var game_data = settings()
	
	var json = JSON.stringify(game_data)
	save_file.store_line(json)
	print("settings saved")
