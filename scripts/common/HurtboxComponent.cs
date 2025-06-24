#nullable enable
// Hurtboxes are monitorable
using Godot;

public partial class HurtboxComponent : Area2D
{
	// TODO: add this to a HealthComponent
	[Export]
	int Health { get; set; } = 100;
	// TODO: add modular particle component to play after death

	private Node? _parent { get; set; } = null;

	public void OnDamage(int damage)
	{
		if (_parent == null)
		{
			GD.Print("Cannot take damage because parent is null");
			return;
		}

		Health -= damage;
		GD.Print($"{_parent.Name} took {damage}. Current health: {Health}");
		if (Health <= 0)
		{
			Signals.Instance.EmitSignal(Signals.SignalName.IsDead, _parent);
		}

	}

	public override void _Ready()
	{
		base._Ready();
		_parent = GetParent();
	}

}
