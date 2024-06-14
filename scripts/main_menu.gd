extends Control

@onready var loretimer = $Loretimer
@onready var lore = $Lore

# Called when the node enters the scene tree for the first time.
func _ready():
	$VBoxContainer/Start_button.grab_focus()
	loretimer.connect("timeout", _loretimer_timeout)
	lore.hide()


func _process(_delta):
	if not loretimer.is_stopped() and (Input.is_action_just_pressed("jump") or Input.is_action_just_pressed("ui_accept")):
		loretimer.stop()
		_loretimer_timeout()


func _loretimer_timeout():
	get_tree().change_scene_to_file("res://scenes/main_scene.tscn")


func _on_start_button_pressed():
	loretimer.start()
	lore.show()


func _on_options_button_pressed():
	get_tree().change_scene_to_file("res://scenes/ui/settings.tscn")


func _on_quit_button_pressed():
	get_tree().quit()
