extends KinematicBody2D

#export (int) var speed = 100
export (float) var rotation_speed = 2

onready var path_line = $N/Path
onready var path_timer = $N/PathPointTimer

signal on_death

var velocity = Vector2()
var rotation_dir = 0
var rot_limit = PI/14 # in radians, PI is 180 deg

var rot
var control = 0

var can_dash = 1

func _ready():
	if connect("on_death", get_parent().get_parent(), "_death_signal_recieved"):
		print("camera stuff")
	$"%Camera2D".make_current()
	print("player pos", position)
	rot = rotation
	can_dash = 1

func get_input():
	rotation_dir = 0
	velocity = Vector2()
	control = 0
	if Input.is_action_just_pressed("left"):
		control = 1
	if Input.is_action_just_pressed("right"):
		control = -1
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
	if Input.is_action_just_pressed("dash"):
		if can_dash == 1:
			print("starting dash")
			$DashTimer.start()
			g.root_speed = g.root_default_speed * 2
			g.root_boosted_default_speed = g.root_speed
			can_dash = 0
			$DashParticles2D.set_emitting(true)
		


func _physics_process(delta):
	
	get_input()
	velocity = Vector2(-g.root_speed, 0).rotated(rotation)
	if control == 1:
		rot += PI/8
	if control == -1:
		rot -= PI/8
	rot += rotation_dir * rotation_speed * delta
	rot = clamp(rot, -PI+rot_limit, -rot_limit)
	rotation = stepify(rot, PI/8)
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

func _on_DashTimer_timeout():
	print("dashing finished")
	g.root_speed = g.root_default_speed
	g.root_boosted_default_speed = g.root_speed
	$DashParticles2D.set_emitting(false)
	$DashCoolDownTimer.start()

func _on_DashCoolDownTimer_timeout():
	print("can dash again!")
	can_dash = 1
	pass
