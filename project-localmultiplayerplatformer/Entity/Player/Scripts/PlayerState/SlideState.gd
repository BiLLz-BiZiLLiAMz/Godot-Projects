extends PlayerState

func EnterState():
	# Set the label
	Player.currentStateDebug = "Slide"
	Player.velocity.x = (Player.MoveSpeed * Player.SlideSpeedMultiplier) * Player.Facing


func ExitState():
	pass


func Update(delta: float):
	# Handle state physics
	Player.velocity.y += Player.GravityFall * delta
	Player.Animator.play("Slide")
	HandleFalling()


func AnimationFinished():
	print("TEST")


func HandleFalling():
	# See if we walked off a ledge
	if (!Player.is_on_floor()):
		Player.ChangeState(States.Fall)


func _on_animator_animation_finished(anim_name: StringName) -> void:
	Player.ChangeState(States.Grounded)
