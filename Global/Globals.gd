extends Node


var test = 10


#For PLayer

@export var collected = 0
@export var maxShard = 6
@onready var currentShard: int = collected

#Health Bar
@export var maxHealth = 100
@onready var currentHealth: int = maxHealth


#For Enemy Slime
@export var slime1_maxHealth = 50
@onready var slime1_currentHealth: int = slime1_maxHealth

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
