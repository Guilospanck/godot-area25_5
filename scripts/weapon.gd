@tool

class_name Weapon
extends Sprite2D

@export var WEAPON_RESOURCE: WeaponResource:
	set(value):
		WEAPON_RESOURCE = value
		if Engine.is_editor_hint():
			load_weapon()

var damage: int

func _ready():
	load_weapon()

func load_weapon(weapon: WeaponResource = WEAPON_RESOURCE):
	if !weapon:
		return

	texture = load(weapon.texture_path)
	name = weapon.name
	damage = weapon.damage

	position = weapon.position
	scale = weapon.scale
	rotation = weapon.rotation
