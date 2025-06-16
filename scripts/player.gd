class_name PlayerComponent
extends CharacterBody2D

@onready var animated_player: AnimatedSprite2D = $Animations
@onready var camera: Camera2D = $Camera2D
@onready var window: Window = get_window()

@onready var hitbox: HitboxComponent = $HitboxComponent
@onready var hurtbox: HurtboxComponent = $HurtboxComponent

@onready var weapon: Weapon = $Weapon
@onready var ammo: PackedScene = load("res://scenes/ammo.tscn")

@onready var initial_weapon_resource: WeaponResource = preload("res://resources/bow.tres")
@onready var current_ammo_resource: AmmoResource = preload("res://resources/arrow.tres")

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

func setup_camera():
	set_camera_limits()
	camera.position_smoothing_enabled = true

func setup_weapon(weapon_res: WeaponResource):
	print("Switching to weapon " + weapon_res.name)
	weapon.load_weapon(weapon_res)

func setup_ammo(ammo_res: AmmoResource):
	print("Spawning ammo " + ammo_res.name)

	var ammo_instance: Ammo = ammo.instantiate()
	get_tree().root.add_child(ammo_instance)

	ammo_instance.shoot = true
	ammo_instance.firing_position = global_position
	ammo_instance.towards = get_global_mouse_position() 
	ammo_instance.position = global_position
	ammo_instance.ammo_resource = ammo_res


func process_movement():
	var input_dir: Vector2 = Input.get_vector("left", "right", "top", "down")
	velocity = input_dir * SPEED 

	animated_player.flip_h = input_dir.x < 0

	if input_dir == Constants.NOT_MOVING:
		animated_player.play("idle")
	else:
		animated_player.play("run")

	move_and_slide()

func process_weapon_switch():
	if Input.is_action_just_pressed("bow"):
		setup_weapon(load("res://resources/bow.tres"))
		current_ammo_resource = load("res://resources/arrow.tres")
	elif Input.is_action_just_pressed("wand"):
		setup_weapon(load("res://resources/wand.tres"))
		current_ammo_resource = load("res://resources/magic_ball.tres")

func process_shoot():
	if Input.is_action_just_pressed("shoot"):
		setup_ammo(current_ammo_resource)

# Set the normal and hitbox/hurtbox layers and masks for the Player
func set_masks_and_layers():
	collision_layer = Constants.LAYER_1_PLAYER
	collision_mask = Constants.LAYER_4_WALLS

	hitbox.collision_layer = Constants.LAYER_1_PLAYER
	hitbox.collision_mask = Constants.LAYER_2_ENEMY

	hurtbox.collision_layer = Constants.LAYER_1_PLAYER
	hurtbox.collision_mask = Constants.LAYER_2_ENEMY

func _ready() -> void:
	setup_weapon(initial_weapon_resource)
	set_masks_and_layers()
	animated_player.play("idle")
	setup_camera()

func _physics_process(_delta: float):
	process_movement()
	process_weapon_switch()
	process_shoot()
