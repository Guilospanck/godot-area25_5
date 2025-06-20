# DONE to C#
class_name StatResource
extends Resource

@export var name: String

@export_category("Stat orientation")
@export var position: Vector2
@export var rotation: float
@export var scale: Vector2

@export_category("Visual settings")
@export var texture_path: String

@export_category("Metadata")
# TODO: change
@export var stat: int

@export_category("Collision")
@export var collision_shape: Shape2D

