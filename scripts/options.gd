extends Control

var config = ConfigFile.new()
var err = config.load("user://settings.cfg")

# Called when the node enters the scene tree for the first time.
func _ready():
	Singleton.inmenu = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	MusicPlayer.play_song("res://assets/music/options.ogg")
	load_settings()
	$TabContainer/Audio.grab_focus()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func load_settings():
	if err != OK:
		return
	$TabContainer/Misc/MarginContainer/ScrollContainer/BoxContainer/Fpsbutton.button_pressed = config.get_value("misc","showfps")
	$TabContainer/Misc/MarginContainer/ScrollContainer/BoxContainer/Speedrunbutton.button_pressed = config.get_value("misc","showfps")
	$TabContainer/Audio/MarginContainer/ScrollContainer/VBoxContainer/Master.value = config.get_value("audio","Master")
	$TabContainer/Audio/MarginContainer/ScrollContainer/VBoxContainer/Music.value = config.get_value("audio","Music")
	$TabContainer/Audio/MarginContainer/ScrollContainer/VBoxContainer/SFX.value = config.get_value("audio","SFX")
	$TabContainer/Misc/MarginContainer/ScrollContainer/BoxContainer/MouseSensitivity.value = config.get_value("misc","mouse_sensitivity")
	$TabContainer/Video/MarginContainer/BoxContainer/Fullscreen.button_pressed =config.get_value("video","fullscreen")

func _on_tab_container_tab_changed(tab: int) -> void:
	BMOD.play_sfx(preload("res://assets/sfx/funnybuttons/buttons.tres"))


func _on_tab_container_tab_hovered(tab: int) -> void:
	BMOD.play_sfx(preload("res://assets/sfx/menumove.tres"))
