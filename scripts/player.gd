class_name PlayerComponent
extends CharacterBody2D

@onready var animated_player: AnimatedSprite2D = $Animations
@onready var camera: Camera2D = $Camera2D
@onready var window: Window = get_window()

@onready var hitbox: HitboxComponent = $HitboxComponent
@onready var hurtbox: HurtboxComponent = $HurtboxComponent

# TODO: add this to ammo
# func _on_visible_on_screen_notifier_2d_screen_exited():
#	queue_free()

# TODO: a way of removing all elements belonging to a group
# get_tree().call_group("mobs", "queue_free")

const SPEED: int = 300

# Allows the camera to be clamped by the size of the background
func set_camera_limits():
	var window_size: Vector2i = window.content_scale_size

	camera.limit_left = 0
	camera.limit_right = window_size.x

	camera.limit_top = 0
	camera.limit_bottom = window_size.y

func process_input():
	var input_dir: Vector2 = Input.get_vector("left", "right", "top", "down")
	velocity = input_dir * SPEED 

	animated_player.flip_h = input_dir.x < 0

	if input_dir == Constants.NOT_MOVING:
		animated_player.play("idle")
	else:
		animated_player.play("run")

	move_and_slide()

# Set the normal and hitbox/hurtbox layers and masks for the Player
func set_masks_and_layers():
	collision_layer = Constants.LAYER_1_PLAYER
	collision_mask = Constants.LAYER_4_WALLS

	hitbox.collision_layer = Constants.LAYER_1_PLAYER
	hitbox.collision_mask = Constants.LAYER_2_ENEMY

	hurtbox.collision_layer = Constants.LAYER_1_PLAYER
	hurtbox.collision_mask = Constants.LAYER_2_ENEMY

func _ready() -> void:
	animated_player.play("idle")
	set_camera_limits()
	set_masks_and_layers()

func _physics_process(_delta: float):
	process_input()
