class_name Health
extends Node2D

# Exposed signals
signal taken_damage(value)
signal healed(value)
signal entity_died()

# Exported variables
@export var max_health: float = 100:
	set(value):
		max_health = max(0, value)

@export var health: float = max_health:
	set(value):
		health = clamp(value, 0, max_health)

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
	print(str(owner) + " taken " + str(value) + " damage")
	if health == 0:
		emit_signal("entity_died")
		print(str(owner) + " died")
	return true

# heal	
func heal(value):
	if value < 0:
		return false
	health += value
	emit_signal("healed", value)
	return true
	
