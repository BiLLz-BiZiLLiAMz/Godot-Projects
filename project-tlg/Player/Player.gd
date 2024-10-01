class_name PlayerController extends CharacterBody2D

# Player Nodes
@onready var Collider = $Collider
@onready var Animator = $Animator
@onready var Sprite = $Sprite
@onready var Camera = $Camera
@onready var StateMachine = $StateMachine
@onready var StateLabel = $StateLabel

#region Player Physics Constants
#######################################################################
# PLAYER CONSTANTS
#######################################################################

# Player movement
const SPEED = 160
const JUMP_VELOCITY = -290.0
var GRAVITY = 600
var Facing
var SpriteXScale
#endregion

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Initialize the state machine, passing a reference of the player to the states,
	# that way they can move and react accordingly
	StateMachine.Init(self)
	SpriteXScale = Sprite.scale.x
	Facing = SpriteXScale

func _unhandled_input(event: InputEvent) -> void:
	StateMachine.ProcessInput(event)
	if (Input.is_action_just_pressed("MoveRight")):
		Facing = SpriteXScale
	if (Input.is_action_just_pressed("MoveLeft")):
		Facing = -SpriteXScale

func _physics_process(delta: float) -> void:
	StateMachine.ProcessPhysics(delta)

func _process(delta: float) -> void:
	StateMachine.ProcessFrame(delta)
