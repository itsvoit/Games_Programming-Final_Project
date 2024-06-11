extends Node2D

var controller: SceneController
@export var end_level: Area2D

func _ready():
	end_level.connect("body_entered", _next_level)

func init(sceneController: SceneController):
	controller = sceneController

func _next_level(body):
	#controller.nextLevel()
	pass
	
