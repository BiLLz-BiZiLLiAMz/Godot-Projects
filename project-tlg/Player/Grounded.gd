extends PlayerState


func EnterState():
	# Set the state label
	Player.currentStateDebug = "Grounded"
	Player.hasStamina = true


func ExitState():
	pass


func Update(delta: float):
	@warning_ignore("unused_parameter")
	# Allow the player to jump
	Player.canJump = true
	
	# Handle the movments
	Player.HandleHorizontalMovement()
	HandleJump()
	HandleRoll()
	HandleFalling()
	HandleAnimations()


func HandleAnimations():
	if (Player.velocity.x != 0):
		Player.Animator.play("player_run")
	if (Player.velocity.x == 0):
		Player.Animator.play("player_idle")
	
	# Set the x-scale
	Player.Sprite.scale.x = Player.Facing


func HandleRoll():
	# Handle rolling
	if (Player.rollInput):
		Player.ChangeState(STATES.STILL_ROLL)


func HandleFalling():
	# See if we walked off a ledge
	if (!Player.is_on_floor()):
		Player.ChangeState(STATES.FALL)
	else:
		Player.canJump = true


func HandleJump():
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
