extends Area2D

@export var OrbitProjectile: PackedScene
var main
var player

# Called when the node enters the scene tree for the first time.
func _ready():
	main = get_tree().get_root()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_entered(area):
	if player == area:
		queue_free()
		
		var orbit_projectile = OrbitProjectile.instantiate()
		orbit_projectile.set_target(player)
		main.add_child(orbit_projectile)
		
func add_player(_player):
	player = _player
