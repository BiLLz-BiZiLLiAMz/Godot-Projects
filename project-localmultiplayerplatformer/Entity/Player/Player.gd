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
@onready var HurtBoxHead = $"HurtBox-Head/Head"
@onready var HurtBoxBody = $"HurtBox-Body/Body"

@export var Device: int

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
const RunSpeed = 280
const SlideSpeed = 320
var MoveSpeed = RunSpeed
const Acceleration = 50

# Player Jumping
#const Gravity = Globals.Gravity
const GravityFall = 1350
const JumpVelocity = -500.0
const SlideJumpVelocity = -600
const VariableJumpMultiplier = 0.5
var CoyoteTime = 0.02;
var isJumpInputBuffered = false
var jumpInputBufferTime = 0.0
var jumpSpeed = JumpVelocity

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
var AimLeft = false
var AimRight = false
var AimUp = false
var AimDown = false

var canJump = true
var canDash = false
var canShoot = true

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
	EnableHurtbox()
	# Get the facing direction to scale the sprite
	SpriteXScale = Sprite.scale.x
	Facing = SpriteXScale


func _physics_process(delta):
	# Player input
	GetInputStates()
	
	# Update the current state
	currentState.Update(delta)
	StateLabel.text = "Speed: " + str(jumpSpeed)
	
	# Commit movement
	move_and_slide()
	
	# Debug info
	

func ChangeState(nextState):
	if nextState != null:
		previousState = currentState 
		currentState = nextState
		
		previousState.ExitState()
		currentState.EnterState()


func HandleHorizontalMovement():
	# Get the horizontal input direction
	var targetSpeed = MoveSpeed * inputDirection
	velocity.x = move_toward(velocity.x, targetSpeed, Acceleration)


func GetInputStates():
	# Get the input direction
	inputDirection = MultiplayerInput.get_axis(Device, "MoveLeft", "MoveRight")
	
	movementInput = Vector2.ZERO
	if MultiplayerInput.is_action_pressed(Device, "MoveRight"):
		movementInput.x += 1
		Facing = SpriteXScale
	if MultiplayerInput.is_action_pressed(Device, "MoveLeft"):
		movementInput.x -= 1
		Facing = -SpriteXScale
	if MultiplayerInput.is_action_pressed(Device, "MoveUp"):
		movementInput.y -= 1
	if MultiplayerInput.is_action_pressed(Device, "MoveDown"):
		movementInput.y += 1
	
	# jumps
	jumpInput = MultiplayerInput.is_action_pressed(Device, "Jump")
	jumpInputPressed = MultiplayerInput.is_action_just_pressed(Device, "Jump")
	dodgeInput = MultiplayerInput.is_action_just_pressed(Device, "Dodge")
	shootInput = MultiplayerInput.is_action_just_pressed(Device, "Shoot")
	AimUp = MultiplayerInput.is_action_pressed(Device, "AimUp")
	AimDown = MultiplayerInput.is_action_pressed(Device, "AimDown")
	AimLeft = MultiplayerInput.is_action_pressed(Device, "AimLeft")
	AimRight = MultiplayerInput.is_action_pressed(Device, "AimRight")


func HandleFlipH():
	Sprite.flip_h = (Facing < 1)


func HandleAimAnimations():
	pass


func EnableHurtbox():
	HurtBoxBody.disabled = false
	HurtBoxHead.disabled = false
