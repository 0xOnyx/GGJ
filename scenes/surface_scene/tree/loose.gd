extends Node2D


func _on_menu_pressed():
	get_tree().change_scene("res://scenes/menu/menu_start.tscn")
	g.score = 0
	g.coins = 0


func _on_menu2_pressed():
	get_tree().change_scene("res://scenes/main.tscn")
	g.score = 0
	g.coins = 0
