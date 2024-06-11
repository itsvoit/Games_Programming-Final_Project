extends Control

@onready var resume_button = $Navigation/Resume_button
@onready var settings_button = $Navigation/Settings_button
@onready var quit_button = $Navigation/Quit_button

@onready var navigation = $Navigation
@onready var settings = $Settings


func _hide_all():
	settings.hide()
	navigation.hide()
	hide()


func _show_navigation():
	settings.hide()
	navigation.show()


func _show_settings():
	settings.show()
	navigation.hide()


# Called when the node enters the scene tree for the first time.
func _ready():
	resume_button.connect("pressed", _on_resume_button_pressed)
	settings_button.connect("pressed", _on_settings_button_pressed)
	settings.connect("navigateBack", _show_navigation)
	quit_button.connect("pressed", func(): get_tree().quit())
	_hide_all()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("pause"):
		show()
		_show_navigation()
		get_tree().paused = true


func _on_resume_button_pressed():
	get_tree().paused = false
	_hide_all()


func _on_settings_button_pressed():
	_show_settings()
