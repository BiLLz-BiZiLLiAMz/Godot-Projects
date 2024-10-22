extends CharacterBody2D

#region Player Variables

# Nodes
@onready var Sprite = $Sprite
@onready var Animator = $Animator

# Physics Variables
const RunSpeed = 150
const Acceleration = 50
const Gravity = 300
const JumpVelocity = -150

var moveSpeed = RunSpeed
var moveDirection = 0
var canJump = false
var facing = 1

# Input Variables
var keyUp = false
var keyDown = false
var keyLeft = false
var keyRight = false
var keyJump = false
var keyJumpPressed = false

#endregion

func _ready():
	pass


func _input(event: InputEvent) -> void:
	keyUp = Input.is_action_pressed("Up")
	keyDown = Input.is_action_pressed("Down")
	keyLeft = Input.is_action_pressed("Left")
	keyRight = Input.is_action_pressed("Right")
	keyJump = Input.is_action_pressed("Jump")
	keyJumpPressed = Input.is_action_just_pressed("Jump")
	
	if (keyLeft): facing = -1
	if (keyRight): facing = 1


func _physics_process(delta: float) -> void:
	# Handle Gravity
	if (!is_on_floor()):
		velocity.y += Gravity * delta
		canJump = false
	else:
		canJump = true

	#Handle Movements
	HorizontalMovement()
	HandleJump()
	
	# Commit movement
	move_and_slide()
	
	# Handle Animation
	HandleAnimation()


func HorizontalMovement():
	moveDirection = Input.get_axis("Left", "Right")
	velocity.x = move_toward(velocity.x, moveDirection * moveSpeed, Acceleration)


func HandleJump():
	if (keyJumpPressed):
		if (canJump):
			velocity.y = JumpVelocity


func HandleAnimation():
	# Handle the sprite x-scale
	Sprite.flip_h = (facing < 0)
	
	# Handle horizontal movements
	if (is_on_floor()):
		if (velocity.x != 0):
			Animator.play("Run")
		else:
			Animator.play("Idle")
	else:
		if (velocity.y < 0):
			Animator.play("Jump")
		else:
			Animator.play("Fall")
