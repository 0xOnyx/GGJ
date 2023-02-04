extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var screen = get_viewport().size
	print(screen)
#	$SubsurfaceViewportContainer/SubsurfaceViewport.set_size(Vector2(screen.x, screen.y*.56))
#	$SurfaceViewportContainer/SurfaceViewport.set_size(Vector2(screen.x, screen.y*.56))
	$SubsurfaceViewportContainer/SubsurfaceViewport.set_size(Vector2(screen.x, 300))

#var lala: Rect2 = "test"
