# DONE to C#
class_name StatUI
extends Control

func update_data(texture: Texture2D, quantity: String):
	var texture_rect = $IconPanelContainer/Icon
	texture_rect.texture = texture

	var quantity_label = $IconPanelContainer/QuantityControl/QuantityPanelContainer/Quantity
	quantity_label.text = quantity
