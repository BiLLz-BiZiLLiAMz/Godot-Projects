extends PlayerState

func EnterState():
	# Check if we can jump then start the coyote timer
	if Player.previousState == STATES.GROUNDED:
		Player.canJump = true
		Player.CoyoteTimer.start(Player.CoyoteTime)
	else: 
		Player.canJump = false


func ExitState():
	pass


func Update(delta: float):
	# Set the label
	Player.currentStateDebug = "Fall"
	
	Player.velocity.y += Player.GravityFall * delta
	
	# Handle coyote jump
	if (Player.jumpInputPressed):
		#  See if we are coyote jumping
		if (Player.canJump):
			Player.ChangeState(STATES.JUMP)
		
		# Start the input buffer timer
		Player.JumpBuffer.start(Player.jumpInputBufferTime)
		
	# Get the input direction
	var inputDirection = Input.get_axis("MoveLeft", "MoveRight")
	
	# Get the horizontal input direction
	if (inputDirection):
		Player.velocity.x = inputDirection * Player.SPEED
	else:
		Player.velocity.x = move_toward(Player.velocity.x, 0, Player.SPEED)

	HandleAnimations()
	
	if (Player.is_on_floor()):
		Player.ChangeState(STATES.GROUNDED)


func HandleAnimations():
	Player.Animator.play("player_fall")
		
	# Handle x-scale
	Player.Sprite.scale.x = Player.Facing


func _on_coyote_timer_timeout() -> void:
	Player.canJump = false
