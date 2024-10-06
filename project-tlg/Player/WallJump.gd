extends PlayerState

var WallJumpDirection = 0

func EnterState():
	# Set the state label
	Player.currentStateDebug = "Wall Jump"
	Player.velocity.y = Player.WallJumpVelocity
	# Get the direction AWAY from the wall
	WallJumpDirection = -Player.wallClimbDirection


func ExitState():
	Player.Facing = -(Player.wallClimbDirection * Player.SpriteXScale)


func Update(delta: float):
	@warning_ignore("unused_parameter")
	# Handle the movments
	if (Player.velocity.y < 0):
		Player.velocity.y += Player.Gravity * delta
	else:
		Player.velocity.y += Player.GravityFall * delta

	HandleWallJump()
	HandleLanding()
	HandleAnimations()
	
	#switch states
	if (Player.velocity.y > 0):
		Player.ChangeState(STATES.FALL)


func HandleAnimations():
	if (Player.velocity.y < 0):
		Player.Animator.play("player_wall_jump")
	else:
		Player.Animator.play("player_fall")
	
	# Set the x-scale
	Player.Sprite.scale.x = -(Player.wallClimbDirection * Player.SpriteXScale)


func HandleWallJump():
	# Apply horizontal momentum
	Player.velocity.x = move_toward(Player.velocity.x, Player.WallJumpHorizontalSpeed * WallJumpDirection, Player.Acceleration) 
	
func HandleLanding():
	if (Player.is_on_floor() or Player.is_on_ceiling()):
		Player.ChangeState(STATES.FALL)
