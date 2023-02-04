extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var root_or_td = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var screen = get_viewport().size
	print(screen)
	$anim.play_backwards("root")
#	$SubsurfaceViewportContainer/SubsurfaceViewport.set_size(Vector2(screen.x, screen.y*.56))
#	$SurfaceViewportContainer/SurfaceViewport.set_size(Vector2(screen.x, screen.y*.56))
#	$SubsurfaceViewportContainer/SubsurfaceViewport.set_size(Vector2(screen.x, 300))

#var lala: Rect2 = "test"

func _physics_process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		if root_or_td == 0:
			root_or_td = 1
			$anim.play("root")
		else:
			root_or_td = 0
			$anim.play("Tower_Defense")
