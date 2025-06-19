class_name PlayerComponent
extends CharacterBody2D

@onready var animated_player: AnimatedSprite2D = $Animations
@onready var camera: Camera2D = $Camera2D
@onready var window: Window = get_window()

@onready var hurtbox: HurtboxComponent = $HurtboxComponent

@onready var weapon: Weapon = $Weapon
@onready var ammo: PackedScene = load("res://scenes/ammo.tscn")

@onready var current_weapon_resource: WeaponResource = preload("res://resources/weapons/bow.tres")
@onready var current_ammo_resource: AmmoResource = preload("res://resources/ammos/arrow.tres")

const SPEED: int = 300
var is_dead := false

# Set the normal and hitbox/hurtbox layers and masks for the Player
func set_masks_and_layers():
	collision_layer = Constants.LAYER_1_PLAYER
	collision_mask = Constants.LAYER_4_WALLS

	hurtbox.collision_layer = Constants.LAYER_1_PLAYER
	hurtbox.collision_mask = Constants.LAYER_2_ENEMY

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
	current_weapon_resource = weapon_res


func process_movement():
	if is_dead:
		return

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
		setup_weapon(load("res://resources/weapons/bow.tres"))
		current_ammo_resource = load("res://resources/ammos/arrow.tres")
		Signals.weapon_switch.emit(current_weapon_resource, "1")
	elif Input.is_action_just_pressed("wand"):
		setup_weapon(load("res://resources/weapons/wand.tres"))
		current_ammo_resource = load("res://resources/ammos/magic_ball.tres")
		Signals.weapon_switch.emit(current_weapon_resource, "2")


func process_shoot():
	if not Input.is_action_just_pressed("shoot"):
		return

	var ammo_instance: Ammo = ammo.instantiate()
	get_tree().root.add_child(ammo_instance)

	var direction = (get_global_mouse_position() - global_position).normalized()

	Signals.shoot.emit(global_position, current_ammo_resource, direction)

func _on_death(entity: Node):
	if entity != self:
		return

	print("Player died")
	queue_free()
	# TODO: Game over
	print("GAME OVER")
	get_tree().reload_current_scene()

func _connect_signals():
	Signals.is_dead.connect(_on_death)

func _ready() -> void:
	_connect_signals()
	setup_weapon(current_weapon_resource)
	set_masks_and_layers()
	animated_player.play("idle")
	setup_camera()

func _physics_process(_delta: float):
	process_movement()
	process_weapon_switch()
	process_shoot()
