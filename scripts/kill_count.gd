extends Area2D

signal mob_killed

func _on_Area2D_body_entered(body):
	if "player" in body.name:
		emit_signal("mob_killed")
		queue_free()
