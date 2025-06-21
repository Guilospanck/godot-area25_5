using Godot;
using System;

public partial class AmmoResource : Resource
{

    [Export]
    public String Name;

    [ExportCategory("Ammo orientation")]
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

    [ExportCategory("Collision")]
    [Export]
    public Shape2D CollisionShape;

}
