extends Node

# global events
signal updateUi
signal playerTakeDamage(value)
signal playerHeal(value)
signal playerDie

@onready var player_health = $PlayerHealth

func _ready():
	player_health.connect("entity_died", _player_died)
	player_health.connect("taken_damage", _player_took_damage)

# public functions

# deal damage or heal
func playerChangeHealth(value: float) -> void:
	if value < 0:
		playerTakeDamage.emit(value)
		player_health.take_damage(-value)
	elif value > 0:
		playerHeal.emit(value)
		player_health.heal(value)
	updateUi.emit()

func playerGetHealth() -> Health:
	return player_health

# private functions

func _foo():
	pass

# callbacks

func _player_died():
	playerDie.emit()

func _player_took_damage(value):
	pass
