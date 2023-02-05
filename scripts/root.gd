extends KinematicBody2D

#export (int) var speed = 100
export (float) var rotation_speed = 1.8

onready var path_line = $N/Path
onready var path_timer = $N/PathPointTimer

signal on_death

var velocity = Vector2()
var rotation_dir = 0
var rot_limit = PI/16 # in radians, PI is 180 deg

func _ready():
	if connect("on_death", get_parent().get_parent(), "_death_signal_recieved"):
		print("camera stuff")
	$"%Camera2D".make_current()
	print("player pos", position)

func get_input():
	rotation_dir = 0
	velocity = Vector2()
	if Input.is_action_pressed("left"):
		rotation_dir += 1
	if Input.is_action_pressed("right"):
		rotation_dir -= 1
	if Input.is_action_just_pressed("kill"):
		emit_signal("on_death")
		_on_Timer_timeout()
	if Input.is_action_just_pressed("boost"):
		g.root_speed = g.root_default_speed * 2
		g.root_boosted_default_speed = g.root_speed
	if Input.is_action_just_released("boost"):
		g.root_speed = g.root_default_speed
		g.root_boosted_default_speed = g.root_speed


func _physics_process(delta):
	
	get_input()
	velocity = Vector2(-g.root_speed, 0).rotated(rotation)
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
	emit_signal("on_death")#, get_tree().root.get_node("Root/N/Path"))
	$DeathTimer.start()

func _on_DeathTimer_timeout():
	queue_free()
