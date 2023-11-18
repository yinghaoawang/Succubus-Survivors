extends Node

@export var mob_scene: PackedScene = preload("res://scenes/Mob.tscn")
var time
var kill_count

# Called when the node enters the scene tree for the first time.
func _ready():
	$Player.set_main(self)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func game_over():
	$ElapsedTimer.stop()
	$MobTimer.stop()
	$HUD.show_game_over()

func new_game():
	get_tree().call_group("mobs", "queue_free") # Clear mobs
	get_tree().call_group("projectiles", "queue_free") # Clear projectiles
	time = 0
	kill_count = 0
	$Player.start($StartPosition.position)
	$HUD.update_score(time)
	$HUD.show_message("Get Ready")
	$HUD.update_kill_counter(kill_count)
	$StartTimer.start()

func _on_elapsed_timer_timeout():
	time += 1
	$HUD.update_score(time)

func _on_start_timer_timeout():
	$MobTimer.start() 
	$ElapsedTimer.start()

func _on_mob_timer_timeout():
	# Create a new instance of the Mob scene.
	var mob = mob_scene.instantiate()
	mob.set_player($Player)
	mob.mob_killed.connect(on_mob_killed)

	# Choose a random location on Path2D.
	var mob_spawn_location = get_node("MobPath/MobSpawnLocation")
	mob_spawn_location.progress_ratio = randf()

	# Set the mob's position to a random location.
	mob.position = mob_spawn_location.position

	# Spawn the mob by adding it to the Main scene.
	add_child(mob)


func _on_star_timer_timeout():
	$Player.shoot()


func on_mob_killed():
	kill_count += 1
	$HUD.update_kill_counter(kill_count)
