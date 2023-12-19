extends TextureProgressBar

#initialize player here

@export var player: adventurer
#var adventurer 

# Called when the node enters the scene tree for the first time.
func _ready():
	
	player.healthChanged.connect(update)
	update()
	
	
func update():
	value = Globals.currentHealth * 100 / Globals.maxHealth
