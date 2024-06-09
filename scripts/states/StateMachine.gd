extends Node

@export var startingState: State

var currentState: State

func init(parent: Player) -> void:
	for child in get_children():
		child.parent = parent
	
	# Initialize to the default state
	change_state(startingState)

# Change to the new state by first calling any exit login on the current state
func change_state(new_state: State) -> void:
	if currentState:
		currentState.exit()
	
	currentState = new_state
	currentState.enter()

# Pass through functions for the Player to call,
# handling state changes as needed.
func process_input(event: InputEvent) -> void:
	var new_state = currentState.process_input(event)
	if new_state:
		change_state(new_state)

func process_frame(delta: float) -> void:
	var new_state = currentState.process_frame(delta)
	if new_state:
		change_state(new_state)

func process_physics(delta: float) -> void:
	var new_state = currentState.process_physics(delta)
	if new_state:
		change_state(new_state)
