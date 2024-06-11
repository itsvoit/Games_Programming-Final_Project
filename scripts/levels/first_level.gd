extends Node2D

var controller: SceneController
@onready var end_level = $EndLevel

func _ready():
	end_level.connect("body_entered", _next_level)

func init(sceneController: SceneController):
	controller = sceneController

func _next_level(body):
	print("Call next level")
	controller.nextLevel()
	
