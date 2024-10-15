class_name Rebind
extends Control

@onready var label: Label = $HBoxContainer/Label as Label
@onready var button: Button = $HBoxContainer/Button as Button

@export var action_name : String = ""

func _ready():
	set_process_unhandled_key_input(false)
	set_action_name()
	set_text_for_key()
func set_action_name():
	label.text = action_name
	match action_name:
		"left": label.text = "Left"
		"right": label.text = "Right"
		"front": label.text = "Forwards"
		"back": label.text = "Backwards"
		"attack": label.text = "Attack"
		"jump": label.text = "Jump"
		"groundpound": label.text = "Groundpound"

func set_text_for_key() -> void:
	var action_events = InputMap.action_get_events(action_name)
	var action_event = action_events[0]
	var action_keycode = OS.get_keycode_string(action_event.physical_keycode)
	button.text = "%s" % action_keycode

func _on_button_toggled(button_pressed) -> void:
	if button_pressed:
		button.text = "Press any key boy"
		set_process_unhandled_key_input(button_pressed)
		for i in get_tree().get_nodes_in_group("rebind_button"):
			if i.action_name != self.action_name:
				i.button.toggle_mode = false
				i.set_process_unhandled_key_input(false)
	else:
		for i in get_tree().get_nodes_in_group("rebind_button"):
			if i.action_name != self.action_name:
				i.button.toggle_mode = true
				i.set_process_unhandled_key_input(false)
		set_text_for_key()

func _unhandled_key_input(event: InputEvent) -> void:
	rebind_action_key(event)
	button.button_pressed = false
	
func rebind_action_key(event):
	InputMap.action_erase_events(action_name)
	InputMap.action_add_event(action_name,event)
	
	set_process_unhandled_key_input(false)
	set_text_for_key()
	set_action_name()
