extends PlayerState


func EnterState():
	pass


func ExitState():
	pass


func Update(delta: float):
	# Set the state label
	Player.currentStateDebug = "Grounded"
	
	# Allow the player to jump
	Player.canJump = true
	
	# Get the input direction
	var inputDirection = Input.get_axis("MoveLeft", "MoveRight")
	
	# Get the horizontal input direction
	if (inputDirection):
		if (inputDirection > 0):
			Player.velocity.x = move_toward(Player.velocity.x, Player.MaxXSpeed, (Player.Acceleration * inputDirection)) #min(Player.velocity.x + (inputDirection * Player.Acceleration), Player.MaxXSpeed)
		else:
			Player.velocity.x = move_toward(Player.velocity.x, Player.MaxXSpeed, (Player.Acceleration * inputDirection))
	else:
		Player.velocity.x = move_toward(Player.velocity.x, 0, Player.Acceleration)
	
	# See if the jump input buffer timer is greater thatn 0, if so
	# buffer the input
	if (Player.JumpBuffer.time_left > 0):
		Player.isJumpInputBuffered = true
	else:
		Player.isJumpInputBuffered = false
	
	
	# Handle jump
	if (Player.jumpInputPressed && Player.canJump):
		Player.ChangeState(STATES.JUMP)
	if (Player.isJumpInputBuffered && Player.canJump):
		Player.ChangeState(STATES.JUMP)
	
	# Handle rolling
	if (Player.rollInput):
		if (Player.velocity.x != 0):
			# Moving roll
			
			pass
		else:
			# Still roll
			
			pass
	
	# See if we walked off a ledge
	if (!Player.is_on_floor()):
		Player.ChangeState(STATES.FALL)
	else:
		Player.canJump = true
	
	HandleAnimations()


func HandleAnimations():
	if (Player.velocity.x != 0):
		Player.Animator.play("player_run")
	if (Player.velocity.x == 0):
		Player.Animator.play("player_idle")
	
	# Set the x-scale
	Player.Sprite.scale.x = Player.Facing
