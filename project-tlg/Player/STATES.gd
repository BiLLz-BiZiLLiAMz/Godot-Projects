extends Node

@onready var LOCKED = $Locked
@onready var GROUNDED = $Grounded
@onready var JUMP = $Jump
@onready var FALL = $Fall
@onready var STILL_ROLL = $StillRoll
@onready var MOVING_ROLL = $MovingRoll
@onready var CLIMB = $Climb
@onready var WALL_JUMP = $WallJump

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	@warning_ignore("unused_parameter")
	pass
