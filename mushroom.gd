extends Node2D

var speed = 50
var direction = Vector2.RIGHT
var change_direction_timer = 4.0

@onready var animation = $CharacterBody2D/CollisionShape2D/AnimatedSprite2D
var is_player_inside = false
var animation_locked = false

func _process(delta):
	# Move the slime when the player is outside the area
	if not is_player_inside:
		var velocity = direction * speed * delta
		position += velocity
		animation.play("mushroom_run")

	# Update the timer
		change_direction_timer -= delta

	# Change direction when the timer reaches zero
		if change_direction_timer <= 0:
			direction = -direction
			animation.play("mushroom_run")
			animation.scale.x *= -1  # Flip the sprite to match the new direction
			change_direction_timer = 4.0  # Reset the timer
	elif is_player_inside:
		if change_direction_timer <= 0:
			animation.scale.x *= -1
			animation.play("mushroom_attack")
			
		else:
			animation.play("mushroom_attack")
		

func _on_area_2d_body_entered(body):
	if body.name == "adventurer":
		#animation.play("mushroom_attack")
		is_player_inside = true
		#direction = Vector2.ZERO
		
		# Stop moving and play attack animation when the player is inside the area


func _on_area_2d_body_exited(body):
	if body.name == "adventurer":
		is_player_inside = false

		#direction = Vector2.RIGHT
		#change_direction_timer = 4.0
		#animation.play("mushroom_run")

