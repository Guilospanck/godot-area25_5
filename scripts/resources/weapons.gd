class_name WeaponResource
extends Resource

@export var name: String

@export_category("Weapon orientation")
@export var position: Vector2
@export var rotation: float
@export var scale: Vector2

@export_category("Visual settings")
@export var texture_path: String

@export_category("Metadata")
@export var damage: int
