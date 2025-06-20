using Godot;
using System;

public partial class Signals : Node
{
    // TODO: AmmoResource
    [Signal]
    public delegate void ShootEventHandler(Vector2 shootingPosition, AmmoResource ammoResource, Vector2 direction);
    [Signal]
    public delegate void IsDeadEventHandler(Node entity);
    // TODO: WeaponResource
    [Signal]
    public delegate void WeaponSwitchEventHandler(WeaponResource weaponResource, String shortcut);
    [Signal]
    public delegate void StatFoundEventHandler(StatResource statResource);
}
