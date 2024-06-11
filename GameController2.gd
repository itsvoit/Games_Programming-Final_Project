extends Node

# global events
signal updateUi
signal player2TakeDamage(value)
signal player2Heal(value)
signal player2Die

@onready var player2_health = $Health2


func _ready():
	player2_health.connect("entity_died", _player2_died)
	player2_health.connect("taken_damage", _player2_took_damage)

# public functions

# deal damage or heal
func player2ChangeHealth(value: float) -> void:
	if value < 0:
		player2TakeDamage.emit(value)
		player2_health.take_damage(-value)
	elif value > 0:
		player2Heal.emit(value)
		player2_health.heal(value)
	updateUi.emit()

func player2GetHealth() -> Health:
	return player2_health

# private functions

func _foo():
	pass

# callbacks
	
func _player2_died():
	player2Die.emit()

func _player2_took_damage(value):
	pass
