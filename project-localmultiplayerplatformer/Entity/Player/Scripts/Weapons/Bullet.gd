class_name Bullet extends Node2D

@export var Damage: float
var Direction: Vector2
@export var Sprite: Sprite2D
@export var Speed: float
@export var Penetrating: bool
@export var Collider: Area2D


func _ready():
	Collider.body_entered.connect(BulletCollided)

func Update(delta):
	position += Direction * Speed * delta


func BulletCollided():
	# TODO: Play bullet collision animation
	queue_free()
