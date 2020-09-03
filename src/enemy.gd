extends KinematicBody2D


# Acceleration due to gravity in pixels/second^2
const GRAVITY := 400.0

# Speed at which the player moves horizantally in pixels/second
const MOVE_SPEED := 200.0


# Current velocity the player is moving at
var velocity := Vector2.ZERO

# Reference to the player
var player: Node

# Stores the position the enemy spawns at
var spawn_pos: Vector2


# Called once when the game begins
func _ready():
	spawn_pos = global_position
	# Get the first member of the "Player" group
	player = get_tree().get_nodes_in_group("Player")[0]
	# Connect the player killed signal to reset
	player.connect("killed", self, "reset")

# Runs every 1/60th of the 
func _physics_process(delta):
	# Set horizantal speed to MOVE_SPEED in the direction the player is inputting
	var dir_to_player = (player.global_position - global_position).normalized()
	velocity.x = sign(dir_to_player.x) * MOVE_SPEED
	
	# Apply acceleration due to gravity
	velocity.y += GRAVITY * delta
	
	# Actually apply the movement
	velocity = move_and_slide(velocity, Vector2.UP)

# Move the enemy back to their starting position
func reset():
	global_position = spawn_pos

# Called by other scripts to kill the player
func kill():
	# Remove the enemy node from the world
	queue_free()
