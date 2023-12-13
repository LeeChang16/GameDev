extends Node2D

@onready var animation = get_node("CharacterBody2D/CollisionShape2D/AnimatedSprite2D")
# Called when the node enters the scene tree for the first time.
func _ready():
	animation.play("portal")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_body_entered(body):
	if body.name == "adventurer":
		get_tree().change_scene_to_file("res://world3.tscn")
