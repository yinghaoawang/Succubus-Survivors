extends Area2D

@export var player : Area2D
@export var OrbitProjectile: PackedScene
var world

# Called when the node enters the scene tree for the first time.
func _ready():
	world = get_tree().get_root()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_entered(area):
	if player == area:
		queue_free()
		
		var orbit_projectile = OrbitProjectile.instantiate()
		orbit_projectile.set_target(player)
		world.add_child(orbit_projectile)
