# DONE to C#
extends Node2D

@onready var stat_manager_scene = $StatManager

func _ready() -> void:
	stat_manager_scene.spawn_random(self, 8)
