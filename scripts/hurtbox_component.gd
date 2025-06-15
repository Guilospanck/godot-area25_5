# Hurtboxes are monitorable
class_name HurtboxComponent
extends Area2D

# TODO: add this to a HealthComponent
@export var health: int = 100

func on_damage(damage: int):
	print("received " + str(damage))
	health -= damage
	print("New health is " + str(health))
