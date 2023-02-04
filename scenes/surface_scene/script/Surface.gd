extends Node2D

var enemy = preload("res://scenes/surface_scene/Enemy.tscn")
var main_tree = preload("res://scenes/surface_scene/Tree.tscn")

signal enemy_killed(enemy)

var floor_level = 0
#Root HP point when it's 0 game is over
var root_tree
#True if it is a surface game turn which means you cannot buy thing
var active = false
#Current level
var lvl = 1
#Factor that will be multiplied to the level to know the number of enemies to spawn
const enemies_counts = 15
#Factor that will be multiplied to the level to know the duration of the waves in milisecond
var duration = 500 * lvl


func spawn():
	$SpawnTimer.start()
	var instance = enemy.instance()
	var direction = 200
	if randi() % 2:
		direction = -200
	instance.position.x = direction
	instance.position.y = floor_level	
	add_child(instance)
	instance.launch()
	#Spawn an enemy

func launch():
	active = true
	$WaveTimer.start()
	spawn()

func _ready():
	$WaveTimer.wait_time = duration
	$SpawnTimer.wait_time = 5
	var instance = main_tree.instance()
	instance.position.x = 0
	instance.position.y = floor_level
	connect("enemy_killed", instance, "_on_Enemy_Killed")
	add_child(instance)
	launch()
	pass

func create_tree(x, type):
	var instance = main_tree.instance()
	instance.position.x = x
	instance.position.y = floor_level
	if type == 1:
		instance.init_sword()
	#if type == 2:
	#	instance.init_gun()
	if type == 3:
		instance.init_bomb()
	connect("enemy_killed", instance, "_on_Enemy_Killed")
	return instance

# warning-ignore:shadowed_variable
func damage_enemy(source, enemy, damage):
		enemy.HP -= damage
		enemy.get_node("HP").value -= damage
		if (enemy.HP <= 0):
			emit_signal("enemy_killed", enemy)
			enemy.queue_free()


func _on_SpawnTimer_timeout():
	if (active && $WaveTimer.time_left >= 2):
		spawn()
	
func _on_WaveTimer_timeout():
	active = false
	lvl += 1
	duration = 30 * 1000 * lvl
	$WaveTimer.wait_time = duration
	print_debug("End of wave ")

func _on_sig_tree_recieved(selected_tree, position_x):
	print(position_x)
	add_child(create_tree(position_x, selected_tree))
	
