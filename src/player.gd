extends KinematicBody2D


# Acceleration due to gravity in pixels/second^2
const GRAVITY := 400.0

# Speed at which the player moves horizantally in pixels/second
const MOVE_SPEED := 300.0
# Speed which the player gets when they jump
const JUMP_SPEED := 400.0


# Signal which notifies enemies that the player was killed
signal killed()


# Current velocity the player is moving at
var velocity := Vector2.ZERO

# Number of lives the player has
var lives = 3

# Position the player starts at
var spawn_pos: Vector2


# Runs once when the game starts
func _ready():
	spawn_pos = global_position

# Runs every 1/60th of the 
func _physics_process(delta):
	# Set horizantal speed to MOVE_SPEED in the direction the player is inputting
	var horizantal = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	velocity.x = horizantal * MOVE_SPEED
	
	# Apply acceleration due to gravity
	velocity.y += GRAVITY * delta
	
	# If jump was just pressed and we're on the ground, set vertical velocity
	# GAME FEEL TIP: 
	# Buffer jump input for a bit of time, so it reacts if the player hits jump before landing
	if Input.is_action_just_pressed("move_jump") and is_on_floor():
		# NOTE: Negative velocity => UP
		velocity.y = -JUMP_SPEED
	
	# Actually apply the movement
	# NOTE: Velocity is set to result of calling move_and_slide
	# This will, e.g. zero the velocity when the player hits something
	velocity = move_and_slide(velocity, Vector2.UP)

# Called by other scripts to kill the player
func kill():
	lives -= 1
	global_position = spawn_pos
	emit_signal("killed")
