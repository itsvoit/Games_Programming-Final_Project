extends Control

signal navigateBack

@onready var back_button = $VBoxContainer/BackButton
@onready var music_on = $VBoxContainer/CheckButton
@onready var music_value = $VBoxContainer/GridContainer/HScrollBar

func _ready():
	back_button.connect("pressed", func(): navigateBack.emit())
	music_on.connect("toggled", _change_music_on)
	music_value.connect("value_changed", _change_music_volume)
	_change_music_on(true)
	_change_music_volume(5)

func _change_music_on(value: bool):
	music_value.value = 0
	GameController.musicOn(value)

func _change_music_volume(value):
	GameController.changeMusicVolume(value)
	

# handle other functions
# 
# ... here 
#
# ------------------------
