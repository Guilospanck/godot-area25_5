#nullable enable
using Godot;

[Tool]
public partial class Stat : Area2D
{

    private StatResource? _statResource = null;

    private Sprite2D? _statTexture = null;
    private CollisionShape2D? _collisionShape = null;

    [Export]
    public StatResource? StatResource
    {
        get => _statResource; set
        {
            _statResource = value;
            if (Engine.IsEditorHint())
            {
                GD.Print("In editor");
            }
        }
    }

    public void LoadStat(StatResource? statRes = null)
    {
        var stat = statRes ?? _statResource;
        if (stat == null || _statTexture == null || _collisionShape == null)
        {
            return;
        }

        _statTexture.Texture = ResourceLoader.Load<Texture2D>(stat.texturePath);
        _collisionShape.Shape = stat.collisionShape;

        _statResource = stat;
    }

    private void _onArea2DBodyEntered(Node2D _body)
    {
        if (_statResource == null)
        {
            return;
        }

        EmitSignal(Signals.SignalName.StatFound, _statResource);
        QueueFree();
    }

    // See more on connecting signals: https://docs.godotengine.org/en/stable/classes/class_object.html#class-object-method-connect
    private void _connectSignals()
    {
        this.BodyEntered += _onArea2DBodyEntered;
    }

    private void _setMasksAndLayers()
    {
        CollisionLayer = Constants.Instance.LAYER_5_ITEMS;
        CollisionMask = Constants.Instance.LAYER_1_PLAYER;
    }


    public override void _Ready()
    {
        base._Ready();
        _statTexture = GetNode<Sprite2D>("Sprite2D");
        _collisionShape = GetNode<CollisionShape2D>("CollisionShape2D");

        _connectSignals();
        _setMasksAndLayers();
        LoadStat();
    }
}
