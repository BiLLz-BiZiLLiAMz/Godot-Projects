extends PlayerState


func EnterState():
	# Set the state label
	Player.currentStateDebug = "Grounded"
	Player.canJump = true
	Player.MoveSpeed = Player.RunSpeed

func ExitState():
	pass


func Update(delta: float):
	# Allow the player to jump
	Player.canJump = true
	
	# Handle the movments
	Player.HandleHorizontalMovement()
	HandleJump()
	HandleFalling()
	HandleSlide()
	HandleAnimations()


func HandleAnimations():
	if (Player.velocity.x != 0):
		Player.Animator.play("Run")
	if (Player.velocity.x == 0):
		Player.Animator.play("Idle")
	Player.HandleFlipH()


func HandleFalling():
	# See if we walked off a ledge
	if (!Player.is_on_floor()):
		Player.ChangeState(States.Fall)


func HandleJump():
	# See if the jump input buffer timer is greater thatn 0, if so
	# buffer the input
	if (Player.JumpBuffer.time_left > 0):
		Player.isJumpInputBuffered = true
	else:
		Player.isJumpInputBuffered = false
	
	# Handle jump
	if ((Player.jumpInputPressed) && Player.canJump): #or Player.isJumpInputBuffered
		Player.isJumpInputBuffered = false
		Player.ChangeState(States.Jump)


func HandleSlide():
	if (Player.dodgeInput):
		Player.ChangeState(States.Slide)
