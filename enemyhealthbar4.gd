extends TextureProgressBar

#initialize player here

@export var enemy: slime4
#var adventurer 

# Called when the node enters the scene tree for the first time.
func _ready():
	
	enemy.slime4_healthChanged.connect(update)
	update()
	
	
func update():
	value = Globals.slime4_currentHealth * 100 / Globals.slime4_maxHealth
	print(Globals.slime4_currentHealth)
	print(value)
