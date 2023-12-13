extends Node2D

var speed = 50
var direction = Vector2.RIGHT
var change_direction_timer = 2.0

@onready var animation = $CharacterBody2D/CollisionShape2D/AnimatedSprite2D
var is_player_inside = false

func _process(delta):
	if is_player_inside:
		# Stop moving and play attack animation when the player is inside the area
		direction = 0
		animation.play("skeleton_attack")
	else:
		# Move the slime when the player is outside the area
		var velocity = direction * speed * delta
		position += velocity

		# Update the timer
		change_direction_timer -= delta

		# Change direction when the timer reaches zero
		if change_direction_timer <= 0:
			direction = -direction
			animation.play("skeleton_walk")
			animation.scale.x *= -1  # Flip the sprite to match the new direction
			change_direction_timer = 2.0  # Reset the timer

func _on_area_2d_body_entered(body):
	if body.is_in_group("adventurer"):
		is_player_inside = true

func _on_area_2d_body_exited(body):
	if body.is_in_group("adventurer"):
		is_player_inside = false
		# Reset the direction and resume moving when the player exits the area
		direction = Vector2.LEFT
		change_direction_timer = 2.0
		animation.play("skeleton_walk")
