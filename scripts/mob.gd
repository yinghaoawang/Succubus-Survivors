extends RigidBody2D

var player
const MOVE_SPEED = 100  # Adjust the mob's movement speed

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if player and player.visible:
		# Calculate the direction from the mob to the player
		var direction = (player.global_position - global_position).normalized()
		# Move the mob towards the player
		move_and_collide(direction * MOVE_SPEED * delta)
	
func set_player(_player):
	player = _player
