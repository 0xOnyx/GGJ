extends Node2D

enum Type {MAIN, SWORD, GUN, BOMB}

var bomb = preload("res://scenes/surface_scene/tree/Bomb.tscn")
var type = Type.MAIN
var targets = []
#Price to build it
var price
var HP = 100;
#Tree level
var lvl = 1
var damage = 50
var direction = 1
var attacked = true


func _ready():
	if global_position.x <= 960:
		direction = -1
	if type == 0:
		$HP.visible = false
	$DefenseArea.position.x *= direction
	$Willow/WillowTreeAttackSheet.flip_h = direction == -1

func init_sword():
	$DefenseArea.visible = true
	$Willow.visible = true
	$TreeLife.visible = false
	type = Type.SWORD
	$Buff.wait_time = 0.6

	
func init_bomb():
	$Bomb.visible = true
	$TreeLife.visible = false
	$Buff.wait_time = 2 
	type = Type.BOMB
	
func attack():
	$HP.value = HP
	if type == Type.BOMB and $Buff.is_stopped():
		$Buff.start()
		var instance = bomb.instance()
		instance.position.y = -45
		instance.direction = direction
		add_child(instance)
		instance.shoot()
		
	if type == Type.SWORD and $Buff.is_stopped():
		$Buff.start()
		$Willow/attack.play("attack")
		if attacked and targets.size() > 0:
			get_parent().damage_enemy(self, targets[0], damage)
		attacked = not attacked;

func _on_Area2D_area_entered(area):
	print(area.name)
	if area.get_parent().has_method("attack") and "Enemy" in area.get_parent().name:
		area.get_parent().attack(self)
	pass # Replace with function body.	

func _on_DefenseArea_area_entered(area):
	if not targets.has(area.get_parent()) and "Enemy" in area.get_parent().name:
		targets.append(area.get_parent())
	if "Enemy" in area.get_parent().name:
		attack()


func _on_Enemy_Killed(e):
	print(true)
	if targets.has(e):
		targets.erase(e)

func _on_Buff_timeout():
	$Buff.stop()
	if not targets.empty():
		attack()


func _on_DefenseArea_area_exited(area):
	targets.erase(area)
