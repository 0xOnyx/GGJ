extends KinematicBody2D

export (int) var speed = 100
export (float) var rotation_speed = 1.8

onready var path_line = $N/Path
onready var path_timer = $N/PathPointTimer

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
	var points_count = path_line.points.size()
	if (points_count > 1):
		path_line.set_point_position(points_count - 1, position)
	
func _on_PathPointTimer_timeout():
	path_line.add_point(position)
	path_timer.start()


func _on_Timer_timeout():
	print("we should die")
