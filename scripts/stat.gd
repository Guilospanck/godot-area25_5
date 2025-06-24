# DONE to C#
@tool

class_name Stat
extends Area2D

@export var STAT_RESOURCE: StatResource:
	set(value):
		STAT_RESOURCE = value
		# Helper to load the ammo in the editor to visualise
		if Engine.is_editor_hint():
			load_stat()

################################ Signals ######################################
func _on_area2d_body_entered(_body: Node2D):
	Signals.stat_found.emit(STAT_RESOURCE)
	queue_free()

########################################################################

func load_stat(stat: StatResource = STAT_RESOURCE):
	if !stat:
		return

	var stat_texture: Sprite2D = $Sprite2D
	var collision_shape: CollisionShape2D = $CollisionShape2D

	stat_texture.texture = load(stat.texture_path)

	# set the shape of the collision shape
	collision_shape.shape = stat.collision_shape

	STAT_RESOURCE = stat

func connect_signals():
	self.connect("body_entered", _on_area2d_body_entered)


func set_masks_and_layers():
	collision_layer = Constants.LAYER_5_ITEMS
	collision_mask = Constants.LAYER_1_PLAYER

func _ready():
	load_stat()
	set_masks_and_layers()
	connect_signals()
