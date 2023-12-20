extends CharacterBody2D

class_name adventurer

signal healthChanged
signal collectShard
#commnet  
var SPEED = 300.0
var JUMP_VELOCITY = -580.0

#Double Jump
var prevX=0
var prevY=0
var has_double_jump=false
var animation_locked= false
var direction
var was_in_air= false
var facing_right=true
var new_game=false;

#To give priority to the current animation and pause other animation
var animation_play = true

#Shard Bar
#@export var collected = 0
#@export var maxShard = 6
#@onready var currentShard: int = collected

#Health Bar
#@export var maxHealth = 100
#@onready var currentHealth: int = maxHealth



# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

#audio_effects
var hit
var air_hit
var jump_audio

var is_alive = true
var die_locked = false
var has_attacked = false
var enemy_inside = false

var slime1
var enemy1 = false

var slime2
var enemy2 = false

var slime3
var enemy3 = false

var slime4
var enemy4 = false

const PLAYER_DAMAGE_AMOUNT = 20
var damage: int = PLAYER_DAMAGE_AMOUNT

@onready var anim= get_node("CollisionShape2D/AnimatedSprite2D")
func _ready():	
	
	hit = get_node("CollisionShape2D/AnimatedSprite2D/hit")
	air_hit = get_node("CollisionShape2D/AnimatedSprite2D/air_hit")
	jump_audio = get_node("CollisionShape2D/AnimatedSprite2D/jump")
	
	slime1 = get_node("/root/Node2D/StaticBody2D/slime1")
	slime2 = get_node("/root/Node2D/StaticBody2D/slime2")
	slime3 = get_node("/root/Node2D/StaticBody2D/slime3") 
	slime4 = get_node("/root/Node2D/StaticBody2D/slime4")
	
	if animation_play and is_alive:
		anim.play('idle')
	else:
		anim.play("die")
		
func _process(delta):

	if Globals.currentHealth <= 0:
		is_alive = false

	if is_alive:
		if not is_on_floor():
			velocity.y += gravity * delta
			was_in_air=true
		
		else:
			has_double_jump=false
			if was_in_air:
				land()	
				was_in_air=false;
	
		if Input.is_action_just_pressed("attack"):
			attack()
		
	
		if Input.is_action_just_pressed("ui_accept"):
		#double jump
			if is_on_floor():
				jump()
			elif not has_double_jump:
				double_jump()
			
			
		direction = Input.get_axis("ui_left", "ui_right")		
		#animation for jump
		if not is_on_floor():
			jump_anim(delta)
#			jump_anim(delta)	
		prevX= position.x
		prevY=position.y
		
		move_and_slide()
		update_facing_sprite()
		update_animation()
		
		if enemy_inside and has_attacked:
			if enemy1:
				slime1.enemy_take_damage(damage)
				has_attacked = false
			if enemy2:
				slime2.enemy_take_damage(damage)
				has_attacked = false
			if enemy3:
				slime3.enemy_take_damage(damage)
				has_attacked = false
			if enemy4:
				slime4.enemy_take_damage(damage)
				has_attacked = false
		else:
			has_attacked=false
		
	else:
		if not die_locked:
			anim.play("die")
			die_locked = true
	
	
	
	
	
func update_animation():
	if not animation_locked:
		if direction:
			velocity.x = direction * SPEED
			if is_on_floor() and animation_play:
				anim.play('run')	
#				print(direction)	
				
				print("pressed run")
		else:
			if is_on_floor() and animation_play: 
				
				anim.play('idle')
					
					
				velocity.x = move_toward(velocity.x, 0, SPEED)
	#		else:
	#			velocity.x = move_toward(velocity.x, 0, SPEED)	
		
func update_facing_sprite():
	if direction:
		if direction < 0: # Check if moving left
			anim.flip_h = true # Flip the character horizontally
			facing_right=false
		else:
			anim.flip_h = false # Otherwise, don't flip
			facing_right=true
			
func jump_anim(delta):
	if not animation_locked:
		if position.y<prevY:
			anim.play("jump_air")
		else:
			anim.play("jump_down")
			velocity.x = direction * SPEED*0.5
			
	
	
func jump():
	anim.play("jump_up")
	jump_audio.play()
	velocity.y = JUMP_VELOCITY
	animation_locked=true
	
func double_jump():
	anim.play("jump_double")
	jump_audio.play()
	velocity.y = JUMP_VELOCITY*0.6
	has_double_jump=true
	animation_locked=true
	
func land():
	anim.play("jump_land")
	velocity.x = move_toward(velocity.x, 0, SPEED)
	








#Function to handle the Player's Attack
func attack():
	# Check if the character is on the ground
	if is_on_floor():
		# Play attack animation
		animation_play = false
		
		anim.play("attack_1")
		has_attacked = true
		hit.play()
		
		print("Land_Attack")
		# Add logic to deal damage to enemies or perform other attack actions
		# For simplicity, let's assume dealing damage to an enemy (you should replace this logic)
		
	else:
		
		animation_play = false
		anim.play("air_attack_1")
		air_hit.play()
		print("Air Attack")

		deal_damage_to_enemy()








func deal_damage_to_enemy():
	pass


func collect_shard(amount: int):
	Globals.currentShard +=amount
	collectShard.emit()
	
	#to handle adtional logics
	if Globals.currentShard == Globals.maxShard:
		pass



# Function to handle the player taking damage
func take_damage(amount: int):
	Globals.currentHealth -= amount
	print(Globals.currentHealth)
	healthChanged.emit()
	# Ensure health doesn't go below zero
	#currentHealth = max(0, currentHealth)
	
	# Emit the healthChanged signal with the updated health values
	#emit_signal("healthChanged", currentHealth, maxHealth)

	# Add logic to handle player death if needed
	if Globals.currentHealth == 0:
		on_player_death()



# Add any additional logic for player death here
func on_player_death():
	# For example, reload the scene or show a game over screen
	pass




#Function to handle the animation lock
func _on_animated_sprite_2d_animation_finished():
#	print("anim",anim.animation)
	if(anim.animation=="jump_down"):
		animation_locked=false
		print("jump_down")
	if(anim.animation=="jump_up"):
		animation_locked=false
		print("jump_up")
	if(anim.animation=="jump_double"):
		animation_locked=false
		print("jump_double")
	if(anim.animation=="jump_land"):
		animation_locked=false
		print("jump_land")
		
	#To handle the attack animations
	if(anim.animation=="run_punch"):
		animation_play=true
	if(anim.animation=="attack_1"):
		animation_play=true
	if(anim.animation=="air_attack_1"):
		animation_play=true


func _on_attack_range_body_entered(body):
	if body.name == "slime1":
		enemy_inside = true
		enemy1 = true
	elif body.name == "slime2":
		enemy_inside = true
		enemy2 = true
	elif body.name == "slime3":
		enemy_inside = true
		enemy3 = true
	elif body.name == "slime4":
		enemy_inside = true
		enemy4 = true
		
func _on_attack_range_body_exited(body):
	if body.name == "slime1":
		enemy_inside = false
	
	elif body.name == "slime2":
		enemy_inside = false
		
	elif body.name == "slime3":
		enemy_inside = false

	elif body.name == "slime4":
		enemy_inside = false

	
	
