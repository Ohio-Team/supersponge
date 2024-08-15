extends State

@onready var fakebob:CharacterBody2D = get_parent().get_parent()
@onready var player:CharacterBody2D = get_tree().get_first_node_in_group("Player")
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func Enter():
	BMOD.play_sfx(preload("res://assets/sfx/death.tres"))
	$"../../AnimatedSprite2D".play("attack")
	
func Exit():
	for i in range(5):
		generate_limbs()
	make_spongebots()
	
func Physics_Update(delta):
	if not fakebob.is_on_floor():
		fakebob.velocity.y += gravity * delta

func Update(delta):
	await $"../../AnimatedSprite2D".animation_finished
	Transitioned.emit(self, "Idle")
	
func generate_limbs():
	var limb := preload("res://scenes/2d/limbs.tscn")
	var dir = player.global_position - fakebob.global_position
	var new_node = limb.instantiate()
	new_node.position = fakebob.position + Vector2(randi_range(20, 30),randi_range(20, 30))
	new_node.rotation = dir.angle()
	get_tree().root.add_child(new_node)

func make_spongebots():
	var spongebot := preload("res://scenes/2d/spongebot.tscn")
	var new_node = spongebot.instantiate()
	new_node.position = fakebob.position + Vector2(randi_range(50, 60),randi_range(50, 60))
	fakebob.get_parent().add_child(new_node)
