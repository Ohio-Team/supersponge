extends Area2D
@onready var player = get_tree().get_first_node_in_group("Player")
@export var image:Texture
@export var id:String
@export var goto:PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Texture.texture = image
	if Singleton.tokens.has(id):
		queue_free()
	
func _on_body_entered(body):
	if body == player:
		print("token collected")
		BMOD.play_sfx(preload("res://assets/sfx/token.tres"))
		Singleton.tokens.append(id)
		Singleton.save_game()
		teleport()
		queue_free()
		
func teleport():
	if goto:
		get_tree().change_scene_to_packed(goto)


@export var frequency: int = 6: 
	set(float): 1000
@export var amplitude: int = 50: 
	set(float): 1 
var time = 0

func _physics_process(delta: float) -> void:
	time += delta
	var movement = cos(time*frequency)*amplitude
	position.y+=movement * delta
	
	
