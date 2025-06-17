extends CharacterBody2D

@onready var animated_enemy: AnimatedSprite2D = $AnimatedSprite2D
@onready var hitbox: HitboxComponent = $HitboxComponent
@onready var hurtbox: HurtboxComponent = $HurtboxComponent

const SPEED: int = 100
const DAMAGE: int = 5

var player: PlayerComponent
var window_size: Vector2i

################################ Signals ######################################
func _on_hitbox_component_body_entered(_body: PlayerComponent) -> void:
	pass
	# print("[ENEMY] _on_hitbox_component_body_entered: " + body.name)
	# TODO: if the enemy would have a meelee weapon, also do some animation
	# TODO: maybe do some hurt animation on the Player

# Hurtbox of the player
func _on_hitbox_component_area_entered(hurtbox_component: HurtboxComponent) -> void:
	hurtbox_component.on_damage(DAMAGE)

########################################################################

# Set the normal and hitbox/hurtbox layers and masks for the Enemy
func set_masks_and_layers():
	collision_layer = Constants.LAYER_2_ENEMY
	collision_mask = Constants.LAYER_0_NONE

	hitbox.collision_layer = Constants.LAYER_2_ENEMY
	hitbox.collision_mask = Constants.LAYER_1_PLAYER

	hurtbox.collision_layer = Constants.LAYER_2_ENEMY
	hurtbox.collision_mask = Constants.LAYER_3_AMMO

func connect_signals():
	hitbox.area_entered.connect(self._on_hitbox_component_area_entered)
	hitbox.body_entered.connect(self._on_hitbox_component_body_entered)

func _ready() -> void:
	animated_enemy.play("idle")

	set_masks_and_layers()
	connect_signals()

	player =  get_tree().get_first_node_in_group("player")

func _physics_process(delta: float) -> void:
	position = position.move_toward(player.global_position, delta * SPEED)
	
	# flip sprite based on the enemy's position in relation to the player's
	var deg_angle_to_player_position = global_position.angle_to_point(player.global_position) * 180/PI
	# the sprite starts facing the other side, hence the negation
	animated_enemy.flip_h = !(deg_angle_to_player_position < 90 && deg_angle_to_player_position > -90)

	move_and_slide()
