extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Singleton.save_game()
	Singleton.showfuel = true
	Singleton.fuel = 100.0
	Ui.create_dialog("Okay. Let's drive there. [shake]I GREW UP FOR THIS!")
	MusicPlayer.play_song("res://assets/music/driving.mp3")


func _on_area_3d_body_entered(body: Node3D) -> void:
	get_tree().change_scene_to_file("res://scenes/3d/gasstation.tscn")
