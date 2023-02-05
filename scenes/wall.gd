extends KinematicBody2D

func _ready():
	$CollisionShape2D.set_position(Vector2(-70, 0))
	$CollisionShape2D.shape.set_extents(Vector2(10, 150))
	$CollisionShape2D2.set_position(Vector2(300 * 2.1, 0))
	$CollisionShape2D2.shape.set_extents(Vector2(10, 150))
	
