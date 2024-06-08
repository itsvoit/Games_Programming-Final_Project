extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("pause"):
		show()
		get_tree().paused = true


func _on_resume_button_pressed():
	get_tree().paused = false
	hide()
