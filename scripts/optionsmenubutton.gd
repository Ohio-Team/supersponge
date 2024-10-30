extends Button

var config = ConfigFile.new()

# Load data from a file.
var err = config.load("user://settings.cfg")

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
		
func get_keycode(action_name:String):
	var action_events = InputMap.action_get_events(action_name)
	var action_event = action_events[0]
	return action_event

	
func save_settings():
	config.set_value("audio","Music",$"../TabContainer/Audio/MarginContainer/ScrollContainer/VBoxContainer/Music".value)
	config.set_value("audio","Master",$"../TabContainer/Audio/MarginContainer/ScrollContainer/VBoxContainer/Master".value)
	config.set_value("audio","SFX",$"../TabContainer/Audio/MarginContainer/ScrollContainer/VBoxContainer/SFX".value)
	config.set_value("misc","showfps",$"../TabContainer/Misc/MarginContainer/ScrollContainer/BoxContainer/Fpsbutton".button_pressed)
	config.set_value("misc","showspeedrun",$"../TabContainer/Misc/MarginContainer/ScrollContainer/BoxContainer/Speedrunbutton".button_pressed)
	config.set_value("misc","mouse_sensitivity",$"../TabContainer/Misc/MarginContainer/ScrollContainer/BoxContainer/MouseSensitivity".value)
	config.set_value("video","fullscreen",$"../TabContainer/Video/MarginContainer/BoxContainer/Fullscreen".button_pressed)
	config.set_value("controls","right",get_keycode("right"))
	config.set_value("controls","left",get_keycode("left"))
	config.set_value("controls","front",get_keycode("front"))
	config.set_value("controls","back",get_keycode("back"))
	config.set_value("controls","attack",get_keycode("attack"))
	config.set_value("controls","jump",get_keycode("jump"))
	config.set_value("controls","groundpound",get_keycode("groundpound"))
	config.save("user://settings.cfg")
	Singleton.mouse_sensitivity = $"../TabContainer/Misc/MarginContainer/ScrollContainer/BoxContainer/MouseSensitivity".value
	Singleton.load_settings()


func _on_mouse_entered() -> void:
	BMOD.play_sfx(preload("res://assets/sfx/menumove.tres"))
