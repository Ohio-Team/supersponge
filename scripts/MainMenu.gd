extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$Buttons.modulate = Color(1, 1, 1, 0)
	$Buttons.hide()
	Singleton.inmenu = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	MusicPlayer.stop_song()
	MusicPlayer.play_song("res://assets/music/sb-title.mp3")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_anything_pressed() and !$Buttons.visible:
		BMOD.play_sfx(preload("res://assets/sfx/funnybuttons/buttons.tres"))
		$RichTextLabel2.hide()
		$Buttons.show()
	if $Buttons.visible:
		$Buttons.modulate = lerp($Buttons.modulate,Color(1, 1, 1),delta * 10)
