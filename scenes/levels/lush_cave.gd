extends "res://scripts/levels/level_controller.gd"

@onready var show_secrets = $ShowSecret
@onready var tile_map = $TileMap

func _ready():
	var soundtrack = $AudioStreamPlayer2D
	soundtrack.play()
	show_secrets.collision_mask = 1 << 4-1
	show_secrets.collision_layer = 0
	show_secrets.connect("body_entered", _show_secrets)
	show_secrets.connect("body_exited", _hide_secrets)
	

func _show_secrets(body):
	tile_map.set_layer_enabled(0, false)
	#tile_map.set_layer_enabled(1, false)
	#tile_map.set_layer_enabled(2, false)
	#tile_map.set_layer_enabled(3, false)
	print("Show secrets")

func _hide_secrets(body):
	tile_map.set_layer_enabled(0, true)
	print("Hide secrets")
