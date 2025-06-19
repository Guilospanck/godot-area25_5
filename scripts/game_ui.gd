extends Control

@onready var weapons: HBoxContainer = $WeaponsContainer/Weapons

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

func _ready() -> void:
	Signals.weapon_switch.connect(_on_weapon_switch)
	pass
