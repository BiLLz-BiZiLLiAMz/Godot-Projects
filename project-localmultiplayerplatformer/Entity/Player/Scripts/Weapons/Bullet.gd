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
var collided = false

func _ready():
	if (Direction == Vector2.RIGHT):
		Sprite.rotation_degrees = 0
	elif (Direction == Vector2.LEFT):
		Sprite.rotation_degrees = 180
	elif (Direction == Vector2.UP):
		Sprite.rotation_degrees = 270
	elif (Direction == Vector2.DOWN):
		Sprite.rotation_degrees = 90


func _physics_process(delta: float) -> void:
	global_position += Direction * Speed
	if (collided == true):
		Sprite.visible = false
		queue_free()


func _on_collider_body_entered(body: Node2D) -> void:
	Speed = 0
	collided = true
