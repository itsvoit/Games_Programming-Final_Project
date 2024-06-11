extends Camera2D

@export var player: Player
@export var verticalOffset: float = -28
@export var horizontalOffset: float = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if player == null:
		return
	position = player.position
	position.x += verticalOffset
	position.y += horizontalOffset
