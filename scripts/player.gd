extends CharacterBody2D

@onready var animated_player: AnimatedSprite2D = $Animations

const NOT_MOVING: Vector2 = Vector2(0, 0)

# TODO: add this to ammo
# func _on_visible_on_screen_notifier_2d_screen_exited():
#	queue_free()

# TODO: a way of removing all elements belonging to a group
# get_tree().call_group("mobs", "queue_free")

var speed: int = 300

func _ready() -> void:
	animated_player.play("idle")

func process_input():
	var input_dir = Input.get_vector("left", "right", "top", "down")
	velocity = input_dir * speed

	animated_player.flip_h = input_dir.x < 0

	if input_dir == NOT_MOVING:
		animated_player.play("idle")
	else:
		animated_player.play("run")

	move_and_slide()

func _physics_process(_delta: float):
	process_input()

