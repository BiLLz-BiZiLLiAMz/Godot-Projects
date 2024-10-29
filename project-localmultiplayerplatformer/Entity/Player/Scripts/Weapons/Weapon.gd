class_name Weapon extends Node2D

@export var Player: CharacterBody2D
@export var Name: String
@export var Bullet: PackedScene
@export var Sprite: Sprite2D
@export var Animator: AnimationPlayer
@export var Recoil: float
@export var Ammo: int = 0

@export var FireLeft: Marker2D
@export var FireRight: Marker2D
@export var FireUp: Marker2D
@export var FireDown: Marker2D

var Device

# Rate of fire is handled by the "Shoot" animation length


func _ready():
	
	Recoil *= 100


func _physics_process(delta):
	if (Player != null): Sprite.flip_h = (Player.Facing < 0)



func GetFireDirection() -> Vector2:
	if (Device < 0):
		if (MultiplayerInput.is_action_pressed(Device, "MoveLeft")):
			if (MultiplayerInput.is_action_pressed(Device, "MoveUp")):
				return Vector2.UP
			elif (MultiplayerInput.is_action_pressed(Device, "MoveDown")):
				return Vector2.DOWN
			else:
				return Vector2.LEFT
		elif (MultiplayerInput.is_action_pressed(Device, "MoveRight")):
			if (MultiplayerInput.is_action_pressed(Device, "MoveUp")):
				return Vector2.UP
			elif (MultiplayerInput.is_action_pressed(Device, "MoveDown")):
				return Vector2.DOWN
			else:
				return Vector2.RIGHT
		elif (MultiplayerInput.is_action_pressed(Device, "MoveUp")):
			return Vector2.UP
		elif (MultiplayerInput.is_action_pressed(Device, "MoveDown")):
			return Vector2.DOWN
		else:
			if (Player.Facing > 0):
				return Vector2.RIGHT
			else: 
				return Vector2.LEFT
	else:
		if (MultiplayerInput.is_action_pressed(Device, "AimLeft")):
				return Vector2.LEFT
		elif (MultiplayerInput.is_action_pressed(Device, "AimRight")):
				return Vector2.RIGHT
		elif (MultiplayerInput.is_action_pressed(Device, "AimUp")):
			return Vector2.UP
		elif (MultiplayerInput.is_action_pressed(Device, "AimDown")):
			return Vector2.DOWN
		else:
			if (Player.Facing > 0):
				return Vector2.RIGHT
			else: 
				return Vector2.LEFT


func GetBulletOriginPosition() -> Vector2:
	var _fireDirection = GetFireDirection()
	match _fireDirection:
		Vector2.LEFT: return FireLeft.global_position
		Vector2.RIGHT: return FireRight.global_position
		Vector2.UP: return FireUp.global_position
		Vector2.DOWN: return FireDown.global_position
		_: return Vector2.ZERO
