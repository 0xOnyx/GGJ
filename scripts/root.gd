extends KinematicBody2D

export (int) var speed = 100
export (float) var rotation_speed = 1.8

var velocity = Vector2()
var rotation_dir = 0
var rot_limit = PI/16 # in radians, PI is 180 deg

func get_input():
	rotation_dir = 0
	velocity = Vector2()
	if Input.is_action_pressed("right"):
		rotation_dir += 1
	if Input.is_action_pressed("left"):
		rotation_dir -= 1
	

func _physics_process(delta):
	get_input()
	velocity = Vector2(-speed, 0).rotated(rotation)
	rotation += rotation_dir * rotation_speed * delta
	rotation = clamp(rotation, -PI+rot_limit, -rot_limit)
	velocity = move_and_slide(velocity)

func _on_PathPointTimer_timeout():
#	print("appended", position)
	$N/Path.add_point(position)
#	$N/Path.set_draw_behind_parent(true)
#	$RootHead._set_on_top(true)
	$N/PathPointTimer.start()
