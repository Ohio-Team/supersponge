extends RichTextLabel

# The full text to be displayed
@export var full_text: String = "Hello. I'm Mr. Frog, this is [b]my show[/b], i eat the bug."
var finishedtext:bool = false
var char_interval: float = 0.05
var current_index: int = 0

func _ready():
	clear()
	bbcode_enabled = true
	start_text_update()

func start_text_update():
	set_process(true)

func _process(delta):
	_update_text()

func _update_text():
	if visible_characters < full_text.length():
		visible_characters += 1
		if !$"../../AudioStreamPlayer".playing: 
			$"../../AudioStreamPlayer".play()
	else:
		finishedtext = true
		set_process(false)
