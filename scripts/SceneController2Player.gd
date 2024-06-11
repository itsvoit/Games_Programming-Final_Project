class_name SceneController2
extends Node

var level1Packed = preload("res://scenes/multiplayer/levels2Players/first_level.tscn")
var level2Packed = preload("res://scenes/multiplayer/levels2Players/lush_cave.tscn")
var level3Packed = preload("res://scenes/multiplayer/levels2Players/credits.tscn")
var level1
var level2
var level3
var currentLevelIdx = 1

@onready var timer = $Timer
var is_changing_scenes = false

func _ready():
	timer.connect("timeout", _on_timer_timeout)
	level1 = level1Packed.instantiate()
	level2 = level2Packed.instantiate()
	level3 = level3Packed.instantiate()
	
	level1.init(self)
	level1.connect("nextLevel", nextLevel)
	add_child(level1)
	print("Current level: " + str(get_tree().current_scene))


func _process(delta):
	if Input.is_action_just_pressed("debug"):
		print(get_tree_string_pretty())
		print("Current level index: " + str(currentLevelIdx))
		print()
		nextLevel()


func nextLevel() -> bool:
	print("Entered next level function")
	if is_changing_scenes:
		return false
		
	timer.start()
	is_changing_scenes = true
	print("timer")
	
	if currentLevelIdx > 3:
		return false
	var children = get_children()
	for child in children:
		if child is Timer:
			continue
		child.queue_free()
	
	currentLevelIdx += 1
	match currentLevelIdx:
		1:
			level1.init(self)
			level1.connect("nextLevel", nextLevel)
			add_child(level1)
		2:
			level2.init(self)
			level2.connect("nextLevel", nextLevel)
			call_deferred("add_child", level2)
		3:
			level3.init(self)
			level3.connect("nextLevel", nextLevel)
			call_deferred("add_child", level3)
	
	print("Switch to the next level")
	return true

func _on_timer_timeout():
	is_changing_scenes = false
	print("timeout")
