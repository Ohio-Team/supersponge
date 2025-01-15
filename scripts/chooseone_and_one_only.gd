
extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	Singleton.save_game()
	MusicPlayer.play_song("res://assets/music/decision.ogg")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if $Fakebobhurt:
		$Fakebobhurt.offset = Vector2(randf_range(-1,1),randf_range(-1,1))


func _on_button_pressed() -> void:
	BMOD.play_sfx(preload("res://assets/sfx/shoot.tres"))
	BMOD.play_sfx(preload("res://assets/sfx/scream.tres"))
	if $Fakebobhurt:
		$Fakebobhurt.queue_free()
	$AnimationPlayer.play("flash")
	$CanvasLayer/Button.disabled = true
	$CanvasLayer/Button2.disabled = true
	$CanvasLayer/Button3.disabled = true
	Ui.create_dialog("You had one chance and you fucked up...","spongebob")
	$ColorRect.show()
	await Singleton.wait(3)
	get_tree().change_scene_to_file("res://scenes/2d/level4intro.tscn")


func _on_button_2_pressed() -> void:
	Ui.create_dialog("It's okay brother we all make mistakes")
	await Singleton.wait(3)
	Ui.create_dialog("Yay","fakebob")
	await Singleton.wait(3)
	get_tree().quit()

func _on_button_3_pressed() -> void:
	OS.alert("Choose something boy")
	$CanvasLayer/Button3.queue_free()
