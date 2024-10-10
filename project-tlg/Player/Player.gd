class_name PlayerController extends CharacterBody2D

# Player Nodes
@onready var Collider = $Collider
@onready var Raycasts = $Raycasts
@onready var Animator = $Animator
@onready var Sprite = $Sprite
@onready var Camera = $Camera
@onready var StateLabel = $DebugDisplay/StateLabel
@onready var CoyoteTimer = $CoyoteTimer
@onready var JumpBuffer = $JumpInputBufferTimer
@onready var DebugLabel = $DebugDisplay/DebugLabel
@onready var StaminaTimer = $StaminaTimer

# Raycasts
@onready var RCTopRight = $Raycasts/TopRight
@onready var RCTopLeft = $Raycasts/TopLeft
@onready var RCBottomRight = $Raycasts/BottomRight
@onready var RCBottomLeft = $Raycasts/BottomLeft

# State Machine
@onready var STATES = $STATES

#region Player Physics Constants
#######################################################################
# PLAYER CONSTANTS
#######################################################################

# Player movement
const SPEED = 160
const Acceleration = 50
const MaxXSpeed = 160
const StandingRollSpeed = 50
const StandingRollTime = 2
const MovingRollSpeed = 100
const MovingRollTime = 2
const RollDeceleration = 0.2

const Gravity = 600 #ProjectSettings.get_setting("physics/2d/default_gravity")
const GravityFall = 700
const JUMP_VELOCITY = -290.0
const WallJumpVelocity = -300
const WallJumpHorizontalSpeed = SPEED
const VariableJumpMultiplier = 0.5

var wallClimbDirection = 0
const ClimbSpeed = 20
var climbStamina = 5

var Facing
var SpriteXScale

#player input
var movementInput = Vector2.ZERO
var inputDirection = 0
var jumpInput = false
var jumpInputPressed = false
var climbInput = false 
var climbUp = false
var climbDown = false
var hasStamina = false
var rollInput = false
var dashInput = false
var CoyoteTime = 0.10;
var isJumpInputBuffered = false
var jumpInputBufferTime = 0.5

var canJump = true
var canDash = false

#endregion

# State Machine
var currentState = null
var previousState = null
var previousStateVelocity: Vector2 = Vector2.ZERO

# Debug
var currentStateDebug = "NULL"


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
	
	# Debug info
	StateLabel.text = "State: " + currentStateDebug
	DebugLabel.text = "Stamina: " + str('%.0f' % StaminaTimer.time_left)


func ChangeState(nextState):
	if nextState != null:
		previousState = currentState 
		currentState = nextState
				
		previousState.ExitState()
		currentState.EnterState()


func GetNextToWall() -> bool:
	UpdateRaycasts()
	
	# Check collisions
	if (RCTopRight.is_colliding() and RCBottomRight.is_colliding()):
		wallClimbDirection = 1
		return true
	elif (RCTopLeft.is_colliding() and RCBottomLeft.is_colliding()):
		wallClimbDirection = -1
		return true
	else:
		return false


func HandleHorizontalMovement():
	# Get the horizontal input direction
	var targetSpeed = MaxXSpeed * inputDirection
	velocity.x = move_toward(velocity.x, targetSpeed, Acceleration)


func UpdateRaycasts():
	# Force updates
	RCTopLeft.force_raycast_update()
	RCBottomLeft.force_raycast_update()
	RCTopRight.force_raycast_update()
	RCBottomRight.force_raycast_update()


func PlayerInput():
	# Get the input direction
	inputDirection = Input.get_axis("MoveLeft", "MoveRight")
	
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
	if (Input.is_action_just_pressed("Roll")):
		rollInput = true
	else:
		rollInput = false
	
	#climb
	if Input.is_action_pressed("Climb"):
		climbInput = true
	else: 
		climbInput = false
	
	if Input.is_action_pressed("MoveUp"):
		climbUp= true
	else: 
		climbUp = false
	
	if Input.is_action_pressed("MoveDown"):
		climbDown = true
	else: 
		climbDown = false
		
	#dash
	#if Input.is_action_just_pressed("Dash"):
		#dashInput = true
	#else: 
		#dashInput = false
