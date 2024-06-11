extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$VBoxContainer/Start_button.grab_focus()


func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://scenes/main_scene.tscn")


func _on_start_multi_button_pressed():
	get_tree().change_scene_to_file("res://scenes/multiplayer/main_scene.tscn")


func _on_options_button_pressed():
	get_tree().change_scene_to_file("res://scenes/ui/settings.tscn")


func _on_quit_button_pressed():
	get_tree().quit()
