class_name Grounded extends PlayerState

@export var jump: PlayerState
@export var fall: PlayerState

func ProcessInput(event: InputEvent) -> PlayerState:
	# Handle player jump
	if (Input.is_action_just_pressed("MoveUp") and Player.is_on_floor()):
		return jump
	return null

func ProcessFrame(delta: float) -> PlayerState:
	Player.StateLabel.text = "Grounded"
	return null

func ProcessPhysics(delta: float) -> PlayerState:
	# Get the input direction
	var inputDirection = Input.get_axis("MoveLeft", "MoveRight")
	
	# Get the horizontal input direction
	if (inputDirection):
		Player.velocity.x = inputDirection * Player.SPEED
	else:
		Player.velocity.x = move_toward(Player.velocity.x, 0, Player.SPEED)
	
	HandleAnimations()
	Player.move_and_slide()
	return null

func HandleAnimations():
	if (Player.velocity.x != 0):
		animator.play("player_run")
	if (Player.velocity.x == 0):
		animator.play("player_idle")
	
	# Set the x-scale
	Player.Sprite.scale.x = Player.Facing
