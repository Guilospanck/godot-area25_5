#nullable enable
using Godot;

public partial class Enemy : CharacterBody2D
{
	private AnimatedSprite2D? _animatedEnemy = null;
	private HitboxComponent? _hitbox = null;
	private HurtboxComponent? _hurtbox = null;

	private const float _SPEED = 100.0f;
	private const int _DAMAGE = 5;

	private Player? _player = null;

	private Vector2I? _windowSize = null;


	// ################################ Signals ######################################
	private void _onHitboxComponentBodyEntered(Node2D _body)
	{
		// # TODO: if the enemy would have a meelee weapon, also do some animation
		// # TODO: maybe do some hurt animation on the Player
	}

	// The enemy attacked something
	private void _onHitboxComponentAreaEntered(Area2D area)
	{
		if (area is HurtboxComponent)
		{
			(area as HurtboxComponent).OnDamage(_DAMAGE);
		}
	}

	private void _onDeath(Node entity)
	{
		if (entity != this)
		{
			return;
		}
		GD.Print("Enemy died");
		QueueFree();
	}
	// ########################################################################

	// The enemy itself doesn't collide with anyything, only its hitbox and hurtbox
	private void _setMasksAndLayers()
	{
		CollisionLayer = Constants.Instance.LAYER_2_ENEMY;
		CollisionMask = Constants.Instance.LAYER_0_NONE;

		if (_hitbox != null)
		{
			_hitbox.CollisionLayer = Constants.Instance.LAYER_2_ENEMY;
			_hitbox.CollisionMask = Constants.Instance.LAYER_1_PLAYER;
		}

		if (_hurtbox != null)
		{
			_hurtbox.CollisionLayer = Constants.Instance.LAYER_2_ENEMY;
			_hurtbox.CollisionMask = Constants.Instance.LAYER_3_AMMO; // The player itself can only hurt via ammo
		}
	}

	private void _connectSignals()
	{
		Signals.Instance.IsDead += _onDeath;
		if (_hitbox != null)
		{
			_hitbox.AreaEntered += _onHitboxComponentAreaEntered;
			_hitbox.BodyEntered += _onHitboxComponentBodyEntered;
		}
	}

	private void _initialiseNodes()
	{
		_animatedEnemy = GetNode<AnimatedSprite2D>("AnimatedSprite2D");
		_hitbox = GetNode<HitboxComponent>("HitboxComponent");
		_hurtbox = GetNode<HurtboxComponent>("HurtboxComponent");

		_player = GetTree().GetFirstNodeInGroup("player") as Player;
	}

	public override void _Ready()
	{
		base._Ready();

		_initialiseNodes();
		_setMasksAndLayers();
		_connectSignals();
	}

	public override void _PhysicsProcess(double delta)
	{
		base._PhysicsProcess(delta);


		Position = Position.MoveToward(_player.GlobalPosition, (float)(delta * _SPEED));
		float angleToPlayerInDegrees = GlobalPosition.AngleToPoint(_player.GlobalPosition) * 180 / Mathf.Pi;
		if (_animatedEnemy != null)
		{
			// the sprite starts facing the other side, hence the negation
			_animatedEnemy.FlipH = !(angleToPlayerInDegrees < 90.0 && angleToPlayerInDegrees > -90.0);
		}

		MoveAndSlide();
	}
}
