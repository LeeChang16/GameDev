extends TextureProgressBar

#initialize player here

@export var player: adventurer
#var adventurer 

# Called when the node enters the scene tree for the first time.
func _ready():
	
	player.healthChanged.connect(update)
	update()
	
	
func update():
	value = player.currentHealth * 100 / player.maxHealth
