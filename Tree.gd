extends Node2D

enum Type {MAIN, SWORD, GUN}

var type = Type.MAIN
var enemy = preload("res://surface_scene/Enemy.tscn")
#Price to build it
var price
var HP = 100;
#Tree level
var lvl = 1

func _ready():
	pass

func _on_Area2D_area_entered(area):
	area.get_parent().attack(self)
	pass # Replace with function body.
