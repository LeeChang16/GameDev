extends TextureProgressBar

#initialize player here

@export var enemy: slime1
#var adventurer 

# Called when the node enters the scene tree for the first time.
func _ready():
	
	enemy.healthChanged.connect(update)
	update()
	
	
func update():
	value = Globals.slime1_currentHealth * 100 / Globals.slime1_maxHealth
	print(Globals.slime1_currentHealth)
	print(value)
