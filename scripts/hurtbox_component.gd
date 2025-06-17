# Hurtboxes are monitorable
class_name HurtboxComponent
extends Area2D

# TODO: add this to a HealthComponent
@export var health: int = 100

var parent: Node

func on_damage(damage: int):
	if parent is PlayerComponent:
		print("Player took " + str(damage))
	else:
		print(parent.name + " took " + str(damage))

	health -= damage

	if health <= 0:
		# TODO: maybe play death animation or particles
		parent.queue_free()

		if parent is PlayerComponent:
			# TODO: Game over
			# GAME OVER
			get_tree().reload_current_scene()

func _ready() -> void:
	parent = get_parent()
