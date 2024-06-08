extends Node2D

@onready var health = $Health
@onready var animated_sprite = $AnimatedSprite2D
@onready var animation_player = $AnimationPlayer

var is_dead = false

func _ready():
	health.connect("entity_died", _on_health_entity_died)
	health.connect("taken_damage", _on_health_taken_damage)


func _process(delta):
	if not animated_sprite.is_playing() and not is_dead:
		animated_sprite.play("idle")


func take_damage(value):
	health.take_damage(value)


func _on_health_entity_died():
	is_dead = true
	animation_player.play("death")


func _on_health_taken_damage(value):
	animated_sprite.play("hurt")
