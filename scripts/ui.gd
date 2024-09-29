
extends CanvasLayer

signal dialog_finished

@onready var joystick := $Android/joystick
# Called when the node enters the scene tree for the first time.
func _ready():
	$Pause.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Singleton.inmenu:
		visible = false
	else:
		visible = true
		
	$Counter.text = "[shake]x" + str(Singleton.health)
	$Counter2.text = "[shake]x" + str(Singleton.spatulas)
	if Singleton.showfuel:
		$FuelCounter.visible = true
		$FuelCounter.text = "[shake]Fuel: " + str(round(Singleton.fuel))
	else:
		$FuelCounter.visible = false
	if Singleton.showfps:
		$FPS.text = str(Engine.get_frames_per_second())
		$FPS.visible = true
	else:
		$FPS.visible = false
	if Input.is_action_just_pressed("ui_cancel"):
		_clear_dialog()
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		get_tree().paused = true
		$Pause.visible = true
	if get_tree().paused:
		$Pause/ColorRect.color = lerp($Pause/ColorRect.color, Color(00000078,0.5), delta*10)
		$Pause/Patricio.position = lerp($Pause/Patricio.position, Vector2(356,317), delta*10)
		$Pause/Exponja.position = lerp($Pause/Exponja.position, Vector2(919,446), delta*10)
	else:
		$Pause/ColorRect.color = lerp($Pause/ColorRect.color, Color(00000000,0), delta*10)
		$Pause/Patricio.position = lerp($Pause/Patricio.position, Vector2(-106,317), delta*10)
		$Pause/Exponja.position = lerp($Pause/Exponja.position, Vector2(1500,446), delta*10)
func emit_dialogfinished():
	dialog_finished.emit()
func create_dialog(text:String, char:String = "spongebob"):
	var dialog = preload("res://scenes/2d/dialog.tscn")
	var new_dialog = dialog.instantiate()
	new_dialog.full_text = text
	new_dialog.char = char
	new_dialog.finished_dialog.connect(emit_dialogfinished)
	add_child(new_dialog)
	move_child(new_dialog,6)
	
func _clear_dialog():
	if get_node_or_null("Dialog"):
		get_node_or_null("Dialog").queue_free()
	else:
		pass
