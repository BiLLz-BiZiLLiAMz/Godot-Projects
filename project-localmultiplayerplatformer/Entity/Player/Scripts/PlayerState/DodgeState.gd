extends PlayerState

func EnterState():
	# Set the label
	Player.currentStateDebug = "Dodge"
	Player.canShoot = false

func ExitState():
	pass


func Update(delta: float):
	# Handle State physics
	Player.velocity.y += Player.Gravity * delta
	HandleJump()
	HandleJumpToFall()
	Player.HandleHorizontalMovement()	
	HandleAnimations()

func HandleJump():
	# See if the jump key is held, if not, slash the momentum
	if (!Input.is_action_pressed("Jump")):
		Player.velocity.y *= Player.VariableJumpMultiplier
		Player.ChangeState(States.JumpTransition)


func HandleJumpToFall():
	if (Player.velocity.y > 0):
		Player.ChangeState(States.JumpTransition)


func HandleAnimations():
	Player.Animator.play("AirDodge")


func _on_animator_animation_finished(anim_name: StringName) -> void:
	Player.ChangeState(States.Fall)
