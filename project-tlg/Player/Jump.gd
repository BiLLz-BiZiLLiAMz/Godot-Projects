class_name Jump extends PlayerState

func EnterState():
	# Set the state label
	Player.currentStateDebug = "Jump"
	
	# Set the jump variables
	Player.isJumpInputBuffered = false
	Player.velocity.y = Player.JUMP_VELOCITY


func ExitState():
	pass


func Update(delta: float):	
	# Handle State physics
	Player.velocity.y += Player.Gravity * delta
	HandleJump()
	HandleJumpToFall()
	HandleClimb()
	Player.HandleHorizontalMovement()	
	HandleAnimations()


func HandleAnimations():
	Player.Animator.play("player_jump_up")
		
	# Handle x-scale
	Player.Sprite.scale.x = Player.Facing


func HandleJump():
	# See if the jump key is held, if not, slash the momentum
	if (!Input.is_action_pressed("Jump")):
		Player.velocity.y *= Player.VariableJumpMultiplier
		Player.ChangeState(STATES.FALL)


func HandleJumpToFall():
	if (Player.velocity.y > 0):
		Player.ChangeState(STATES.FALL)


func HandleClimb():
	# See if we are against a wall
	if (Player.GetNextToWall()):
		if (Player.climbInput and Player.hasStamina):
			Player.ChangeState(STATES.CLIMB)
