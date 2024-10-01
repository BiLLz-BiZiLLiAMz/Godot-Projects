class_name PlayerState extends Node

@export var animationName: String
@export var animator: AnimationPlayer
@export var collider: CollisionShape2D
@export var Player: PlayerController ## Hold a reference to the parent so that it can be controlled by the state

func Enter() -> void:
	#animator.play(animationName) # Used to play an animation entering a new state?
	pass

func Exit() -> void:
	pass

func ProcessInput(event: InputEvent) -> PlayerState:
	return null

func ProcessFrame(delta: float) -> PlayerState:
	return null

func ProcessPhysics(delta: float) -> PlayerState:
	return null
