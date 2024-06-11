class_name SceneController
extends Node

@export var level1Path: String
@export var level2Path: String
@export var level3Path: String
#var level1Packed = preload("res://scenes/test_level.tscn")
var level1Packed = preload("res://scenes/levels/test_level.tscn")
var level2Packed = preload("res://scenes/second_level.tscn")
var level3Packed = preload("res://scenes/final_level.tscn")
var level1
var level2
var level3
var currentLevelIdx = 1

func _ready():
	level1 = level1Packed.instantiate()
	level2 = level2Packed.instantiate()
	level3 = level3Packed.instantiate()
	
	level1.init(self)
	add_child(level1)
	get_tree().current_scene = level1


func nextLevel() -> bool:
	print("Entered next level")
	if currentLevelIdx >= 3:
		return false
	var current_scene = get_tree().current_scene
	current_scene.queue_free()
	get_tree().current_scene = null
	
	currentLevelIdx += 1
	match currentLevelIdx:
		1:
			get_tree().get_root().add_child(level1)
			get_tree().current_scene = level1
		2:
			get_tree().get_root().add_child(level2)
			get_tree().current_scene = level2
		3:
			get_tree().get_root().add_child(level2)
			get_tree().current_scene = level2
	
	print("Switched to the next level")
	return true


