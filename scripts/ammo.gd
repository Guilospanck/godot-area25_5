@tool

class_name Ammo
extends Area2D

@export var ammo_resource: AmmoResource:
	set(value):
		ammo_resource = value
		# Helper to load the ammo in the editor to visualise
		if Engine.is_editor_hint():
			load_ammo()

@onready var ammo: Sprite2D = $Sprite2D
@onready var collision_shape: CollisionShape2D = $CollisionShape2D

var damage: int
var shoot: bool = false

var firing_position: Vector2
var towards: Vector2

func set_masks_and_layers():
	collision_layer = Constants.LAYER_3_AMMO
	collision_mask = Constants.LAYER_2_ENEMY + Constants.LAYER_4_WALLS

# TODO: fix ammo switch
func load_ammo():
	if !ammo_resource:
		return

	ammo.texture = load(ammo_resource.texture_path)
	ammo.name = ammo_resource.name
	damage = ammo_resource.damage

	# set the shape of the collision shape
	collision_shape.shape = ammo_resource.collision_shape


func set_scene_orientation():
	if !ammo_resource:
		return

	position = ammo_resource.position
	scale = ammo_resource.scale
	rotation = ammo_resource.rotation

func _on_area2d_area_entered(body: Node2D):
	print("Ammo collided with " + body.name)

func _ready():
	load_ammo()
	set_masks_and_layers()
	set_scene_orientation()
	self.connect("area_entered", _on_area2d_area_entered)

func _physics_process(delta: float) -> void:
	if !shoot:
		return

	var mouse_direction = towards - firing_position
	rotation = mouse_direction.angle() 

	position = position.move_toward(towards, delta * 100)

	
