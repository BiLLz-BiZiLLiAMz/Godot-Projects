class_name Jump extends PlayerState

@export var grounded: PlayerState
@export var fall: PlayerState

func Enter() -> void:
	super()
	Player.velocity.y = Player.JUMP_VELOCITY

func ProcessFrame(delta: float) -> PlayerState:
	Player.StateLabel.text = "Jump"
	return null

func ProcessPhysics(delta: float) -> PlayerState:
	Player.velocity.y += Player.GRAVITY * delta
	
	if Player.velocity.y >= 0:
		return fall
	
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
	
	return null
	
func HandleAnimations():
	animator.play("player_jump_up")
		
	# Handle x-scale
	Player.Sprite.scale.x = Player.Facing
