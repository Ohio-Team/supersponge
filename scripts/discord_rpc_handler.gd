extends Node

func _ready():
	DiscordRPC.app_id = 1178087314182897784 # Application ID
	DiscordRPC.large_image = "bigimage"
	DiscordRPC.refresh()
func _on_timer_timeout() -> void:
	if get_tree().current_scene != preload("res://scenes/Main Menu.tscn") or get_tree().current_scene != preload("res://scenes/2d/tutorial.tscn"):
		DiscordRPC.state = "Spatulas: " + str(Singleton.spatulas)
		DiscordRPC.refresh()
