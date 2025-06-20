# DONE to C#
class_name StatManager
extends Node

@export var stats_resources: Array[StatResource]

var rng = RandomNumberGenerator.new()

var stat: PackedScene = preload("res://scenes/stat.tscn")

func spawn_random(where: Node, count: int):
	var stats_length = stats_resources.size()
	if stats_length == 0:
		return

	var boundaries: Dictionary[String, float] = Utils.get_viewport_boundaries(where)

	for i in count:
		var res: StatResource = stats_resources[i % stats_length]
		var stat_instance = stat.instantiate()

		var random_x = rng.randf_range(boundaries.min_x, boundaries.max_x)
		var random_y = rng.randf_range(boundaries.min_y, boundaries.max_y)

		where.add_child(stat_instance)
		stat_instance.load_stat(res)
		stat_instance.position = Vector2(random_x, random_y)
	
