class_name HitboxComponent
extends Area2D

# TODO: add this to a HealthComponent
@export var health: int = 100

func on_damage(damage: int):
	health -= damage
	print("New health is " + str(health))

