class_name Hitbox
extends Area2D

@export var collision_on_layer = 2
@export var damage: float = 5:
	set(value):
		damage = max(0, value)

func _init():
	collision_layer = collision_on_layer

func _debug():
	print("Hitbox - " + str(get_parent()))
