using Godot;
using System;

public partial class StatResource : Resource
{
    [Export]
    public String name;

    [ExportCategory("Stat orientation")]
    [Export]
    public Vector2 position;
    [Export]
    public float rotation;
    [Export]
    public Vector2 scale;

    [ExportCategory("Visual settings")]
    [Export]
    public String texturePath;

    [ExportCategory("Metadata")]
    [Export]
    public int stat; // TODO: change

    [ExportCategory("Collision")]
    [Export]
    public Shape2D collisionShape;
}
