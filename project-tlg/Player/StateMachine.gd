# class_name StateMachine
extends Node

@export var startingState: PlayerState
var currentState: PlayerState

func _ready():
	pass

# Initialize the state machine by giving each child state a reference to the
# parent object it belongs to and enter the default starting_state.
func Init(player: PlayerController) -> void:
	for child in get_children():
		child.Player = player

	# Initialize to the default state
	ChangeState(startingState)

# Change to the new state by first calling any exit logic on the current state.
func ChangeState(newState: PlayerState) -> void:
	if currentState:
		currentState.Exit()

	currentState = newState
	currentState.Enter()
	
# Pass through functions for the Player to call,
# handling state changes as needed.
func ProcessPhysics(delta: float) -> void:
	var newState = currentState.ProcessPhysics(delta)
	if newState:
		ChangeState(newState)

func ProcessInput(event: InputEvent) -> void:
	var newState = currentState.ProcessInput(event)
	if newState:
		ChangeState(newState)

func ProcessFrame(delta: float) -> void:
	var newState = currentState.ProcessFrame(delta)
	if newState:
		ChangeState(newState)
