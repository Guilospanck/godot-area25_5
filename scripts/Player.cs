#nullable enable
using Godot;

public partial class Player : CharacterBody2D
{
	private const int _SPEED = 300;
	private bool _isDead = false;

	private AnimatedSprite2D? _animatedPlayer = null;
	private Camera2D? _camera = null;
	private Window? _window = null;
	private HurtboxComponent? _hurtbox = null;
	private Weapon? _weapon = null;

	private PackedScene? _ammo = null;
	private WeaponResource? _currentWeaponResource = null;
	private AmmoResource? _currentAmmoResource = null;


	private void _initialiseNodes()
	{
		_animatedPlayer = GetNode<AnimatedSprite2D>("Animations");
		_camera = GetNode<Camera2D>("Camera2D");
		_window = GetWindow();
		_hurtbox = GetNode<HurtboxComponent>("HurtboxComponent");
		_weapon = GetNode<Weapon>("Weapon");

		_ammo = GD.Load<PackedScene>("res://scenes/ammo.tscn");
		_currentWeaponResource = ResourceLoader.Load<WeaponResource>("res://resources/weapons/bow.tres");
		_currentAmmoResource = ResourceLoader.Load<AmmoResource>("res://resources/ammos/arrow.tres");
	}

	// The player itself only collides with walls.
	// Its hurtbox is collided with enemies.
	private void _setMasksAndLayers()
	{
		CollisionLayer = Constants.Instance.LAYER_1_PLAYER;
		CollisionMask = Constants.Instance.LAYER_4_WALLS;

		if (_hurtbox != null)
		{
			_hurtbox.CollisionLayer = Constants.Instance.LAYER_1_PLAYER;
			_hurtbox.CollisionMask = Constants.Instance.LAYER_2_ENEMY;
		}
	}

	// Allows the camera to be clamped by the size of the background
	private void _setCameraLimits()
	{
		if (_window == null || _camera == null)
		{
			GD.Print("Cannot calculate camera limits because window or camera is null");
			return;
		}
		Vector2I windowSize = _window.ContentScaleSize;
		_camera.LimitLeft = 0;
		_camera.LimitRight = windowSize.X;
		_camera.LimitTop = 0;
		_camera.LimitBottom = windowSize.Y;
	}

	private void _setupCamera()
	{
		if (_camera == null)
		{
			GD.Print("Cannot setup camera because camera is null");
			return;
		}

		_setCameraLimits();
		_camera.PositionSmoothingEnabled = true;
	}

	private void _setupWeapon(WeaponResource? weaponResource)
	{
		if (_weapon == null || weaponResource == null)
		{
			GD.Print("Cannot setup weapon because weapon or weaponResource is null");
			return;
		}

		GD.Print($"Switching to weapon {weaponResource.Name}");
		_weapon.LoadWeapon(weaponResource);
		_currentWeaponResource = weaponResource;
	}

	private void _processMovement()
	{
		if (_isDead)
		{
			return;
		}


		Vector2 inputDirection = Input.GetVector("left", "right", "top", "down");
		Velocity = inputDirection * _SPEED;

		if (_animatedPlayer == null)
		{
			GD.Print("Cannot process movement correctly because animatedPlayer is null");
		}
		else
		{
			_animatedPlayer.FlipH = inputDirection.X < 0;

			if (inputDirection == Constants.Instance.NOT_MOVING)
			{
				_animatedPlayer.Play("idle");
			}
			else
			{
				_animatedPlayer.Play("run");
			}
		}

		MoveAndSlide();
	}

	private void _processWeaponSwitch()
	{
		if (Input.IsActionJustPressed("bow"))
		{
			WeaponResource weaponResource = GD.Load<WeaponResource>("res://resources/weapons/bow.tres");
			AmmoResource ammoResource = GD.Load<AmmoResource>("res://resources/ammos/arrow.tres");
			_setupWeapon(weaponResource);
			_currentAmmoResource = ammoResource;
			EmitSignal(Signals.SignalName.WeaponSwitch, _currentWeaponResource, "1");
		}
		else if (Input.IsActionJustPressed("wand"))
		{
			WeaponResource weaponResource = GD.Load<WeaponResource>("res://resources/weapons/wand.tres");
			AmmoResource ammoResource = GD.Load<AmmoResource>("res://resources/ammos/magic_ball.tres");
			_setupWeapon(weaponResource);
			_currentAmmoResource = ammoResource;
			EmitSignal(Signals.SignalName.WeaponSwitch, _currentWeaponResource, "2");
		}
	}

	private void _processShoot()
	{
		if (!Input.IsActionJustPressed("shoot"))
		{
			return;
		}

		Ammo ammoInstance = _ammo.Instantiate<Ammo>();
		GetTree().Root.AddChild(ammoInstance);

		Vector2 direction = (GetGlobalMousePosition() - GlobalPosition).Normalized();
		EmitSignal(Signals.SignalName.Shoot, GlobalPosition, _currentAmmoResource, direction);
	}

	private void _onDeath(Node entity)
	{
		if (entity != this)
		{
			return;
		}

		GD.Print("Player died.");
		QueueFree();
		GD.Print("GAME OVER");
		GetTree().ReloadCurrentScene();
	}

	private void _connectSignals()
	{
		Signals.Instance.IsDead += _onDeath;
	}

	public override void _Ready()
	{
		base._Ready();

		_initialiseNodes();
		_setMasksAndLayers();
		_setupCamera();
		_connectSignals();
		_setupWeapon(_currentWeaponResource);
		if (_animatedPlayer != null)
		{
			_animatedPlayer.Play("idle");
		}
	}

	public override void _PhysicsProcess(double delta)
	{
		_processMovement();
		_processWeaponSwitch();
		_processShoot();
	}
}
