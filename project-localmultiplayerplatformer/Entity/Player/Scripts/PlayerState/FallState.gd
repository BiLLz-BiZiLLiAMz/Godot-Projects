extends PlayerState

func EnterState():
	# Set the label
	Player.currentStateDebug = "Fall"
	
	# Check if we can jump then start the coyote timer
	if Player.previousState == States.Grounded:
		Player.canJump = true
		Player.CoyoteTimer.start(Player.CoyoteTime)
	else: 
		Player.canJump = false


func ExitState():
	pass


func Update(delta: float):
	# Handle state physics
	Player.velocity.y += Player.GravityFall * delta
	HandleCoyoteJumping()
	Player.HandleHorizontalMovement()
	HandleLanding()
	HandleDodge()
	HandleAnimations()


func HandleDodge():
	if (Player.dodgeInput):
		Player.Animator.play("AirDodge")
		#Player.ChangeState(States.Dodge)


func HandleAnimations():
	if (!(Player.Animator.current_animation == "AirDodge")):
		Player.Animator.play("Fall")
	Player.HandleFlipH()


func HandleCoyoteJumping():
	# Handle coyote jump
	if (Player.jumpInputPressed):
		#  See if we are coyote jumping
		if (Player.canJump):
			Player.ChangeState(States.Jump)
		
		# Start the input buffer timer
		Player.JumpBuffer.start(Player.jumpInputBufferTime)


func HandleLanding():
	if (Player.is_on_floor()):
		Player.ChangeState(States.Grounded)


func _on_coyote_timer_timeout() -> void:
	Player.canJump = false
