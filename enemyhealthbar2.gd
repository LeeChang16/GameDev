extends TextureProgressBar

#initialize player here

@export var enemy: slime2
#var adventurer 

# Called when the node enters the scene tree for the first time.
func _ready():
	
	enemy.slime2_healthChanged.connect(update)
	update()
	
	
func update():
	value = Globals.slime2_currentHealth * 100 / Globals.slime2_maxHealth
	print(Globals.slime2_currentHealth)
	print(value)
