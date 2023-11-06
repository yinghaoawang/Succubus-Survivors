extends Area2D

@export var SPEED = 120
@export var DISTANCE_FROM_PLAYER = 250
var target

func set_target(_target):
	target = _target

func _physics_process(delta):
	rotation_degrees += SPEED * delta
	var rads = deg_to_rad(rotation_degrees)
	var relative_position = Vector2(cos(rads), sin(rads))
	position = target.get_global_position() + relative_position * DISTANCE_FROM_PLAYER
	

func _on_body_entered(body):
	if body.is_in_group("mobs"):
		body.queue_free()
