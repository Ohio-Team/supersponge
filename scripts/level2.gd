extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	DiscordRPC.details = "In the Ohio Sewers"
	DiscordRPC.refresh()
	Singleton.save_game()
	MusicPlayer.play_song("res://assets/music/sewers.ogg")
	Ui._clear_dialog()
	Ui.create_dialog("where the [b]ohio[/b] am i","spongebob")
	Singleton.hasgun = true



func _on_timer_timeout() -> void:
	var amount = randi_range(3,5)
	for i in range(amount):
		var pos = Vector2(randf_range(3553,4036),278)
		var pi = preload("res://scenes/2d/pipe.tscn")
		var pipe = pi.instantiate()
		pipe.position = pos
		add_child(pipe)
