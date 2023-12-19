extends TextureProgressBar

#initialize player here

@export var player: adventurer
#var adventurer 
#var value1
# Called when the node enters the scene tree for the first time.
func _ready():
	
	player.collectShard.connect(update)
	update()
	
	
func update():
	#value 
	#value1 = player.collectShard / player.maxShard
	value = Globals.currentShard * 100 / Globals.maxShard
