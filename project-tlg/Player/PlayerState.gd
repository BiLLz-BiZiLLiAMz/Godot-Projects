class_name PlayerState extends Node


var STATES = null
var Player = null

func EnterState():
	pass


func ExitState():
	pass


func Update(delta):
	@warning_ignore("unused_parameter")
	return null

#func PlayerMovement():
	#if Player.movement_input.x >0:
		#Player.velocity.x = Player.SPEED
		#Player.last_direction = Vector2.RIGHT
	#elif Player.movement_input.x <0:
		#Player.velocity.x = - Player.SPEED
		#Player.last_direction = Vector2.LEFT
	#else:
		#Player.velocity.x = 0
