extends RigidBody2D

var player_reference
const MOVE_SPEED = 100  # Adjust the mob's movement speed

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if player_reference and player_reference.visible:
		# Calculate the direction from the mob to the player
		var direction = (player_reference.global_position - global_position).normalized()
		# Move the mob towards the player
		move_and_collide(direction * MOVE_SPEED * delta)
	
func set_player(player):
	player_reference = player
