extends Area2D

@export var text:String
@export var Character:String = "spongebob"


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		Ui._clear_dialog()
		Ui.create_dialog(text,Character)
		queue_free()
