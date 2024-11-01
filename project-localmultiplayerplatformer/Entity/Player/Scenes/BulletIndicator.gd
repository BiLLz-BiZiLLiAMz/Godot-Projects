extends Node2D

@export var Player: PlayerController
@export var Weapons: Weapon
@onready var WeaponLabel = $Label
var currentWeapon

# Bullet indicator
@export var AmmoTexture: Texture2D = preload("res://Entity/Player/Resources/BulletIndicator.png")
var BulletWidth: int
var BulletHeight: int
var BulletRegion: Rect2
var EmptyRegion: Rect2
var InfinityRegion: Rect2
var DrawAmmoX: float
var DrawAmmoY: float

func _ready() -> void:
	# Get the current weapon
	currentWeapon = Weapons.get_child(0)
	
	# Dynamically set BulletWidth and BulletHeight based on texture size
	BulletWidth = AmmoTexture.get_width() / 3  # Assuming three images side-by-side
	BulletHeight = AmmoTexture.get_height()
	
	# Define regions based on calculated dimensions
	BulletRegion = Rect2(BulletWidth, 0, BulletWidth, BulletHeight)
	EmptyRegion = Rect2(0, 0, BulletWidth, BulletHeight)
	InfinityRegion = Rect2(BulletWidth * 2, 0, BulletWidth, BulletHeight)
	
	DrawAmmoX = position.x - ((currentWeapon.Ammo * BulletWidth) / 2)
	DrawAmmoY = position.y
	queue_redraw()

func _draw():
	if (currentWeapon.Ammo == -1):
		print(InfinityRegion)
		draw_texture_rect_region(AmmoTexture, Rect2(Vector2(DrawAmmoX, DrawAmmoY), Vector2(BulletWidth, BulletHeight)), InfinityRegion, Color(1, 1, 1), true, false)
	else:
		for i in range(currentWeapon.MaxAmmo):
			draw_texture_rect_region(AmmoTexture, Rect2(Vector2(DrawAmmoX + (i * BulletWidth), DrawAmmoY), Vector2(BulletWidth, BulletHeight)), EmptyRegion)
		for i in range(currentWeapon.Ammo):
			draw_texture_rect_region(AmmoTexture, Rect2(Vector2(DrawAmmoX + (i * BulletWidth), DrawAmmoY), Vector2(BulletWidth, BulletHeight)), BulletRegion)


func _process(delta: float) -> void:
	WeaponLabel.text = "Player " + str(Player.Device + 1)
	#var textWidth = WeaponLabel.get_character_bounds().x
	#WeaponLabel.position = Vector2(-textWidth / 2, WeaponLabel.position.y)
	queue_redraw()
