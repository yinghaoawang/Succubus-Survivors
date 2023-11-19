extends Area2D

var speed = 750
var direction

func set_direction(d):
	direction = d

func _process(delta):
	position += direction * speed * delta

func _on_body_entered(body):
	if body.is_in_group("mobs"):
		body.emit_signal("mob_killed")
		queue_free()
		body.queue_free()
		queue_free()

