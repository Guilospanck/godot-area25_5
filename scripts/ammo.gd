@tool

class_name Ammo
extends Area2D

@export var ammo_resource: AmmoResource:
	set(value):
		ammo_resource = value
		# Helper to load the ammo in the editor to visualise
		if Engine.is_editor_hint():
			load_ammo()

var damage: int = 0
var direction: Vector2
var is_shooting: bool = false

const SPEED = 4

################################ Signals ######################################
func _on_shoot(shooting_position: Vector2, ammo_res: AmmoResource, dir: Vector2):
	if is_shooting:
		return

	position = shooting_position
	ammo_resource = ammo_res
	direction = dir

	load_ammo()

func _on_area2d_area_entered(hurtbox: HurtboxComponent):
	hurtbox.on_damage(damage)

func _on_area2d_body_entered(body: Node2D):
	if body is StaticBody2D:
		queue_free()

########################################################################

func set_masks_and_layers():
	collision_layer = Constants.LAYER_3_AMMO
	collision_mask = Constants.LAYER_2_ENEMY + Constants.LAYER_4_WALLS

func load_ammo():
	if !ammo_resource:
		return

	var ammo: Sprite2D = $Sprite2D
	var collision_shape: CollisionShape2D = $CollisionShape2D

	ammo.texture = load(ammo_resource.texture_path)
	damage = ammo_resource.damage

	# set the shape of the collision shape
	collision_shape.shape = ammo_resource.collision_shape

	is_shooting = true


func connect_signals():
	Signals.shoot.connect(_on_shoot)
	self.connect("area_entered", _on_area2d_area_entered)
	self.connect("body_entered", _on_area2d_body_entered)

func _ready():
	set_masks_and_layers()
	connect_signals()

func _physics_process(_delta: float) -> void:
	rotation = direction.angle() 
	position += direction * SPEED
	
