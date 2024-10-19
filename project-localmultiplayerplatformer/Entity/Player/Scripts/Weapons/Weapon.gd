class_name Weapon extends Resource

@export var Name: String
@export var Bullet: PackedScene
@export var Sprite: Texture2D
#@export var Animator: AnimationPlayer
@export var Recoil: float
@export var RateOfFire: float

var recoilTimer = 0

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
