class_name PlayerController extends CharacterBody2D

# Player Nodes
@onready var Collider = $Collider
@onready var Raycasts = $Raycasts
@onready var Animator = $Animator
@onready var Sprite = $Sprite
@onready var Camera = $Camera
@onready var StateMachine = $StateMachine
@onready var StateLabel = $StateLabel

@onready var STATES = $STATES

#region Player Physics Constants
#######################################################################
# PLAYER CONSTANTS
#######################################################################

# Player movement
const SPEED = 160
const JUMP_VELOCITY = -290.0
var GRAVITY = ProjectSettings.get_setting("physics/2d/default_gravity")
var Facing
var SpriteXScale

#player input
var movementInput = Vector2.ZERO
var jumpInput = false
var jumpInputPressed = false
var climbInput = false 
var rollInput = false
var dashInput = false

var canJump = false
var canDash = false

#endregion

# State Machine
var currentState = null
var previousState = null


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Initialize the state machine
	for state in STATES.get_children():
		state.STATES = STATES
		state.Player = self
	previousState = STATES.FALL
	currentState = STATES.FALL
	
	# Get the facing direction to scale the sprite
	SpriteXScale = Sprite.scale.x
	Facing = SpriteXScale


func _physics_process(delta):
	# Player input
	PlayerInput()
	
	# Update the current state
	currentState.Update(delta)
	StateLabel.text = str(currentState.get_name())
	
	# Commit movement
	move_and_slide()


func Gravity(delta):
	if not is_on_floor():
		velocity.y += GRAVITY * delta


func ChangeState(nextState):
	if nextState != null:
		previousState = currentState 
		currentState = nextState
		
		previousState.ExitState()
		currentState.EnterState()


func GetNextToWall():
	for raycast in Raycasts.get_children():
		raycast.force_raycast_update() 
		if raycast.is_colliding():
			if raycast.target_position.x > 0:
				return Vector2.RIGHT
			else:
				return Vector2.LEFT
	return null


func PlayerInput():
	movementInput = Vector2.ZERO
	if Input.is_action_pressed("MoveRight"):
		movementInput.x += 1
		Facing = SpriteXScale
	if Input.is_action_pressed("MoveLeft"):
		movementInput.x -= 1
		Facing = -SpriteXScale
	if Input.is_action_pressed("MoveUp"):
		movementInput.y -= 1
	if Input.is_action_pressed("MoveDown"):
		movementInput.y += 1
	
	# jumps
	if Input.is_action_pressed("Jump"):
		jumpInput = true
	else: 
		jumpInput = false
	if Input.is_action_just_pressed("Jump"):
		jumpInputPressed = true
	else: 
		jumpInputPressed = false
	
	# Roll
	if (Input.is_action_pressed("Roll")):
		rollInput = true
	else:
		rollInput = false
	
	#climb
	if Input.is_action_pressed("Climb"):
		climbInput = true
	else: 
		climbInput = false
	
	#dash
	if Input.is_action_just_pressed("Dash"):
		dashInput = true
	else: 
		dashInput = false
