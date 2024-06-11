extends Control

@onready var health_bar = $TextureProgressBar

func _ready():
	GameController.connect("updateUi", _update_gui)

	
func _update_gui():
	_update_health_bar()

func _update_health_bar():
	var health: Health = GameController.playerGetHealth()
	health_bar.max_value = health.max_health
	health_bar.value = health.health
	
