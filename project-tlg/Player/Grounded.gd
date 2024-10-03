extends PlayerState


func EnterState():
	pass


func ExitState():
	pass


func Update(delta: float):
	# Set the state label
	Player.StateLabel.text = "Grounded"
	
	# Allow the player to jump
	Player.canJump = true
	
	# Get the input direction
	var inputDirection = Input.get_axis("MoveLeft", "MoveRight")
	
	# Get the horizontal input direction
	if (inputDirection):
		Player.velocity.x = inputDirection * Player.SPEED
	else:
		Player.velocity.x = move_toward(Player.velocity.x, 0, Player.SPEED)
	
	# Handle jump
	if (Player.jumpInputPressed && Player.canJump):
		Player.ChangeState(STATES.JUMP)
	
	HandleAnimations()


func HandleAnimations():
	if (Player.velocity.x != 0):
		Player.Animator.play("player_run")
	if (Player.velocity.x == 0):
		Player.Animator.play("player_idle")
	
	# Set the x-scale
	Player.Sprite.scale.x = Player.Facing
