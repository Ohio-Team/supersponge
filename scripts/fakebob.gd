extends CharacterBody2D
@export var health:int = 5

func create_dialog(text: String, character: String):
	Ui.create_dialog(text,character)
