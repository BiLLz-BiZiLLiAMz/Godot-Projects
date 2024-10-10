class_name CameraController extends Camera2D

@export var followTarget: CharacterBody2D
var currentZone: Area2D 
var previousZone: Area2D
@onready var StateLabel = $StateLabel

# State Machine
var currentState = null
var previousState = null
var currentCameraState = "NULL"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	enabled = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#set_position(followTarget.get_position())
	pass
	

func ClampCameraToZone():
	# Clamp the camera so it stays within its current area
	pass


func TransitionToNewCameraZone(newZone: Area2D):
	# Move the camera to a new zone
	pass
