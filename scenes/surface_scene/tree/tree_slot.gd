extends Node2D

onready var tree_menu = preload("res://scenes/store/store_main.tscn")

func _on_slot_area_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and get_tree().get_node_count() == 4:
		var menu_instance = tree_menu.instance()
		menu_instance.position = get_viewport().get_mouse_position()
		add_child(menu_instance)
