extends Node2D

onready var root = load("res://scenes/root/Root.tscn")
var child

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

func _death_signal_recieved():
#	var kids = $RootNode2D.get_children()
#	print($RootNode2D.get_child_count())
#	print($RootNode2D.get_child(0).name)
#	print($RootNode2D.get_child(0).get_child(1).get_child(1).name)
	var copy_me = $RootNode2D.get_child(0).get_child(1).get_child(1)
#	var new_path = get_node() $RootNode2D.Root.N.Path.duplicaate()
	var new_path = copy_me.duplicate()

	$PathsNode2D.add_child(new_path)
	$Camera2D.position = $RootNode2D.get_node("Root/Node/Camera2D").position
	#On rend la cam de mort current pour commencer à la déplacer
	$Camera2D.make_current()
	#root_instance()
	root_instance()
	calc_tread()

func _physics_process(delta):
	calc_tread()

func calc_tread():
	if $PathsNode2D.get_child_count() == 0:
		return
	for N in $PathsNode2D.get_children():
		var points = N.get_point_count()
		var i = 1
		var O = N.points[0]
		var l = $RootNode2D.get_child(0).get_node("TreadLine2D").points[0]
		var r = $RootNode2D.get_child(0).get_node("TreadLine2D").points[0]
#		print("- "+N.get_name(), "  len:", points)
		for P in N.points:
#			if i % 7 == 0 && Geometry.segment_intersects_segment_2d(old, P, l, r) == null:
			if Geometry.segment_intersects_segment_2d(P, O, r, l) == null:
				print(" p ", P, " O ", O, " r ", r, " l ", l)
				O = P
#			if (i % 7 == 0 && segment_intersects_segment_2d(old, P, 1, 2) == null):
#				print("skldfjlksdj")
			i = i + 1
