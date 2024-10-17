extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	DiscordRPC.details = "???"
	DiscordRPC.refresh()
	MusicPlayer.play_song("res://assets/music/decision.ogg")
