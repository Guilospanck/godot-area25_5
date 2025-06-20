#nullable enable
using System.Linq;
using Godot;

public partial class StatManager : Node
{
    [Export]
    public Godot.Collections.Array<StatResource> StatsResources
    {
        get; set;
    } = [];

    private RandomNumberGenerator _rng = new RandomNumberGenerator();

    private PackedScene _stat = GD.Load<PackedScene>("res://scenes/stat.tscn");

    public void SpawnRandom(Node where, int count)
    {
        int statsLength = StatsResources.Count;
        if (statsLength == 0)
        {
            return;
        }

        if (Utils.Instance == null)
        {
            GD.Print("Cannot spawn stats because `Utils` is null.");
            return;
        }

        ViewportBoundaries boundaries = Utils.Instance.GetViewportBoundaries(where);

        foreach (var i in Enumerable.Range(0, count))
        {
            StatResource res = StatsResources[i % statsLength];
            var statInstance = _stat.Instantiate<Stat>();

            float randomX = _rng.RandfRange(boundaries.MinX, boundaries.MaxX);
            float randomY = _rng.RandfRange(boundaries.MinY, boundaries.MaxY);

            where.AddChild(statInstance);
            statInstance.LoadStat(res);
            statInstance.Position = new Vector2(randomX, randomY);
        }

    }

}
