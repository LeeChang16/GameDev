extends Node2D

# Called when the node enters the scene tree for the first time.
@onready var animation = get_node("CharacterBody2D/CollisionShape2D/AnimatedSprite2D")
@onready var shardanimation = get_node("CharacterBody2D/CollisionShape2D/AnimatedSprite2D2")
const POINTS = 1
var chestOpened = false
var collect_audio

func _ready():
	shardanimation.hide()
	collect_audio = get_node("CharacterBody2D/CollisionShape2D/AnimatedSprite2D2/Collect_audio")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_area_2d_body_entered(body):
	if body.name == "adventurer" and not chestOpened:
		# Play chest opening animation
		animation.play('chest')
		chestOpened = true

		# Show and play shard animation
		shardanimation.show()
		shardanimation.play('sharrd')

func _on_collect_shard_body_entered(body):
	if body.name == "adventurer" and chestOpened:
		body.collect_shard(POINTS)
		collect_audio.play()
		# Adventurer entered the area after chest opened, handle shard interaction
		# Hide or remove the shard, or any other interaction logic
		shardanimation.queue_free()
		
		
		# Alternatively, you can queue_free() to remove the shard from the scene

