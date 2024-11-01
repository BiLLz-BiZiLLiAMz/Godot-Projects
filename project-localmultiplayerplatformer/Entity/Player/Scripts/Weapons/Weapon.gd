class_name Weapon extends Node2D

@export var Player: CharacterBody2D
@export var Name: String
@export var Bullet: PackedScene
@export var Sprite: Sprite2D
@export var Animator: AnimationPlayer
@export var Recoil: float
@export var Ammo: int = 0
@export var MaxAmmo: int = 0

@export var FireLeft: Marker2D
@export var FireRight: Marker2D
@export var FireUp: Marker2D
@export var FireDown: Marker2D

var Device

# Bullet indicator
var AmmoTexture: Texture2D = preload("res://Entity/Player/Resources/BulletIndicator.png")
var BulletWidth = AmmoTexture.get_width()/3
var BulletHeight = AmmoTexture.get_height()
var BulletRegion = Rect2(BulletWidth, 0, BulletWidth * 2, BulletHeight)
var InfinityRegion = Rect2(BulletWidth * 2, 0, BulletWidth * 3, BulletHeight)
var DrawAmmoX
var DrawAmmoY

# Rate of fire is handled by the "Shoot" animation length


func _ready():
	Recoil *= 100
	if (Ammo != -1): Ammo = MaxAmmo
	queue_redraw()


func _draw():
	pass


#func DrawBullets():
	#if (Ammo == -1):
		#draw_texture_rect_region(AmmoTexture, Rect2(Vector2(DrawAmmoX, DrawAmmoY), Vector2(BulletWidth, BulletHeight)), InfinityRegion)
	#else:
		#for i in range(Ammo):
			#draw_texture_rect_region(AmmoTexture, Rect2(Vector2(i * BulletWidth, DrawAmmoY), Vector2(BulletWidth, BulletHeight)), BulletRegion)


func _process(delta):
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
