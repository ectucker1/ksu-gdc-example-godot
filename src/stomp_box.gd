extends Area2D


# Called when a body is entered
# Must be setup to connect to signal from editor
func _on_body_entered(body):
	# If an enemy enters the area, kill them
	if body.is_in_group("Enemy"):
		body.kill()
