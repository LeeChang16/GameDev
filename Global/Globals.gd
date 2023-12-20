extends Node


var test = 10


#<<<<<<< HEAD
#For PLayer

#=======
#>>>>>>> 58ead0fd782866083d8dda00362f781baf85dfc6
@export var collected = 0
@export var maxShard = 6
@onready var currentShard: int = collected

#Health Bar
@export var maxHealth = 100
@onready var currentHealth: int = maxHealth

#<<<<<<< HEAD

#For Enemy Slime
@export var slime1_maxHealth = 50
@onready var slime1_currentHealth: int = slime1_maxHealth

@export var slime2_maxHealth = 50
@onready var slime2_currentHealth: int = slime2_maxHealth

@export var slime3_maxHealth = 50
@onready var slime3_currentHealth: int = slime3_maxHealth


@export var slime4_maxHealth = 50
@onready var slime4_currentHealth: int = slime4_maxHealth

#=======
#>>>>>>> 58ead0fd782866083d8dda00362f781baf85dfc6
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
