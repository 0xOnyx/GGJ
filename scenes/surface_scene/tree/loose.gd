extends Node2D


func _on_menu_pressed():
	g.score = 0
	g.coins = 0
	g.game_state = 0
	g.nickname = "salut"
	g.lvl = 1
	g.root_default_speed = 50
	g.root_boosted_default_speed = 100
	g.root_speed = 50
	g.loose = false
	get_tree().reload_current_scene()

func _on_menu2_pressed():
	g.score = 0
	g.coins = 0
	g.game_state = 0
	g.nickname = "salut"
	g.lvl = 1
	g.root_default_speed = 50
	g.root_boosted_default_speed = 100
	g.root_speed = 50
	g.loose = false
	get_tree().change_scene("res://scenes/menu_start.tscn")
