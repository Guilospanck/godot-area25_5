# DONE to C#
# Hurtboxes are monitorable
class_name HurtboxComponent
extends Area2D

# TODO: add this to a HealthComponent
@export var health: int = 100
# TODO: add modular particle component to play after death

var parent: Node

func on_damage(damage: int):
	health -= damage
	print(parent.name + " took " + str(damage) + ". Current health: " + str(health))
	if health <= 0:
		Signals.is_dead.emit(parent)

func _ready() -> void:
	parent = get_parent()
