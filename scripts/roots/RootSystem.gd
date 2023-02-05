extends Node2D

onready var root = load("res://scenes/root/Root.tscn")
var child
var debug = 0

func root_instance():
	child = root.instance()
	var viw = get_viewport().size
	print("here ", viw)
	child.set_position(Vector2(viw.x/2, 0))
	$RootNode2D.add_child(child)

# Pour bouger la cam de mort pour voir toutes les racines:
func _physics_process(delta):
	if $Camera2D.position.y > 50 and $Camera2D.is_current():
		$Camera2D.position.y -= delta * 250
	calc_tread()

func launch_test():
	debug = 1
	root_instance()

func _death_signal_recieved():
#	var kids = $RootNode2D.get_children()
#	print($RootNode2D.get_child_count())
#	print($RootNode2D.get_child(0).name)
#	print($RootNode2D.get_child(0).get_child(1).get_child(1).name)
	var copy_me = $RootNode2D.get_child(0).get_child(1).get_child(1)
#	var new_path = get_node() $RootNode2D.Root.N.Path.duplicaate()
	var new_path = copy_me.duplicate()

	$PathsNode2D.add_child(new_path)
	$Camera2D.position = $RootNode2D.get_child(0).get_node("Node/Camera2D").position
	#On rend la cam de mort current pour commencer à la déplacer
	$Camera2D.make_current()
	print("ca")
	if debug == 1:
		root_instance()
	calc_tread()

func calc_tread():
	if g.game_state == 0:
		return
	if $PathsNode2D.get_child_count() == 0:
		return
	for N in $PathsNode2D.get_children():
#		var i = 1
		if $RootNode2D.get_child_count() == 0:
			return
		var c = $RootNode2D.get_child(0)
		if c == null:
			return
		var pos = c.position
		
#		var l = $RootNode2D.get_child(0).get_node("TreadLine2D").points[0]
#		var r = $RootNode2D.get_child(0).get_node("TreadLine2D").points[1]
		var l = pos - Vector2(10, 0)
		var r = pos + Vector2(10, 0)
#		print(" { ", l, ", ", r, " } ")
#		print("pos ", pos)
#		print("- "+N.get_name(), "  len:", points)
		var O = N.points[0]
		for P in N.points:
#			if i % 7 == 0 && Geometry.segment_intersects_segment_2d(old, P, l, r) == null:
#			if i % 7 == 0:
			var foo = Geometry.segment_intersects_segment_2d(P, O, r, l)
			if foo == null:
				pass
#					print("not on a line")
			else:
#				print("riding on a line!")
#				print(" p ", P, " O ", O, " r ", r, " l ", l)
				g.root_speed = g.root_boosted_default_speed * 2
				return
			O = P
#			i = i + 1
	g.root_speed = g.root_boosted_default_speed
