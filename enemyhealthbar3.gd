extends TextureProgressBar

#initialize player here

@export var enemy: slime3
#var adventurer 

# Called when the node enters the scene tree for the first time.
func _ready():
	
	enemy.slime3_healthChanged.connect(update)
	update()
	
	
func update():
	value = Globals.slime3_currentHealth * 100 / Globals.slime3_maxHealth
	print(Globals.slime3_currentHealth)
	print(value)
