using Godot;
using System;

public partial class Signals : Node
{
    // Autoloaded
    public static Signals Instance { get; private set; }

    [Signal]
    public delegate void ShootEventHandler(Vector2 shootingPosition, AmmoResource ammoResource, Vector2 direction);

    [Signal]
    public delegate void IsDeadEventHandler(Node entity);

    [Signal]
    public delegate void WeaponSwitchEventHandler(WeaponResource weaponResource, String shortcut);

    [Signal]
    public delegate void StatFoundEventHandler(StatResource statResource);

    public override void _Ready()
    {
        base._Ready();
        if (Instance is null)
        {
            Instance = this;
        }
    }
}

