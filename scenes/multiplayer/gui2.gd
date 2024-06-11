extends Control

@onready var health_bar = $TextureProgressBar
@onready var health_bar2 = $TextureProgressBar2

func _ready():
	GameController2.connect("updateUi", _update_gui)

	
func _update_gui():
	_update_health_bar()

func _update_health_bar():
	var health: Health = GameController.playerGetHealth()
	health_bar.max_value = health.max_health
	health_bar.value = health.health
	
	var health2: Health = GameController2.player2GetHealth()
	health_bar2.max_value = health2.max_health
	health_bar2.value = health2.health
	
