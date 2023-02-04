extends Node2D

enum Type {MAIN, SWORD, GUN, BOMB}

var type = Type.MAIN
var targets = []
var enemy = preload("res://scenes/surface_scene/Enemy.tscn")
#Price to build it
var price
var HP = 100;
#Tree level
var lvl = 1
var damage = 50

func _ready():
	pass

func init_sword(buff):
	$Buff.wait_time = buff	
	type = Type.SWORD
	
func init_bomb(buff):
	$Buff.wait_time = buff	
	type = Type.BOMB
	
func attack():
	if type == Type.SWORD and $Buff.is_stopped():
		$Buff.start()
		get_parent().damage_enemy(self, targets[0], damage)
	
func _on_Area2D_area_entered(area):
	if area.get_parent().has_method("attack"):
		area.get_parent().attack(self)
	pass # Replace with function body.	

func _on_DefenseArea_area_entered(area):
	if not targets.has(area.get_parent()):
		targets.append(area.get_parent())
	attack()


func _on_Buff_timeout():
	$Buff.stop()
	if not targets.empty():
		attack()


func _on_DefenseArea_area_exited(area):
	targets.erase(area)
