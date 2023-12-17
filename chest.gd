extends Node2D

# Called when the node enters the scene tree for the first time.
@onready var animation = get_node("CharacterBody2D/CollisionShape2D/AnimatedSprite2D")
@onready var shardanimation = get_node("CharacterBody2D/CollisionShape2D/AnimatedSprite2D2")

var chestOpened = false

func _ready():
	shardanimation.hide()

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
		# Adventurer entered the area after chest opened, handle shard interaction
		# Hide or remove the shard, or any other interaction logic
		shardanimation.queue_free()
		# Alternatively, you can queue_free() to remove the shard from the scene

