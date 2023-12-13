extends Node2D


# Called when the node enters the scene tree for the first time.
@onready var animation = get_node("CharacterBody2D/CollisionShape2D/AnimatedSprite2D")
@onready var shardanimation = get_node("CharacterBody2D/CollisionShape2D/AnimatedSprite2D2")

func _ready():
	shardanimation.hide()
pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_body_entered(body):
	if body.name == "adventurer":
		animation.play('chest')
		
		# Show and play coin animation
		shardanimation.show()
		shardanimation.play('sharrd')
	pass # Replace with function body.
