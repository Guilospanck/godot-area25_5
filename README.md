# Godot Area 25.5

Godot version of the [Bevy's Area 25.5](https://github.com/Guilospanck/area-25-5) game.

## Installing with neovim

Follow [this instructions](https://www.reddit.com/r/neovim/comments/1c2bhcs/godotgdscript_in_neovim_with_lsp_and_debugging_in/).

### Debugging with neovim

You can either do it from Godot side or from neovim side. Start the debug via the `F5` (check your debug neovim plugin shortcut for that). Add breakpoint is `<leader>B` (again, my shortcut).


## Godot: fundamental concepts

### Comparison to ECS

If you compare to an ECS system, it would be something like:

- Scene: Entity;
- Nodes: Components;
- Signals: Systems (kinda);

- Scene: it's like an Entity. It can be a player, a weapon, an ammo, a full level. Anything. It can have as many information (nodes - components) as you wish. It can be reused. They can also be parent or children of other scenes (a player in a level, for example). When you reuse a Scene (i.e. you place it into another Scene), it basically turns into a Node of that Scene.

- Nodes: it's like a Component. Basically everything other than Scenes are Nodes. Examples: Sprite, Camera, Collisions and so on. Scenes are composed of Nodes. "Game's smaller building block".

- Signals: it's like Systems. They are events that are emitted by Nodes so they can communicate (like an event-based approach, enabling decoupling).

### Nodes dealing with physics (2D)

- Area2D: just area to detect collisions;
- StaticBody2D: has collisions but cannot move;
- CharacterBody2D: has collisions and can move (via code);
- RigidBody2D: has collisions and can move (via physics).

* All of them need a collision shape.

### Monitoring vs Monitorable

The monitoring property of an Area2D node determines if it actively checks for collisions, while monitorable determines if it can be detected by other Area2D nodes.

