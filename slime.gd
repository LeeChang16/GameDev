extends Node2D

var speed = 200
var direction = Vector2.ZERO  # Initially set to zero for idle state
# var follow_range = 350  # Adjust the range based on your needs
var gravity = 500  # Adjust the gravity strength based on your needs

@onready var animation = $CharacterBody2D/AnimatedSprite2D

#var adventurer = get_node("/root/Node2D/StaticBody2D/adventurer")

const SLIME_DAMAGE_AMOUNT = 10
var damage: int = SLIME_DAMAGE_AMOUNT
var is_player_inside = false

func _process(delta):
	# Check if the adventurer node is inside the slime's detection area
	if is_player_inside:
		# Get a reference to the adventurer node
		var adventurer = get_node("/root/Node2D/StaticBody2D/adventurer")  # Adjust the path accordingly
		# Move towards the player when inside the follow range
		direction = adventurer.position - position 
		direction = direction.normalized()
		# Disregard vertical movement
		direction.y = 0
		# Play the follow animation
		animation.play("slime_move")

		# Check if the player is on the ground before updating the slime's position
		if adventurer.is_on_floor():
			# Move the slime based on the direction
			var velocity = direction * speed * delta
			position.x += velocity.x  # Only update the horizontal position

			# Flip the sprite based on the movement direction
			if direction.x > 0:
				animation.scale.x = abs(animation.scale.x) * -1  # Flip horizontally
			elif direction.x < 0:
				animation.scale.x = abs(animation.scale.x)  # Reset to original scale
	else:
		# Handle the case where the player is outside the follow range
		direction = Vector2.ZERO
		animation.play("slime_idle")
	
		# Reset the sprite scale when idle
		animation.scale.x = abs(animation.scale.x)

func _on_area_2d_body_entered(body):
	if body.name =="adventurer":
		is_player_inside = true

func _on_area_2d_body_exited(body):
	if body.name == "adventurer":
		is_player_inside = false


func _on_attack_area_body_entered(body):
	
	# Get a reference to the adventurer node
	#var adventurer = get_node("/root/Node2D/StaticBody2D/adventurer")  # Adjust the path accordingly
	if body.name == "adventurer":
	# Call the take_damage function in the adventurer script
		body.take_damage(damage)
		
	# Add logic for playing the attack animation if needed
	animation.play("slime_attack")

