extends TextureProgressBar

#initialize player here

# @export var player: Adventurer
var adventurer 

# Called when the node enters the scene tree for the first time.
func _ready():
	adventurer = get_node("adventurer")
	adventurer.healthChanged.connect(update)
	update()
	
	
func update():
	value = adventurer.currentHealth * 100 / adventurer.maxHealth
