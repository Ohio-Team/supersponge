extends RigidBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
@export var direction:Vector2

func _ready():
	$Bullet.flip_h = direction.x
	BMOD.play_sfx(preload("res://assets/sfx/shoot.tres"))


func _physics_process(delta):
	apply_force(Vector2(1000 * direction.x, 0))


func _on_timer_timeout():
	queue_free()
