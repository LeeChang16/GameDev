extends Node2D

var speed = 50  # Adjust the speed as needed
var direction = Vector2.LEFT
var change_direction_timer = 3.0  # Adjust the time interval for changing direction

@onready var animation = get_node("CharacterBody2D/CollisionShape2D/AnimatedSprite2D")

func _process(delta):
	# Move the frog
	var velocity = direction * speed * delta
	position += velocity
	animation.play("frog_jump")

	# Update the timer
	change_direction_timer -= delta

	# Change direction when the timer reaches zero
	if change_direction_timer <= 0:
		direction = -direction
		animation.play("frog_jump")
		animation.scale.x *= -1  # Flip the sprite to match the new direction
		change_direction_timer = 3.0  # Reset the timer
