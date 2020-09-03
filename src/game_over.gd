extends Label


# Stores reference to the player
var player: Node

# Set to true when the game ends
var ended = false


# Called once when the scene reloads
func _ready():
	# Turn time back on
	Engine.time_scale = 1.0
	# Connect player killed signal to check_end
	player = get_tree().get_nodes_in_group("Player")[0]
	player.connect("killed", self, "check_end")
	check_end()

# Called each time the player dies
func check_end():
	# If the player is out of lives
	if player.lives <= 0:
		# Show the game over text
		ended = true
		visible = true
		# Turn off time
		Engine.time_scale = 0.0

# Called repeatedly over time
func _process(delta):
	# If the game is over and next is pressed
	if ended and Input.is_action_pressed("ui_accept"):
		# Restart the game
		get_tree().reload_current_scene()
