extends Node2D

var enemy = preload("res://surface_scene/Enemy.tscn")
var main_tree = preload("res://surface_scene/Tree.tscn")

var floor_level = 0
#Root HP point when it's 0 game is over
var root_tree
#True if it is a surface game turn which means you cannot buy thing
var active = false
#Array containing trees
var trees = []
#Current level
var lvl = 1
#Factor that will be multiplied to the level to know the number of enemies to spawn
const enemies_counts = 15
#Factor that will be multiplied to the level to know the duration of the waves in milisecond
var duration = 30 * lvl


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
	$SpawnTimer.wait_time = 2
	var instance = main_tree.instance()
	instance.position.x = 0
	instance.position.y = floor_level
	add_child(instance)
	launch()
	pass

func _on_SpawnTimer_timeout():
	if (active && $WaveTimer.time_left >= 2):
		spawn()
	
func _on_WaveTimer_timeout():
	active = false
	lvl += 1
	duration = 30 * 1000 * lvl
	$WaveTimer.wait_time = duration
	print_debug("End of wave ")

