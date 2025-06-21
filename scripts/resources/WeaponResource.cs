using Godot;
using System;

public partial class WeaponResource : Resource
{

    [Export]
    public String Name;

    [ExportCategory("Weapon orientation")]
    [Export]
    public Vector2 Position;
    [Export]
    public float Rotation;
    [Export]
    public Vector2 Scale;

    [ExportCategory("Visual settings")]
    [Export]
    public String TexturePath;

    [ExportCategory("Metadata")]
    [Export]
    public int Damage;

}
