class_name Jump extends PlayerState

func EnterState():
	Player.velocity.y = Player.JUMP_VELOCITY


func ExitState():
	pass


func Update(delta: float):
	# Set the state label
	Player.StateLabel.text = "Jump"
	
	Player.velocity.y += Player.GRAVITY * delta
	
	if (Player.velocity.y > 0):
		Player.ChangeState(STATES.FALL)
	
	# Get the input direction
	var inputDirection = Input.get_axis("MoveLeft", "MoveRight")
	
	# Get the horizontal input direction
	if (inputDirection):
		Player.velocity.x = inputDirection * Player.SPEED
	else:
		Player.velocity.x = move_toward(Player.velocity.x, 0, Player.SPEED)
	
	HandleAnimations()


func HandleAnimations():
	Player.Animator.play("player_jump_up")
		
	# Handle x-scale
	Player.Sprite.scale.x = Player.Facing
