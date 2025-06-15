@tool

class_name Ammo
extends Sprite2D

@export var AMMO_RESOURCE: AmmoResource:
	set(value):
		AMMO_RESOURCE = value
		if Engine.is_editor_hint():
			load_ammo()

var damage: int
var shoot: bool = false
var towards: Vector2

func _ready():
	load_ammo()

func _physics_process(delta: float) -> void:
	if !shoot:
		return

	# TODO: change this to only care about the direction and not the destination itself
	position = position.move_toward(towards, delta * 100)

func load_ammo(ammo: AmmoResource = AMMO_RESOURCE):
	if !ammo:
		return

	texture = load(ammo.texture_path)
	name = ammo.name
	damage = ammo.damage

	position = ammo.position
	scale = ammo.scale
	rotation = ammo.rotation
	
