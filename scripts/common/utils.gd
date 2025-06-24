# DONE to C#
# Autoloaded
extends Node

## Searches direct children of `root` for the first one matching `type`.
## 
## @param root The parent Node whose children will be searched.
## @param type A class reference (GDScript or native) to match via runtime check.
## @return The first child Node that is an instance of `type`, or `null` if none found.
func get_child_component_or_null(root: Node, type) -> Node:
    for child in root.get_children():
        if is_instance_of(child, type):
            return child
    return null

## Gets the viewport's minimum and maximum sizes, while also
## applying some Constants.VIEWPORT_CUSHION_OFFSET to prevent using
## boundaries too far away.
## 
## @param from_where: Node The parent Node whose the viewport will be retrieved from.
##
## @return A `Dictionary` containing the keys: `min_x`, `max_x`, `min_y` and `max_y`.
func get_viewport_boundaries(from_where: Node) -> Dictionary[String, float]:
    var rect = from_where.get_viewport_rect().size

    var min_x: float = 0.0 + Constants.VIEWPORT_CUSHION_OFFSET
    var max_x: float = rect[0] - Constants.VIEWPORT_CUSHION_OFFSET

    var min_y: float = 0.0 + Constants.VIEWPORT_CUSHION_OFFSET
    var max_y: float = rect[1] - Constants.VIEWPORT_CUSHION_OFFSET

    return {
        "min_x": min_x, "max_x": max_x, "min_y": min_y, "max_y": max_y
    }

