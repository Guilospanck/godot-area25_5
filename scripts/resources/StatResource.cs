using Godot;
using System;

public partial class StatResource : Resource
{
	[Export]
	public String Name;

	[ExportCategory("Stat orientation")]
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
	public int Stat; // TODO: change

	[ExportCategory("Collision")]
	[Export]
	public Shape2D CollisionShape;
}
