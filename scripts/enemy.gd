extends Node2D

@onready var health = $Health


func take_damage(value):
	health.take_damage(value)
