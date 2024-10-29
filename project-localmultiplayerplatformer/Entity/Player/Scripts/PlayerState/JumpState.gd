class_name Jump extends PlayerState

func EnterState():
	# Set the state label
	Player.currentStateDebug = "Jump"
	
	# Set the jump variables
	Player.isJumpInputBuffered = false
	Player.velocity.y = Player.jumpSpeed
	Player.canShoot = true


func ExitState():
	pass


func Update(delta: float):	
	# Handle State physics
	Player.velocity.y += Globals.Gravity * delta
	HandleJump()
	HandleJumpToFall()
	Player.HandleHorizontalMovement()	
	HandleAnimations()
	HandleDodge()


func HandleAnimations():
	if (!(Player.Animator.current_animation == "AirDodge")):
		Player.Animator.play("JumpUp")
	Player.HandleFlipH()


func HandleJump():
	# See if the jump key is held, if not, slash the momentum
	if (!Player.jumpInput):
		Player.velocity.y *= Player.VariableJumpMultiplier
		Player.ChangeState(States.JumpTransition)


func HandleJumpToFall():
	if (Player.velocity.y > 0):
		Player.ChangeState(States.JumpTransition)


func HandleDodge():
	if (Player.dodgeInput):
		Player.Animator.play("AirDodge")
		#Player.ChangeState(States.Dodge)
