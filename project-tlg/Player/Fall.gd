extends PlayerState

func EnterState():
	# Set the label
	Player.currentStateDebug = "Fall"
	
	# Check if we can jump then start the coyote timer
	if Player.previousState == STATES.GROUNDED:
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
	HandleClimb()
	HandleWallJump()
	HandleAnimations()


func HandleAnimations():
	Player.Animator.play("player_fall")
		
	# Handle x-scale
	Player.Sprite.scale.x = Player.Facing


func HandleCoyoteJumping():
	# Handle coyote jump
	if (Player.jumpInputPressed):
		#  See if we are coyote jumping
		if (Player.canJump):
			Player.ChangeState(STATES.JUMP)
		
		# Start the input buffer timer
		Player.JumpBuffer.start(Player.jumpInputBufferTime)


func HandleLanding():
	if (Player.is_on_floor()):
		Player.ChangeState(STATES.GROUNDED)


func HandleClimb():
	# See if we are against a wall
	if (Player.GetNextToWall()):
		if (Player.climbInput and Player.hasStamina):
			Player.ChangeState(STATES.CLIMB)

func HandleWallJump():
	if (Player.GetNextToWall() and Player.jumpInputPressed):
		print("WALL JUMP")
		Player.ChangeState(STATES.WALL_JUMP)



func _on_coyote_timer_timeout() -> void:
	Player.canJump = false
