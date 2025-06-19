extends Control

@onready var weapons: HBoxContainer = $WeaponsContainer/Weapons
@onready var stats: HBoxContainer = $StatsContainer/Stats

var stat: PackedScene = preload("res://scenes/stat_ui.tscn")

# Example of Dictionary type:
# {
# 	"speed": {
# 		"current_count": 1,
# 		"instance": StatUI
# 	}
# }
var current_stats: Dictionary = {}

# TODO:  Use this for powers
# var slot: PackedScene = preload("res://scenes/slot.tscn")
# var current_weapons: Array = []
# func _on_weapon_switch(weapon_res: WeaponResource, shortcut: String):
# 	var weapon_name: String = weapon_res.name
# 	if current_weapons.has(weapon_name):
# 		return
#
# 	var texture = load(weapon_res.texture_path)
# 	var slot_instance = slot.instantiate()
# 	weapons.add_child(slot_instance)
	# slot_instance.texture = texture
	# slot_instance.shortcut = shortcut
# 	slot_instance.update_data()
#
# 	current_weapons.append(weapon_name)

func _on_weapon_switch(_weapon_res: WeaponResource, shortcut: String):
	for child in weapons.get_children():
		var label: Label = child.get_node("CenterContainer/ShortcutPanelContainer/ShortcutLabel")
		if label.text == shortcut:
			child.set_active()
		else:
			child.set_inactive()

func _on_stat_found(stat_res: StatResource):
	var stat_name: String = stat_res.name
	var count: int = 1

	var texture = load(stat_res.texture_path)
	var quantity = "x" + str(count)

	if current_stats.has(stat_name):
		var read_only_current = current_stats[stat_name]
		count = read_only_current["current_count"] + 1
		quantity = "x" + str(count)

		current_stats[stat_name]["current_count"] = count
		var instance: StatUI = read_only_current["instance"]
		instance.update_data(texture, quantity)

		return

	var stat_instance: StatUI = stat.instantiate()
	stats.add_child(stat_instance)

	current_stats[stat_name] = {
		"current_count": count,
		"instance": stat_instance
	}

	stat_instance.update_data(texture, quantity)


func _ready() -> void:
	Signals.weapon_switch.connect(_on_weapon_switch)
	Signals.stat_found.connect(_on_stat_found)
