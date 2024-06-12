extends Node

# global events
signal updateUi
signal playerTakeDamage(value)
signal playerHeal(value)
signal playerDie
signal playerChangedJumpVelocity(value)
signal newGame
signal musicValueChanged

@onready var player_health: Health = $PlayerHealth

var lastMusicValue = 15

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

func playerChangeJumpVelocity(newValue: float):
	if newValue > 0:
		newValue *= -1
	
	playerChangedJumpVelocity.emit(newValue)

func resetGame():
	Engine.set_time_scale(1)
	newGame.emit()
	player_health.reset()

func updateGUi():
	updateUi.emit()


func musicOn(isOn: bool):
	var value
	if isOn:
		value = lastMusicValue
	else:
		value = 0
	AudioServer.set_bus_volume_db(0, value)

func changeMusicVolume(value):
	lastMusicValue = value
	AudioServer.set_bus_volume_db(0, linear_to_db(value))

func getMusicValue():
	return lastMusicValue

# private functions

func _foo():
	pass

# callbacks

func _player_died():
	playerDie.emit()

func _player_took_damage(value):
	pass
