extends Camera2D

@export var player1: Player
@export var player2: Player2
@export var verticalOffset: float = -28
@export var horizontalOffset: float = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if player1 == null or player2 == null:
		return
	position = (player1.position + player2.position) / 2
	position.x += verticalOffset
	position.y += horizontalOffset
