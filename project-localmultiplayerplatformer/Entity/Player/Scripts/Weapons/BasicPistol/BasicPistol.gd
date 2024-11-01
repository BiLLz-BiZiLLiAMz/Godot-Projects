extends Weapon

#@onready var FireLeft = $FireLeft
#@onready var FireRight = $FireRight

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	Device = Player.Device

func _draw():
	super()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	super(delta)
	HandleShoot()
	HandleAnimation()

func HandleShoot():
	if (MultiplayerInput.is_action_just_pressed(Player.Device, "Shoot")):
		if (Player.canShoot):
			if ((Ammo > 0) or (Ammo == -1)):
				if (Animator.current_animation != "Shoot"):
					# Create the bullet
					var _bullet = Bullet.instantiate()
					_bullet.Direction = GetFireDirection()
					_bullet.global_position = GetBulletOriginPosition()
					#_bullet.rotation = GetFireRotation(_bullet.Direction)
					get_tree().root.add_child(_bullet)
					if (Ammo > 0): Ammo -= 1
					Animator.play("Shoot")
					# TODO: Play sound
					Player.velocity += -_bullet.Direction * Recoil
					queue_redraw()
				else:
					# TODO: Player no ammo sound
					pass


func HandleAnimation():
	pass


func ShootAnimationComplete():
	Animator.play("Idle")
