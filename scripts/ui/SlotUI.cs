#nullable enable
using Godot;
using System;

[Tool]
public partial class SlotUI : Control
{

	private Texture2D? _texture = null;
	private String? _shortcut = null;

	private PanelContainer? _textureContainer = null;

	[Export]
	public Texture2D? Texture
	{
		get => _texture; set
		{
			_texture = value;
			_updateData();
		}
	}

	[Export]
	public String? Shortcut
	{
		get => _shortcut; set
		{
			_shortcut = value;
			_updateData();
		}
	}

	public void SetActive()
	{
		if (_textureContainer == null)
		{
			GD.Print("[SlotUI] Cannot set slot active because `textureContainer` is null");
			return;
		}

		// Get the current style box, duplicating it so it also removes the reference
		StyleBoxFlat duplicatedStyleBox = _textureContainer.GetThemeStylebox("panel").Duplicate() as StyleBoxFlat;
		// Change its border color
		duplicatedStyleBox.BorderColor = Colors.White;
		// Update texture container stylebox to this new modified one
		_textureContainer.AddThemeStyleboxOverride("panel", duplicatedStyleBox);
	}

	public void SetInactive()
	{
		if (_textureContainer == null)
		{
			GD.Print("[SlotUI] Cannot set slot active because `textureContainer` is null");
			return;
		}

		StyleBoxFlat duplicatedStylebox = _textureContainer.GetThemeStylebox("panel").Duplicate() as StyleBoxFlat;
		duplicatedStylebox.BorderColor = Colors.Black;
		_textureContainer.AddThemeStyleboxOverride("panel", duplicatedStylebox);
	}

	private void _updateData()
	{
		if (_texture != null)
		{
			TextureRect textureRect = GetNode<TextureRect>("CenterContainer/TextureContainer/TextureRect");
			textureRect.Texture = _texture;
		}
		if (_shortcut != null)
		{
			Label shortcutLabel = GetNode<Label>("CenterContainer/ShortcutPanelContainer/ShortcutLabel");
			shortcutLabel.Text = _shortcut;
		}
	}

	public override void _Ready()
	{
		base._Ready();
		_textureContainer = GetNode<PanelContainer>("CenterContainer/TextureContainer");
	}
}
