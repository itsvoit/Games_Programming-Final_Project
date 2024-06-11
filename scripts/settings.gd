extends Control

signal navigateBack

@onready var button_controls = $Navigation/Buttons/button_controls
@onready var button_sounds = $Navigation/Buttons/button_sounds
@onready var button_video = $Navigation/Buttons/button_video
@onready var button_back = $Navigation/Buttons/button_back
@onready var sounds = $Sounds
@onready var controls = $Controls
@onready var navigation = $Navigation
@onready var subMenus = [sounds, controls]

@export var isHover: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	button_controls.connect("pressed", _on_button_controls_pressed)
	button_sounds.connect("pressed", _on_button_sounds_pressed)
	button_video.connect("pressed", _on_button_video_pressed)
	button_back.connect("pressed", _on_button_back_pressed)
	sounds.connect("navigateBack", _navigate_back)
	controls.connect("navigateBack", _navigate_back)
	#print("00000000000")
	#for subMenu in subMenus:
		#print(str(subMenu))
		##subMenu.connect("navigateBack", _navigate_back)


func _navigate_back():
	for subMenu in subMenus:
		subMenu.hide()
	navigation.show()


func _on_button_controls_pressed():
	navigation.hide()
	controls.show()


func _on_button_sounds_pressed():
	navigation.hide()
	sounds.show()


func _on_button_video_pressed():
	navigation.hide()
	pass # Replace with function body.


func _on_button_back_pressed():
	if isHover:
		navigateBack.emit()
	else:
		get_tree().change_scene_to_file("res://scenes/ui/main_menu.tscn")
