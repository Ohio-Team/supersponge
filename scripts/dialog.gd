extends CanvasLayer

@export var full_text = "i love grimace shake"
@export var char:String = "spongebob"
signal finished_dialog
# Called when the node enters the scene tree for the first time.
func _ready():
	if char == "spongebob":
		$ColorRect/Maxresdefault.texture = preload("res://assets/2d/dialogfaces/Spongebob.png")
	elif char == "fakebob":
		$ColorRect/Maxresdefault.texture = preload("res://assets/2d/dialogfaces/Fakebob.png")
	elif char == "sandy":
		$ColorRect/Maxresdefault.texture = preload("res://assets/2d/dialogfaces/Sandy.png")
	elif char == "kanye":
		$ColorRect/Maxresdefault.texture = preload("res://assets/2d/dialogfaces/kanye.png")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$ColorRect/RichTextLabel.full_text = full_text
	if $ColorRect/RichTextLabel.finishedtext == true:
		await Singleton.wait(3)
		finished_dialog.emit()
		queue_free()
