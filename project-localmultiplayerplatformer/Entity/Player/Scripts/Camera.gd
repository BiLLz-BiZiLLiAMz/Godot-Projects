extends Camera2D

@export var target : CharacterBody2D
const SmoothingSpeed = 3
const CameraHorizontalLead = 0
const CameraFallLead = 10
var yLead = 0;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position_smoothing_enabled = true
	position_smoothing_speed = SmoothingSpeed
	#pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if (target):
		# Smoothly move the camera towards the player's position
		var targetPosition = Vector2.ZERO
		if (target.velocity.y > 0):
			yLead = CameraFallLead
		else:
			yLead = 0
		targetPosition = target.global_position + Vector2(target.Facing * CameraHorizontalLead, yLead)
		global_position = lerp(global_position, targetPosition, SmoothingSpeed * delta)
