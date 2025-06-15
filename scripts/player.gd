extends CharacterBody2D

@onready var animated_player: AnimatedSprite2D = $Animations

var speed: int = 300

func _ready() -> void:
	animated_player.play("idle")


func get_input():
	var input_dir = Input.get_vector("left", "right", "top", "down")
	velocity = input_dir * speed

func _physics_process(delta):
	get_input()
	move_and_collide(velocity * delta)
