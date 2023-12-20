extends Node2D

class_name slime3
 

signal slime3_healthChanged

var speed = 200
var direction = Vector2.ZERO  # Initially set to zero for idle state
# var follow_range = 350  # Adjust the range based on your needs
var gravity = 500  # Adjust the gravity strength based on your needs

#@export var maxHealth = 50
#@onready var currentHealth: int = maxHealth

@onready var animation = $AnimatedSprite2D

#var adventurer = get_node("/root/Node2D/StaticBody2D/adventurer")

const SLIME_DAMAGE_AMOUNT = 10
var damage: int = SLIME_DAMAGE_AMOUNT
var is_player_inside = false
var is_alive = true
var has_died = false

func _process(delta):
	#print(currentHealth)
	if Globals.slime3_currentHealth <= 0:
		is_alive = false
	
	if is_alive:
		
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
	else:
		if not has_died:
			animation.play("slime_die")
			has_died = true
		#else:
		#queue_free()
			
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
		animation.play("slime_attack")
		body.take_damage(damage)
		
	# Add logic for playing the attack animation if needed
	
func enemy_take_damage(amount: int):
	Globals.slime3_currentHealth -= amount
	slime3_healthChanged.emit()
	print(Globals.slime3_currentHealth)
	# Ensure health doesn't go below zero
	#currentHealth = max(0, currentHealth)
	
	# Emit the healthChanged signal with the updated health values
	#emit_signal("healthChanged", currentHealth, maxHealth)

	# Add logic to handle player death if needed
	if Globals.slime3_currentHealth <= 0:
		on_enemy_death()
		
func on_enemy_death():
	# For example, reload the scene or show a game over screen
	pass
