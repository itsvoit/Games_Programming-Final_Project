class_name Hurtbox
extends Area2D


func _init() -> void:
	collision_layer = 0
	collision_mask = 2

func _ready() -> void:
	connect("area_entered", _on_area_entered)

func _on_area_entered(hitbox: Hitbox):
	print("Hitbox=" + str(hitbox))
	if hitbox == null:
		return
	
	print("Hit by a Hitbox")
	if owner.has_method("take_damage"):
		owner.take_damage(hitbox.damage)

