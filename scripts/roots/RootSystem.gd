extends Node2D

onready var root = load("res://scenes/root/Root.tscn")
var child

func _ready():
	root_instance()
#	root.Timer.start()

func root_instance():
	child = root.instance()
	$RootNode2D.add_child(child)

func _death_signal_recieved():
	print("my child is dead")
	print("spawning a new child")
#	var kids = $RootNode2D.get_children()
#	print($RootNode2D.get_child_count())
#	print($RootNode2D.get_child(0).name)
#	print($RootNode2D.get_child(0).get_child(1).get_child(1).name)
	var copy_me = $RootNode2D.get_child(0).get_child(1).get_child(1)
#	var new_path = get_node() $RootNode2D.Root.N.Path.duplicaate()
	var new_path = copy_me.duplicate()
	
	$PathsNode2D.add_child(new_path)
	root_instance()

