#nullable enable
using Godot;
using System;

[Tool]
public partial class Ammo : Area2D
{
	private AmmoResource? _ammoResource = null;

	private int _damage = 0;
	private Vector2? _direction = null;
	private bool _isShooting = false;

	private const int SPEED = 4;

	[Export]
	public AmmoResource AmmoResource
	{
		get => _ammoResource; set
		{
			_ammoResource = value;
			if (Engine.IsEditorHint())
			{
				_loadAmmo();
			}
		}
	}

	// ################################ Signals ######################################
	private void _onShoot(Vector2 shootingPosition, AmmoResource ammoResource, Vector2 direction)
	{
		if (_isShooting)
		{
			return;
		}

		Position = shootingPosition;
		_ammoResource = ammoResource;
		_direction = direction;

		_loadAmmo();
	}

	private void _onArea2DAreaEntered(Area2D area)
	{
		if (area is HurtboxComponent)
		{
			(area as HurtboxComponent).OnDamage(_damage);
		}
	}

	private void _onArea2DBodyEntered(Node2D body)
	{
		// If you hit a wall
		if (body is StaticBody2D)
		{
			QueueFree();
		}
	}
	// ########################################################################

	// An ammo has its own layer and can interact only with enemies and walls.
	private void _setMasksAndLayers()
	{
		CollisionLayer = Constants.Instance.LAYER_3_AMMO;
		CollisionMask = Constants.Instance.LAYER_2_ENEMY + Constants.Instance.LAYER_4_WALLS;
	}

	private void _connectSignals()
	{
		Signals.Instance.Shoot += _onShoot;
		AreaEntered += _onArea2DAreaEntered;
		BodyEntered += _onArea2DBodyEntered;
	}

	private void _loadAmmo()
	{
		if (_ammoResource is null)
		{
			GD.Print("Cannot loadAmmo because ammoResource is null");
			return;
		}

		Sprite2D ammo = GetNode<Sprite2D>("Sprite2D");
		CollisionShape2D collisionShape = GetNode<CollisionShape2D>("CollisionShape2D");

		ammo.Texture = ResourceLoader.Load<Texture2D>(_ammoResource.TexturePath);
		_damage = _ammoResource.Damage;

		collisionShape.Shape = _ammoResource.CollisionShape;

		_isShooting = true;
	}

	public override void _Ready()
	{
		base._Ready();
		_setMasksAndLayers();
		_connectSignals();
	}

	public override void _PhysicsProcess(double _delta)
	{
		// Makes the compiler happy. It would be the same as 
		// if (_direction != null)
		if (_direction is Vector2 dir)
		{
			Rotation = Mathf.Atan2(dir.Y, dir.X);
			Position += dir * SPEED;

		}
	}
}
