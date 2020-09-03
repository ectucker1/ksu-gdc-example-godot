extends Label


# Reference to the player
var player: Node


# Called once when the game begins
func _ready():
	# Connect the player killed signal
	player = get_tree().get_nodes_in_group("Player")[0]
	player.connect("killed", self, "update_lives")
	
	update_lives()

# Called whenever the player is killed
func update_lives():
	text = "Lives: " + str(player.lives)
