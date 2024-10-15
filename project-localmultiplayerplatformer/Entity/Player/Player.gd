class_name PlayerController extends CharacterBody2D

#region Player Nodes
# Player Nodes
@onready var Sprite = $Sprite
@onready var Collider = $Collider
@onready var Animator = $Animator
@onready var Camera = $Camera
@onready var StateLabel = $DebugDisplay/StateLabel
@onready var CoyoteTimer = $Timers/CoyoteTimer
@onready var JumpBuffer = $Timers/JumpBufferTimer


# Raycasts
#@onready var RCTopRight = $Raycasts/TopRight
#@onready var RCTopLeft = $Raycasts/TopLeft
#@onready var RCBottomRight = $Raycasts/BottomRight
#@onready var RCBottomLeft = $Raycasts/BottomLeft

# State Machine
@onready var States = $PlayerStates

#endregion

#region Player Constants
#######################################################################
# PHYSICS
#######################################################################

# Player Horizontal Movement
const MoveSpeed = 480
const SlideSpeedMultiplier = 1.2
const Acceleration = 100
const MaxXSpeed = MoveSpeed

# Player Jumping
#const Gravity = Globals.Gravity
const GravityFall = 1550
const JumpVelocity = -650.0
const VariableJumpMultiplier = 0.5
var CoyoteTime = 0.02;
var isJumpInputBuffered = false
var jumpInputBufferTime = 0.0

# Player Inputs
var movementInput = Vector2.ZERO
var inputDirection = 0
var jumpInput = false
var jumpInputPressed = false
var climbInput = false 
var climbUp = false
var climbDown = false
var dodgeInput = false
var shootInput = false
var shootInputPressed = false

var canJump = true
var canDash = false

# Player Sprite Direction
var Facing
var SpriteXScale

# Player Weapons
var currentWeapon: Weapon:
	set(weapon):
		currentWeapon = weapon

#endregion

#region State Machine

# State Machine
var currentState = null
var previousState = null
var currentStateDebug = "NULL"

#endregion

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Initialize the state machine
	for state in States.get_children():
		state.States = States
		state.Player = self
	previousState = States.Fall
	currentState = States.Fall
	
	# Get the facing direction to scale the sprite
	SpriteXScale = Sprite.scale.x
	Facing = SpriteXScale


func _physics_process(delta):
	# Player input
	PlayerInput()
	
	# Update the current state
	currentState.Update(delta)
	StateLabel.text = str("State: " + currentState.get_name())
	
	# Commit movement
	move_and_slide()
	
	# Debug info
	


func ChangeState(nextState):
	if nextState != null:
		previousState = currentState 
		currentState = nextState
				
		previousState.ExitState()
		currentState.EnterState()


#func GetNextToWall() -> bool:
#
	#
	## Check collisions
	#if (RCTopRight.is_colliding() and RCBottomRight.is_colliding()):
		#wallClimbDirection = 1
		#return true
	#elif (RCTopLeft.is_colliding() and RCBottomLeft.is_colliding()):
		#wallClimbDirection = -1
		#return true
	#else:
		#return false


func HandleHorizontalMovement():
	# Get the horizontal input direction
	var targetSpeed = MaxXSpeed * inputDirection
	velocity.x = move_toward(velocity.x, targetSpeed, Acceleration)


#func UpdateRaycasts():
	## Force updates
	#RCTopLeft.force_raycast_update()
	#RCBottomLeft.force_raycast_update()
	#RCTopRight.force_raycast_update()
	#RCBottomRight.force_raycast_update()


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
	
	# Dodge
	if (Input.is_action_just_pressed("Dodge")):
		dodgeInput = true
	else:
		dodgeInput = false
	
	# Shoot
	if (Input.is_action_just_pressed("Shoot")):
		shootInput = true
	else:
		shootInput = false


func HandleFlipH():
	Sprite.flip_h = (Facing < 1)
