class_name Weapon extends Node2D

@export var Name: String
@export var Bullet: Bullet
@export var Sprite: Sprite2D
@export var Animator: AnimationPlayer
@export var Recoil: float
var recoilTimer = 0
@export var RateOfFire: float

func _ready():
	pass


func _physics_process(delta):
	if (recoilTimer > 0):
		recoilTimer -= delta
	
	HandleFire()


func HandleFire():
	if (Input.is_action_just_pressed("Shoot")):
		if (recoilTimer <= 0):
			#TODO: Fire a bullet
			recoilTimer = Recoil
