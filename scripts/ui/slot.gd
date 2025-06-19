@tool

extends Control

@export var texture: Texture2D:
	set(value):
		texture = value
		update_data()

@export var shortcut: String:
	set(value):
		shortcut = value
		update_data()

@onready var texture_container: PanelContainer = $CenterContainer/TextureContainer

func update_data():
	if texture:
		var texture_rect = $CenterContainer/TextureContainer/TextureRect
		texture_rect.texture = texture

	if shortcut:
		var shortcut_label = $CenterContainer/ShortcutPanelContainer/ShortcutLabel
		shortcut_label.text = shortcut

func set_active():
	var new_stylebox_normal = texture_container.get_theme_stylebox("panel").duplicate()
	new_stylebox_normal.border_color = Color.WHITE
	texture_container.add_theme_stylebox_override("panel", new_stylebox_normal)

func set_inactive():
	var new_stylebox_normal = texture_container.get_theme_stylebox("panel").duplicate()
	new_stylebox_normal.border_color = Color.BLACK
	texture_container.add_theme_stylebox_override("panel", new_stylebox_normal)
