#nullable enable
using Godot;
using System;

public partial class StatUI : Control
{
	public void UpdateData(Texture2D texture, String quantity)
	{
		TextureRect textureRect = GetNode<TextureRect>("IconPanelContainer/Icon");
		textureRect.Texture = texture;

		Label quantityLabel = GetNode<Label>("IconPanelContainer/QuantityControl/QuantityPanelContainer/Quantity");
		quantityLabel.Text = quantity;
	}
}
