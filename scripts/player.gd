class_name Player
extends CharacterBody2D

@onready var animated_sprite = $AnimatedSprite2D
@onready var animation_player = $AnimationPlayer
@onready var hitbox = $Hitbox/CollisionShape2D
@onready var health = $Health

const SPEED = 200.0
const ATTACK_SPEED_DEBUFF = 150.0
const JUMP_VELOCITY = -400.0
const DASH_STRENGTH = 2000

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var current_speed = 0
var is_attacking = false


func _ready():
	health.connect("taken_damage", _taken_damage)
	health.connect("entitiy_died", _die)


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	# Get the input direction and handle the movement/deceleration
	var direction = Input.get_axis("move_left", "move_right")
	if direction and is_attacking:
		current_speed = move_toward(current_speed, direction * (SPEED - ATTACK_SPEED_DEBUFF), 20)
	elif direction:
		current_speed = move_toward(current_speed, direction * SPEED, 20)
	else:
		current_speed = move_toward(current_speed, 0, 10)
		
	velocity.x = current_speed
	
	# Hitbox orientation
	if direction > 0 and hitbox.position.x < 0 or direction < 0 and hitbox.position.x > 0:
		hitbox.position.x *= -1
		
	# dash
	if Input.is_action_just_pressed("dash"):
		velocity.x = direction * DASH_STRENGTH
		
	
	if Input.is_action_just_pressed("light_attack"):
		is_attacking = true
		animation_player.play("light_attack")
	
	if not is_attacking:
		if direction < 0:
			animated_sprite.flip_h = true
		elif direction > 0:
			animated_sprite.flip_h = false
			
		if is_on_floor():
			if direction != 0:
				animated_sprite.play("run")
			else:
				animated_sprite.play("idle")
		else:
			animated_sprite.play("jump")
	
	move_and_slide()

func take_damage(value: float):
	health.take_damage(value)

func attack_anim_finished():
	is_attacking = false

func _taken_damage():
	pass
	
func _die():
	pass
