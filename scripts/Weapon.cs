#nullable enable
using Godot;

public partial class Weapon : Sprite2D
{
	private WeaponResource? _weaponResource = null;
	private int _damage = 0;

	[Export]
	public WeaponResource? WeaponResource
	{
		get => _weaponResource;
		set
		{
			_weaponResource = value;

			if (Engine.IsEditorHint())
			{
				LoadWeapon();
			}
		}
	}

	public void LoadWeapon(WeaponResource? weaponResource = null)
	{
		var weaponRes = weaponResource ?? _weaponResource;
		if (weaponRes is null)
		{
			GD.Print("Cannot LoadWeapon because the weaponRes is null");
			return;
		}

		Texture = GD.Load<Texture2D>(weaponRes.TexturePath);
		Name = weaponRes.Name;
		_damage = weaponRes.Damage;

		Position = weaponRes.Position;
		Scale = weaponRes.Scale;
		Rotation = weaponRes.Rotation;
	}

	public override void _Ready()
	{
		base._Ready();
		LoadWeapon();
	}
}
