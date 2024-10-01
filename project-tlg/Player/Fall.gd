class_name Fall extends PlayerState

@export var grounded: PlayerState

func ProcessInput(event: InputEvent) -> PlayerState:
	return null

func ProcessFrame(delta: float) -> PlayerState:
	Player.StateLabel.text = "Airborn"
	return null

func ProcessPhysics(delta: float) -> PlayerState:
	Player.velocity.y += Player.GRAVITY * delta
	
	# Get the input direction
	var inputDirection = Input.get_axis("MoveLeft", "MoveRight")
	
	# Get the horizontal input direction
	if (inputDirection):
		Player.velocity.x = inputDirection * Player.SPEED
	else:
		Player.velocity.x = move_toward(Player.velocity.x, 0, Player.SPEED)
	
	Player.move_and_slide()
	HandleAnimations()
	
	if (Player.is_on_floor()):
		return grounded
	else:
		return null
	return null
	
func HandleAnimations():
	animator.play("player_fall")
		
	# Handle x-scale
	Player.Sprite.scale.x = Player.Facing
