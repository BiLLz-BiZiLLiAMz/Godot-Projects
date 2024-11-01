class_name HitboxComponent extends Area2D

@export var Health: HealthComponent

func Damage(attack: Bullet):
	if (Health):
		Health.Damage(attack)
