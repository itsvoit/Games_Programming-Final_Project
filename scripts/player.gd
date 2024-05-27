extends CharacterBody2D


@onready var animated_sprite = $AnimatedSprite2D

const SPEED = 200.0
const JUMP_VELOCITY = -300.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var current_speed = 0

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction > 0:
		if current_speed < SPEED:
			current_speed += 20
		velocity.x = current_speed
	elif direction < 0:
		if current_speed > -SPEED:
			current_speed -= 20
		velocity.x = current_speed
	else:
		current_speed = move_toward(current_speed, 0, 10)
		velocity.x = current_speed
	
    # dash
	if Input.is_action_just_pressed("ui_down"):
		velocity.x = direction * 1000
		
	
	if is_on_floor():
		
		if direction < 0:
			animated_sprite.flip_h = true
			animated_sprite.play("run")
		elif direction > 0:
			animated_sprite.flip_h = false
			animated_sprite.play("run")
		else:
			animated_sprite.play("idle")
	else:
		animated_sprite.play("jump")
	

	move_and_slide()
