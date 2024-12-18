extends StaticBody2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func sound_play():
	BMOD.play_sfx(preload("res://assets/sfx/woodbreak.tres"))

func _on_hit_body_entered(body: Node2D) -> void:
	await Singleton.wait(0.5)
	$CollisionShape2D.disabled = true
	$WoodB04.visible = false
	sound_play()
	await Singleton.wait(3)
	$CollisionShape2D.disabled = false
	$WoodB04.visible = true
	
	
