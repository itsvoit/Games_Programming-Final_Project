extends Node

signal nextLevel


var controller: SceneController
@export var end_level: Area2D
@onready var soundtrack = $AudioStreamPlayer2D

func _ready():
	GameController.updateGUi()
	if end_level == null:
		return
	var soundtrack = $AudioStreamPlayer2D
	soundtrack.play()
	end_level.connect("body_entered", _next_level)
	GameController.playerChangeJumpVelocity(-300)

func init(sceneController: SceneController):
	controller = sceneController

func _next_level(body):
	nextLevel.emit()
	
