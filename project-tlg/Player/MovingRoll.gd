extends PlayerState

func EnterState():
	# Set the label
	Player.StateLabel.text = "Moving Roll"


func ExitState():
	pass


func Update(delta: float):
	# Handle state physics
	Player.velocity.y += Player.Gravity * delta
	HandleMovingRoll()
	HandleAnimations()


func HandleMovingRoll():
	pass


func HandleAnimations():
	Player.Animator.play("player_still_roll")
		
	# Handle x-scale
	Player.Sprite.scale.x = Player.Facing
