extends PlayerState

func EnterState():
	# Set the label
	Player.StateLabel.text = "Standing Roll"
	Player.velocity.x = Player.StandingRollSpeed * Player.Facing

func ExitState():
	pass


func Update(delta: float):
	# Handle state physics
	Player.velocity.y += Player.Gravity * delta
	HandleStandingRoll()
	HandleAnimations()


func HandleStandingRoll():
	pass


func HandleAnimations():
	Player.Animator.play("player_still_roll")	
	# Handle x-scale
	Player.Sprite.scale.x = Player.Facing


func _on_animator_animation_finished(anim_name: StringName) -> void:
	Player.velocity.x = 0
	Player.ChangeState(STATES.GROUNDED)
