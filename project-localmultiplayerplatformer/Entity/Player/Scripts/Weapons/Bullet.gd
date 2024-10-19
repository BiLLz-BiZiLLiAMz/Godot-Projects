class_name Bullet extends Resource

enum BulletTypes {
	Straight,
	Tracking
}

@export var Damage: float
@export var Sprite: Texture2D
@export var Speed: float
@export var Penetrating: bool
#@export var Collider: Area2D
@export var MovementType: BulletTypes

var Direction: Vector2
