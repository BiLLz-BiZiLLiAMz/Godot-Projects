class_name HealthComponent extends Node2D

@export var MaxHealth: int
var health

func _ready():
	health = MaxHealth


func Damage(attack: Bullet):
	health -= attack.Damage
	
	if (health <= 0):
		pass #SIGNAL DEATH!
