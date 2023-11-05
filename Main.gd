extends Node

@export var mob_scene: PackedScene
var time


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func game_over():
	$ElapsedTimer.stop()
	$MobTimer.stop()
	$HUD.show_game_over()

func new_game():
	time = 0
	$Player.start($StartPosition.position)
	$HUD.update_score(time)
	$HUD.show_message("Get Ready")
	$StartTimer.start()


func _on_elapsed_timer_timeout():
	time += 1
	$HUD.update_score(time)
	print(time)

func _on_start_timer_timeout():
	$MobTimer.start()
	$ElapsedTimer.start()

func _on_mob_timer_timeout():
	# Create a new instance of the Mob scene.
	var mob = mob_scene.instantiate()

	# Choose a random location on Path2D.
	var mob_spawn_location = get_node("MobPath/MobSpawnLocation")
	mob_spawn_location.progress_ratio = randf()

	# Set the mob's direction perpendicular to the path direction.
	var direction = mob_spawn_location.rotation + PI / 2

	# Set the mob's position to a random location.
	mob.position = mob_spawn_location.position

	# Add some randomness to the direction.
	direction += randf_range(-PI / 4, PI / 4)
	mob.rotation = direction

	# Choose the velocity for the mob.
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)

	# Spawn the mob by adding it to the Main scene.
	add_child(mob)