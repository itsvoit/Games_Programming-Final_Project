class_name Hurtbox
extends Area2D


func _init() -> void:
	collision_layer = 0
	collision_mask = 2

func _ready() -> void:
	connect("area_entered", _on_area_entered)

func _on_area_entered(hitbox: Hitbox):
	if hitbox == null or hitbox.owner == owner:
		return
	
	print("Hit by a Hitbox of=" + str(hitbox.owner))
	print("Owner=" + str(owner))
	if owner.has_method("take_damage"):
		print("Owner has method take damage")
		owner.take_damage(hitbox.damage)

