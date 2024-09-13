
extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	Singleton.save_game()
	MusicPlayer.play_song("res://assets/music/decision.ogg")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass 


func _on_button_pressed() -> void:
	OS.alert("No brother no")


func _on_button_2_pressed() -> void:
	BMOD.play_sfx(preload("res://assets/sfx/shoot.tres"))
	BMOD.play_sfx(preload("res://assets/sfx/kendrickscream.tres"))
	get_tree().change_scene_to_file("res://scenes/2d/level4intro.tscn")
