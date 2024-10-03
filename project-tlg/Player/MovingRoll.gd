extends PlayerState

func EnterState():
	pass


func ExitState():
	pass


func Update(delta: float):
	# Set the label
	Player.StateLabel.text = "Still Roll"
	
	Player.velocity.y += Player.GRAVITY * delta
	
	# Get the input direction
	var inputDirection = Input.get_axis("MoveLeft", "MoveRight")

	HandleAnimations()
	
	if (Player.is_on_floor()):
		Player.ChangeState(STATES.GROUNDED)
	else:
		pass

func HandleAnimations():
	Player.Animator.play("player_still_roll")
		
	# Handle x-scale
	Player.Sprite.scale.x = Player.Facing
