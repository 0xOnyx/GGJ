extends KinematicBody2D

export (int) var speed = 100
export (float) var rotation_speed = 1.5

var velocity = Vector2()
var rotation_dir = 0


func get_input():
	rotation_dir = 0
	velocity = Vector2()
	if Input.is_action_pressed("right"):
		rotation_dir += 1
	if Input.is_action_pressed("left"):
		rotation_dir -= 1
#	if Input.is_action_pressed("down"):
#		velocity = Vector2(-speed, 0).rotated(rotation)
#	if Input.is_action_pressed("up"):
#		velocity = Vector2(speed, 0).rotated(rotation)

#	#trail
#	if $g/trail_timer.time_left == 0:
#		#print("appended", position)
#		$g/trail.add_point(position)
#		$g/trail_timer.start()
#		$g/trail.set_draw_behind_parent(true) 
#	while $g/trail.points.size() > 20:
#		#print("removal")
#		$g/trail.remove_point(0)
#		$g/trail.set_draw_behind_parent(true) 
#	$g/trail.set_point_position($g/trail.get_point_count()-1, position)
	

func _physics_process(delta):
	get_input()
	velocity = Vector2(-speed, 0).rotated(rotation)
	rotation += rotation_dir * rotation_speed * delta
	velocity = move_and_slide(velocity)
#	$Path.set_point_position(($Path.get_point_count()-1), position)


func _on_PathPointTimer_timeout():
#	print("appended", position)
	$N/Path.add_point(position)
	$N/PathPointTimer.start()
	
