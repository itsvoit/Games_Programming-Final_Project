extends Control

signal navigateBack

@onready var back_button = $VBoxContainer/BackButton

func _ready():
	back_button.connect("pressed", func(): navigateBack.emit())

# handle other functions
# 
# ... here 
#
# ------------------------
