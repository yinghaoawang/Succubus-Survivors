extends RigidBody2D

signal hit

@export var speed = 400 # How fast the player will move (pixels/sec).
@export var TargetProjectile: PackedScene = preload("res://scenes/projectiles/TargetProjectile.tscn")
@export var OrbitProjectile: PackedScene = preload("res://scenes/projectiles/OrbitProjectile.tscn")
var main

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func set_main(_main):
	main = _main

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2.ZERO # The player's movement vector.
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
		
	if !self.visible:
		return
		
	move_and_collide(Vector2(velocity.x * delta, velocity.y * delta))
	# position = position.clamp(Vector2.ZERO, screen_size)
	
	if velocity.x != 0:
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.flip_h = true if (velocity.x < 0) else false


func _on_body_entered(body):
	if body.is_in_group("mobs"):
		hide() # Player disappears after being hit.
		hit.emit()
		$CollisionShape2D.set_deferred("disabled", true)
		get_tree().call_group("projectiles", "queue_free") # Clear projectiles

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
	
	
func shoot():
	# TODO: Also remove the bullets that miss so game doesn't crash or slow down
	if !self.visible:
		return
	
	var mob_group = get_tree().get_nodes_in_group("mobs")
	var closest_mob = null
	var closest_distance = 9999999  # Initialize to a large value
	
	for mob in mob_group:
		var mob_position = mob.global_position
		var distance = mob_position.distance_to(position)
		
		if distance < closest_distance:
			closest_mob = mob
			closest_distance = distance

	if closest_mob == null:
		return

	var projectile = TargetProjectile.instantiate()
	projectile.position = self.get_global_position()
	projectile.set_direction((closest_mob.position - position).normalized())
	main.add_child(projectile)
	
	
