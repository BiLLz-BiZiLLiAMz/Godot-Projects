extends PlayerState

func EnterState():
	# Set the label
	Player.currentStateDebug = "Slide"
	Player.MoveSpeed = Player.SlideSpeed
	Player.velocity.x = (Player.MoveSpeed) * Player.Facing


func ExitState():
	pass


func Update(delta: float):
	# Handle state physics
	Player.velocity.y += Player.GravityFall * delta
	Player.Animator.play("Slide")
	HandleFalling()
	HandleJump()


func AnimationFinished():
	print("TEST")


func HandleJump():
	# See if the jump input buffer timer is greater thatn 0, if so
	# buffer the input
	if (Player.JumpBuffer.time_left > 0):
		Player.isJumpInputBuffered = true
	else:
		Player.isJumpInputBuffered = false
	
	# Handle jump
	if ((Player.jumpInputPressed) && Player.canJump): #or Player.isJumpInputBuffered
		Player.isJumpInputBuffered = false
		Player.ChangeState(States.Jump)


func HandleFalling():
	# See if we walked off a ledge
	if (!Player.is_on_floor()):
		Player.ChangeState(States.Fall)


func _on_animator_animation_finished(anim_name: StringName) -> void:
	if (Player.is_on_floor()):
		Player.ChangeState(States.Grounded)
	else:
		Player.ChangeState(States.Fall)
