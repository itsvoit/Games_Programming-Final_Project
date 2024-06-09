class_name Hurtbox
extends Area2D

@export var mask_for_collision = 2

func _init() -> void:
	collision_layer = 0
	collision_mask = mask_for_collision

func _ready() -> void:
	connect("area_entered", _on_area_entered)

func _on_area_entered(hitbox: Hitbox):
	if hitbox == null or hitbox.owner == owner:
		return
	
	if owner.has_method("take_damage"):
		print(str(owner) + " hit by " + str(hitbox.owner) + " for " + str(hitbox.damage))
		owner.take_damage(hitbox.damage)

