extends Node2D

onready var tree_menu = load("res://scenes/store/store_main.tscn")

var menu_is_here = false

func _on_slot_area_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and menu_is_here == false:
		menu_is_here = true
		var menu_instance = tree_menu.instance()
		menu_instance.position.y -= 400
		add_child(menu_instance)
