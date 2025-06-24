# nullable enable
using Godot;
using System;

public record struct ViewportBoundaries
{
    public float MinX { get; init; }
    public float MinY { get; init; }
    public float MaxX { get; init; }
    public float MaxY { get; init; }
};

public partial class Utils : Node
{
    public static Utils? Instance { get; private set; } = null;


    public Node? GetChildComponentOrNull(Node root, Type type)
    {
        foreach (var child in root.GetChildren())
        {
            if (type.IsInstanceOfType(child))
            {
                return child;
            }
        }

        return null;
    }

    public ViewportBoundaries GetViewportBoundaries(Node fromWhere)
    {
        Rect2 rect = fromWhere.GetViewport().GetVisibleRect();

        float viewportCushionOffset = Constants.Instance.VIEWPORT_CUSHION_OFFSET;

        return new ViewportBoundaries
        {
            MinX = 0f + viewportCushionOffset,
            MinY = 0f + viewportCushionOffset,
            MaxX = rect.Size[0] - viewportCushionOffset,
            MaxY = rect.Size[1] - viewportCushionOffset
        };

    }

    public override void _Ready()
    {
        base._Ready();
        if (Instance is null)
        {
            Instance = this;
        }
    }
}
