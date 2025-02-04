extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	DiscordRPC.app_id = 1178087314182897784 # Application ID
	DiscordRPC.details = "Level Select"
	DiscordRPC.state = "Just started"
	DiscordRPC.large_image = "bigimage"
	DiscordRPC.refresh()
	Singleton.inmenu = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	MusicPlayer.play_song("res://assets/music/sb-title.ogg")
	$BoxContainer/VBoxContainer/Menu_Button.grab_focus()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_tree_exiting() -> void:
	Singleton.inmenu = false
	if not FileAccess.file_exists("user://tom.save"):
		OS.alert("Looks like you don't have a save file","Ohio Alert")
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
		Singleton.health = data["health"]
		Singleton.spatulas = data["spatulas"]
		Ui.time = data["time"]
		Singleton.gamebeaten = data["gamebeaten"]
		Singleton.tokens = data["tokens"]
		Singleton.deaths = data["deaths"]


func _on_menu_button_17_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/Main Menu.tscn")
