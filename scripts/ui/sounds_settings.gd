extends Control

signal navigateBack

@onready var back_button = $VBoxContainer/BackButton
@onready var music_on = $VBoxContainer/CheckButton
@onready var music_value = $VBoxContainer/GridContainer/HScrollBar

func _ready():
	back_button.connect("pressed", func(): navigateBack.emit())
	music_on.connect("toggled", _change_music_on)
	music_value.connect("value_changed", _change_music_volume)
	GameController.connect("musicValueChanged", _update_ui)
	GameController.connect("musicTurnedOn", _music_turned_on_update)
	_change_music_on(true)
	_change_music_volume(5)

func _change_music_on(value: bool):
	print("Change music on: " + str(value))
	GameController.musicOn(value)

func _change_music_volume(value):
	GameController.changeMusicVolume(value)

func _music_turned_on_update(value: bool):
	music_on.set_pressed_no_signal(value)

func _update_ui():
	var value = GameController.getMusicValue()
	print("In ui update, music value: " + str(value) + ", ui.musicOn=" + str(music_on.button_pressed))
	_change_music_on(value < 0.001)
	music_value.set_value_no_signal(value)
	


# handle other functions
# 
# ... here 
#
# ------------------------
