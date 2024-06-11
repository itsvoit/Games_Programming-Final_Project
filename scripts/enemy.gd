extends CharacterBody2D

@onready var health = $Health
@onready var animated_sprite = $AnimatedSprite2D
@onready var animation_player = $AnimationPlayer
@onready var follow_range = $FollowArea
@onready var attack_range = $AttackRange
@onready var hitbox = $Hitbox
@onready var hurtbox = $Hurtbox

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var is_dead = false
var is_taking_damage = false
var is_following_player = false
var player_to_follow: Player = null
var in_attack_range = false

var direction: int = 1
var last_patrol_direction: int = 1
var current_speed: float = 0
var last_attack: float = -1000000


@export var attack_cooldown: float = 1
@export var speed = 150
@export var speed_variance = 50

var directions := [-1, 1]
enum State {
	IDLE,
	PATROL,
	FOLLOW,
	ATTACK,
	HURT,
	DEAD
}

var current_state = State.IDLE

const debug: bool = false

func _ready():
	health.connect("entity_died", _on_health_entity_died)
	health.connect("taken_damage", _on_health_taken_damage)
	follow_range.connect("body_entered", _start_follow_player)
	follow_range.connect("body_exited", _stop_follow_player)
	follow_range.set_collision_mask_value(4, 1)
	attack_range.connect("body_entered", _in_attack_range)
	attack_range.connect("body_exited", _not_in_attack_range)
	attack_range.set_collision_mask_value(4, 1)
	
	collision_mask = 1
	hurtbox.set_collision_mask_value(5, 1)
	hurtbox.set_collision_mask_value(2, 0)
	hitbox.set_collision_layer_value(2, 1)
	speed = speed + (get_rand_direction() * randi_range(0, speed_variance))


func get_rand_direction() -> int:
	return directions[randi() % directions.size()]


func physics_move(delta):
	velocity.y += gravity * delta
	animated_sprite.flip_h = direction < 0 if direction != 0 else not bool(direction)
	# play the animation
	animated_sprite.play("run")
	# apply movement
	current_speed = speed * direction
	velocity.x = current_speed
	
	move_and_slide()

func move(delta):
	# play the animation
	animated_sprite.play("run")
	# apply movement
	current_speed = speed * direction * delta
	velocity.x = current_speed
	
	move_and_slide()

func state_idle():
	animated_sprite.play("idle")
	if is_following_player and in_attack_range and not _can_attack():
		return
	direction = last_patrol_direction
	current_state = State.PATROL

func state_patrol(delta: float):
	last_patrol_direction = direction
	if is_following_player:
		# found player, follow him
		current_state = State.FOLLOW
	else:
		# bounce back from walls
		if is_on_wall():
			direction *= -1
		physics_move(delta)

func state_follow(delta: float):
	if in_attack_range:
		# try to attack
		current_state = State.ATTACK
	elif not is_following_player:
		# lost player, start patroling
		current_state = State.PATROL
		direction = get_rand_direction()
	else:
		if direction > 0 and hitbox.position.x < 0 or direction < 0 and hitbox.position.x > 0:
			hitbox.position.x *= -1
			attack_range.position.x *= -1
		# play run animation
		animated_sprite.play("run")
		# follow (track) the player and try to get close
		var diff = player_to_follow.position.x - position.x
		if diff > 0.0001:
			direction = 1
		elif diff < 0.0001:
			direction = -1
		physics_move(delta)

func state_attack():
	# attack animation cannot be stopped
	if not animation_player.is_playing():
		if not in_attack_range:
			# player got out of range, try to follow
			current_state = State.FOLLOW
		else:
			if direction > 0 and hitbox.position.x < 0 or direction < 0 and hitbox.position.x > 0:
				hitbox.position.x *= -1
				attack_range.position.x *= -1
				print("cahnge sprites position...")
			if _can_attack():
				print("attacking...")
				animation_player.play("attack")
				last_attack = Time.get_ticks_msec()
			else:
				current_state = State.IDLE

func state_hurt():
	if not is_taking_damage:
		is_taking_damage = true
		animated_sprite.play("hurt")
		print(str(owner) + " HURT")
	elif not animated_sprite.is_playing():
		is_taking_damage = false
		current_state = State.IDLE

func state_dead():
	if not is_dead:
		is_dead = true
		animation_player.play("death")

# movement and logic
func _physics_process(delta):
	match current_state:
		State.IDLE:
			if debug:
				print("State IDLE")
			state_idle()
		State.PATROL:
			if debug:
				print("State PATROL, direction=" + str(direction) + ", speed=" + str(velocity.x))
			state_patrol(delta)
		State.FOLLOW:
			if debug:
				print("State FOLLOW")
			state_follow(delta)
		State.ATTACK:
			if debug:
				print("State ATTACK")
			state_attack()
		State.HURT:
			if debug:
				print("State HURT")
			state_hurt()
		State.DEAD:
			if debug:
				print("State DEAD")
			state_dead()


# damage functions and callback
func take_damage(value):
	health.take_damage(value)

func _on_health_entity_died():
	current_state = State.DEAD

func _on_health_taken_damage(_value):
	current_state = State.HURT

func _can_attack() -> bool:
	return last_attack + (attack_cooldown*1000) <= Time.get_ticks_msec()

# ai signal callbacks
func _start_follow_player(player: Player):
	if player == null:
		return
	is_following_player = true
	player_to_follow = player
	if debug:
		print("following player")

func _stop_follow_player(player: Player):
	if player == null or not is_following_player:
		return
	is_following_player = false
	player_to_follow = null
	if debug:
		print("stop following player")

func _in_attack_range(player: Player):
	if player == null:
		return
	if debug:
		print("In attack range")
	in_attack_range = true

func _not_in_attack_range(player: Player):
	if player == null:
		return
	if debug:
		print("Out of attack range")
	in_attack_range = false


