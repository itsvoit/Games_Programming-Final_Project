class_name Health
extends Node2D

# Exposed signals
signal taken_damage(value)
signal healed(value)
signal entity_died()

# Exported variables
@export var health: float = 100:
	set(value):
		health = clamp(value, 0, 100)
		
@export var armor: float = 0:
	set(value):
		armor = max(0, value)
		
@export var resistance: float = 0:
	set(value):
		resistance = clamp(value, 0, 1)

# take damage
func take_damage(value):
	if value < 0:
		return false
	health -= (value - armor) * (1 - resistance)
	emit_signal("taken_damage", value)
	print("Entity taken damage: " + str(value))
	if health == 0:
		emit_signal("entity_died")
		print("Entity died")
	return true

# heal	
func heal(value):
	if value < 0:
		return false
	health += value
	emit_signal("healed", value)
	return true
	
