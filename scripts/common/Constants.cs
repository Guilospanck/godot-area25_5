using Godot;
using System;

public partial class Constants : Node
{
    // Autoloaded
    public static Constants Instance { get; private set; }

    // Values
    public Vector2 NOT_MOVING { get; private set; } = new Vector2(0, 0);

    public float VIEWPORT_CUSHION_OFFSET { get; private set; } = 20.0f;

    // Layers and Masks
    public uint LAYER_0_NONE { get; private set; } = 0;
    public uint LAYER_1_PLAYER { get; private set; } = 1;
    public uint LAYER_2_ENEMY { get; private set; } = 2;
    public uint LAYER_3_AMMO { get; private set; } = 4;
    public uint LAYER_4_WALLS { get; private set; } = 8;
    public uint LAYER_5_ITEMS { get; private set; } = 16;

    public override void _Ready()
    {
        base._Ready();
        if (Instance is null)
        {
            Instance = this;
        }
    }
}
