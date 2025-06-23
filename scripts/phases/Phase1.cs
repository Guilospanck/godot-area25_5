#nullable enable
using Godot;

public partial class Phase1 : Node
{

	private StatManager? _statManager = null;

	public override void _Ready()
	{
		_statManager = GetNode<StatManager>("StatManager");
		_statManager.SpawnRandom(this, 8);
	}
}
