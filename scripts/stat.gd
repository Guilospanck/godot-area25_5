@tool

class_name Stat
extends Area2D

@export var stat_resource: StatResource:
	set(value):
		stat_resource = value
		# Helper to load the ammo in the editor to visualise
		if Engine.is_editor_hint():
			load_stat()

################################ Signals ######################################
func _on_area2d_body_entered(_body: Node2D):
	Signals.stat_found.emit(stat_resource)
	queue_free()

########################################################################

func load_stat():
	if !stat_resource:
		return

	var stat_texture: Sprite2D = $Sprite2D
	var collision_shape: CollisionShape2D = $CollisionShape2D

	print(stat_resource.name)
	print(stat_resource.texture_path)

	stat_texture.texture = load(stat_resource.texture_path)

	# set the shape of the collision shape
	collision_shape.shape = stat_resource.collision_shape

func connect_signals():
	self.connect("body_entered", _on_area2d_body_entered)


func set_masks_and_layers():
	collision_layer = Constants.LAYER_5_ITEMS
	collision_mask = Constants.LAYER_1_PLAYER

func _ready():
	set_masks_and_layers()
	connect_signals()
