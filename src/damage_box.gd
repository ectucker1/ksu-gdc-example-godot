extends Area2D


# Called when a body is entered
# Must be setup to connect to signal from editor
func _on_body_entered(body):
	# If the player enters the area, kill them
	if body.is_in_group("Player"):
		body.kill()
