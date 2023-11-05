extends Area2D
signal hit

@export var speed = 400 # How fast the player will move (pixels/sec).
@export var Projectile : PackedScene
var world

var screen_size # Size of the game window.

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	world = get_tree().get_root()

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
		
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)
	
	if velocity.x != 0:
		$AnimatedSprite2D.animation = "walk"
		self.scale.x = -1 if (velocity.x < 0) else 1
		
	if Input.is_action_just_pressed("shoot"):
		if self.visible:
			shoot()


func _on_body_entered(body):
	hide() # Player disappears after being hit.
	hit.emit()
	# Must be deferred as we can't change physics properties on a physics callback.
	$CollisionShape2D.set_deferred("disabled", true)

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
	
func shoot():
	var projectile = Projectile.instantiate()
	projectile.position = $Muzzle.get_global_position()
	projectile.set_direction(Vector2(1, 0) * self.scale.x)
	world.add_child(projectile)
