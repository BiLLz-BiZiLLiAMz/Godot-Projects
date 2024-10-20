class_name Bullet extends Node2D

enum BulletTypes {
	Straight,
	Tracking
}

@export var Damage: float
@export var Sprite: Sprite2D
@export var Speed: float
@export var Penetrating: bool
@export var Collider: Area2D
@export var MovementType: BulletTypes

var Direction: Vector2

func _physics_process(delta: float) -> void:
	global_position += Direction * Speed
	




func OnColliderAreaEntered(area: Area2D) -> void:
	print("COLLIDED")
	queue_free()
