extends PlayerState

var hasStamina
var canClimb = true
var canClimbUp = true
var canClimbDown = true

func EnterState():
	# Set the state label
	Player.currentStateDebug = "Climb"
	
	Player.velocity.x = 0
	Player.velocity.y = 0
	
	Player.Sprite.scale.x = Player.Facing #-Player.wallClimbDirection
	Player.Animator.play("player_wall_land")
	
	Player.StaminaTimer.start(Player.climbStamina)


func ExitState():
	pass


func Update(delta: float):	
	@warning_ignore("unused_parameter")
	# Handle the movments
	HandleClimb()
	HandleWallJump()
	HandleAnimations()


func HandleAnimations():
	Player.Animator.play("player_wall_idle")
	# Set the x-scale
	Player.Sprite.scale.x = Player.Facing #-Player.wallClimbDirection


func HandleClimb():
	# See if the player is no longer colliding on a wall (climbed to a corner)
	Player.UpdateRaycasts()
	if (Player.wallClimbDirection > 0): # Wall is right
		# See if top raycast is no longer colliding
		if (Player.RCTopRight.is_colliding()):
			# Not colliding so jump onto the platform
			canClimbUp = true
		else:
			canClimbUp = false
		
		if (Player.RCBottomRight.is_colliding()):
			# Not colliding so jump onto the platform
			canClimbDown = true
		else:
			canClimbDown = false
	else:
		# See if top raycast is no longer colliding
		if (!Player.RCTopLeft.is_colliding()):
			# Not colliding so jump onto the platform
			canClimbUp = false
		else:
			canClimbUp = true
		
		if (!Player.RCBottomLeft.is_colliding()):
			# Not colliding so jump onto the platform
			canClimbDown = false
		else:
			canClimbDown = true
	
	# See if the player has let go of the climb key
	if (!Player.climbInput):
		Player.ChangeState(STATES.FALL)
	
	# See if we are on the ground
	if (Player.is_on_floor()):
		Player.ChangeState(STATES.GROUNDED)
	
	# Handle climbing up and down
	if (Input.is_action_pressed("MoveUp") and canClimbUp):
		Player.velocity.y = -Player.ClimbSpeed
	elif (Input.is_action_pressed("MoveDown") and canClimbDown):
		Player.velocity.y = Player.ClimbSpeed
	else:
		Player.velocity.y = 0
		
func HandleWallJump():
	if(Player.jumpInputPressed):
		Player.ChangeState(STATES.WALL_JUMP)


func _on_stamina_timer_timeout() -> void:
	print("NO MORE STAMINA")
	Player.ChangeState(STATES.FALL)
	Player.hasStamina = false
