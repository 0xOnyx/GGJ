extends Node2D


func _on_menu_pressed():
	get_tree().change_scene("res://scenes/menu/menu_start.tscn")


func _on_menu2_pressed():
	get_tree().change_scene("res://scenes/main.tscn")
