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
