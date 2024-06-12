extends Control

@export var full_text = "i love grimace shake"
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$ColorRect/RichTextLabel.full_text = full_text
	if $ColorRect/RichTextLabel.finishedtext == true:
		await Singleton.wait(5)
		queue_free()
