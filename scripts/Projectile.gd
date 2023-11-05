extends Area2D

var speed = 750
var direction

func set_direction(d):
	direction = d

func _physics_process(delta):
	position += direction * speed * delta

func _on_Projectile_body_entered(body):
	if body.is_in_group("mobs"):
		print('kill him')
		body.queue_free()
	queue_free()
