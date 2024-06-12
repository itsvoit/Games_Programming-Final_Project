extends Node2D

signal nextLevel

@onready var show_secrets = $ShowSecret
@onready var tile_map = $TileMap

var controller: SceneController
@export var end_level: Area2D

func init(sceneController: SceneController):
	controller = sceneController

func _ready():
	GameController.updateGUi()
	if end_level.is_connected("body_entered", _next_level):
		end_level.disconnect("body_entered", _next_level)
	end_level.connect("body_entered", _next_level)
	print("Connected _next_level: " + str(end_level.is_connected("body_entered", _next_level)))
	var soundtrack = $AudioStreamPlayer2D
	soundtrack.play()
	GameController.playerChangeJumpVelocity(-400)
	show_secrets.collision_mask = 1 << 4-1
	show_secrets.collision_layer = 0
	show_secrets.connect("body_entered", _show_secrets)
	show_secrets.connect("body_exited", _hide_secrets)
	print("Lush cave")

func _next_level(body):
	print("Next level trigger")
	nextLevel.emit()

func _show_secrets(body):
	tile_map.set_layer_enabled(0, false)
	print("Show secrets")

func _hide_secrets(body):
	tile_map.set_layer_enabled(0, true)
	print("Hide secrets")

func _on_end_level_area_entered(area):
	print("area entered")
	pass # Replace with function body.
