extends Node

@export var hasgun:bool = false
@export var showfuel:bool = false
@export var fuel:float = 100.0
@export var inmenu:bool = false
@export var showfps:bool = false
@export var showspeedrun:bool = false
@export var fullscreen:bool = false
@export var lifes:int = 4
@export var health:int = 3
@export var mouse_sensitivity:float = 1
@export var spatulas:int = 0
@export var acceptinput:bool = true

var config = ConfigFile.new()
var err = config.load("user://settings.cfg")

# Called when the node enters the scene tree for the first time.
func _ready():
	load_settings()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func create(node:PackedScene):
	var new_node = node.instantiate()
	add_child(new_node)

func do_explosion(pos:Vector2):
	var node = preload("res://scenes/2d/explosion.tscn")
	var new_node = node.instantiate()
	new_node.position = pos
	get_tree().root.add_child(new_node)

func wait(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout

func save_elements():
	var save_dict = {
		"current_scene" : get_tree().current_scene.scene_file_path,
		"lifes" : lifes,
		"spatulas" : spatulas,
		"health" : health,
		"time" : Ui.time
	}
	return save_dict
func save_game():
	var save_file = FileAccess.open("user://tom.save",FileAccess.WRITE)
	var game_data = save_elements()
	
	var json = JSON.stringify(game_data)
	save_file.store_line(json)
	print("game saved")
func load_game():
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
		health = data["health"]
		spatulas = data["spatulas"]
		lifes = data["lifes"]
		Ui.time = data["time"]
		get_tree().change_scene_to_file(data["current_scene"])
func load_settings():
	if err != OK:
		return
	AudioServer.set_bus_volume_db(0,linear_to_db(config.get_value("audio","Master")))
	AudioServer.set_bus_volume_db(1,linear_to_db(config.get_value("audio","Music")))
	AudioServer.set_bus_volume_db(2,linear_to_db(config.get_value("audio","SFX")))
	InputMap.action_erase_event("right",InputEventKey.new())
	InputMap.action_add_event("right",config.get_value("controls","right"))
	InputMap.action_erase_event("left",InputEventKey.new())
	InputMap.action_add_event("left",config.get_value("controls","left"))
	InputMap.action_erase_event("back",InputEventKey.new())
	InputMap.action_add_event("back",config.get_value("controls","back"))
	InputMap.action_erase_event("front",InputEventKey.new())
	InputMap.action_add_event("front",config.get_value("controls","front"))
	InputMap.action_erase_event("attack",InputEventKey.new())
	InputMap.action_add_event("attack",config.get_value("controls","attack"))
	InputMap.action_erase_event("groundpound",InputEventKey.new())
	InputMap.action_add_event("groundpound",config.get_value("controls","groundpound"))
	showfps = config.get_value("misc","showfps")
	showspeedrun = config.get_value("misc","showspeedrun")
	mouse_sensitivity = config.get_value("misc","mouse_sensitivity")
	fullscreen = config.get_value("video","fullscreen")
