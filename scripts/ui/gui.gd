extends Control

@onready var health_bar = $TextureProgressBar

@export var max_health = 100:
	set(value):
		max_health = max(0, value)

@export var health = max_health:
	set(value):
		health = clamp(value, 0, max_health)

func change_health(value: float) -> void:
	health += value
	_update_gui()
	
func _update_gui():
	_update_health_bar()

func _update_health_bar():
	health_bar.value = health
