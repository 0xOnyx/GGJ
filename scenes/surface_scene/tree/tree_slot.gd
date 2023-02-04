extends Node2D

onready var tree_menu = load("res://scenes/store/store_main.tscn")

func _on_slot_area_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		var menu_instance = tree_menu.instance()
		menu_instance.position.y -= 350
		add_child(menu_instance)
