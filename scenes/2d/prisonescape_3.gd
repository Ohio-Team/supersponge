extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Singleton.save_game()
	DiscordRPC.details = "Escaping Prison"
	DiscordRPC.refresh()
	$Spongebob.camerashake = true
	Ui.create_dialog("The building is gonna explode in 25 seconds Spongebob!!!","sandy")
	MusicPlayer.play_song("res://assets/music/escape.ogg")

func _process(delta: float) -> void:
	$Control/Timer.text = "[center]TIME LEFT: " + str(round($Timer.time_left))

func change():
	get_tree().change_scene_to_file("res://scenes/2d/prisonescape.tscn")


func cannonsfx():
	BMOD.play_sfx(preload("res://assets/sfx/cannonenter.tres"))
	BMOD.play_sfx(preload("res://assets/sfx/cannonready.tres"))
	await Singleton.wait(1)
	BMOD.play_sfx(preload("res://assets/sfx/cannonblast.tres"))
	


func _on_timer_timeout() -> void:
	for i in range(30):
		Input.start_joy_vibration(0,0.5,0.5,1)
		BMOD.play_sfx(preload("res://assets/sfx/patscream.tres"))
		Singleton.do_explosion(Vector2(0,0))
	get_tree().reload_current_scene()
