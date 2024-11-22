extends CharacterBody2D


var SPEED = 0
const JUMP_VELOCITY = -400.0

func _ready():
	Ui.create_dialog("Click to gain speed and right click to jump bob. NOW RUN AS FAST AS YOU CAN!","kanye")

func _physics_process(delta: float) -> void:
	$Camera2D.zoom = lerp($Camera2D.zoom,Vector2(1,1),delta * 3)
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := 1
	if $AnimatedSprite2D.animation != "momentum":
		$AnimatedSprite2D.play("idle")
	clamp(SPEED,0,300)
	velocity.x = direction * SPEED
	velocity.x = move_toward(velocity.x, 0, SPEED / 3)

	move_and_slide()
	
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		SPEED += 10
		$AnimatedSprite2D.play("momentum")
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_RIGHT and is_on_floor():
		velocity.y = JUMP_VELOCITY
