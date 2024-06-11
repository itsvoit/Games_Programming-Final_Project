extends Node

signal nextLevel

var controller: SceneController2
@export var end_level: Area2D

func _ready():
	if end_level == null:
		return
	end_level.connect("body_entered", _next_level)

func init(sceneController: SceneController2):
	controller = sceneController

func _next_level(body):
	nextLevel.emit()
	
