extends CharacterBody2D

@onready var animated_enemy: AnimatedSprite2D = $AnimatedSprite2D

const SPEED: int = 100

var player: CharacterBody2D
var window_size: Vector2i

func _ready() -> void:
	animated_enemy.play("idle")
	player =  get_tree().get_first_node_in_group("player")

func _physics_process(delta: float) -> void:
	position = position.move_toward(player.global_position, delta * SPEED)
	
	var deg_angle_to_player_position = global_position.angle_to_point(player.global_position) * 180/PI
	# the sprite starts facing the other side
	animated_enemy.flip_h = !(deg_angle_to_player_position < 90 && deg_angle_to_player_position > -90)

	move_and_slide()
