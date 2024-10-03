extends PlayerState

func EnterState():
	pass


func ExitState():
	pass


func Update(delta: float):
	# Set the label
	Player.StateLabel.text = "Fall"
	
	Player.velocity.y += Player.GRAVITY * delta
	
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
	else:
		pass


func HandleAnimations():
	Player.Animator.play("player_fall")
		
	# Handle x-scale
	Player.Sprite.scale.x = Player.Facing
