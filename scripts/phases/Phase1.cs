#nullable enable
using Godot;

public partial class Phase1 : Node
{

	private StatManager? _statManager = null;

	public override void _Ready()
	{
		_statManager = GD.Load<StatManager>("StatManager");
		_statManager.SpawnRandom(this, 8);
	}
}
