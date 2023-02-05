extends Node2D

var enemy = preload("res://scenes/surface_scene/Enemy.tscn")
var main_tree = preload("res://scenes/surface_scene/Tree.tscn")

signal enemy_killed(enemy)
signal wave(nb_wave)

var floor_level = 0
#Root HP point when it's 0 game is over
var root_tree
#True if it is a surface game turn which means you cannot buy thing
var active = false
#Current level
#Factor that will be multiplied to the level to know the number of enemies to spawn
const enemies_counts = 15
#Factor that will be multiplied to the level to know the duration of the waves in milisecond
var duration = 30 * g.lvl
var wave = 0

func spawn():
	if wave > 0:
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
	$WaveTimer.wait_time = duration
	$SpawnTimer.wait_time = randi()%1 + 5
	active = true
	$WaveTimer.start()
	spawn()

func _ready():
	connect("wave", get_tree().root.get_node("Node3D"), "_on_end_wave")

func create_tree(x, type):
	var instance = main_tree.instance()
	instance.position.x = x
	instance.position.y = floor_level
	if type == 1:
		instance.init_sword()
	if type == 2:
		instance.init_rose()
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
			var rand = randi()%1 + 13
			var audio_path = load(String("res://assets/sound/death/Mort_"+ String(int(rand)) + ".ogg"))
			$death_sound.stream = audio_path
			$death_sound.play()
			enemy.queue_free()


func _on_SpawnTimer_timeout():
	if (active && $WaveTimer.time_left >= 5):
		spawn()

func _on_WaveTimer_timeout():
	active = false
	g.lvl += 1
	wave += 1
	duration = 30
	$WaveTimer.wait_time = duration
	emit_signal("wave", wave)
	$WaveTimer.stop()
	if get_parent().get_node("tree_slot").visible == false:
		get_parent().get_node("tree_slot").visible = true
	elif get_parent().get_node("tree_slot2").visible == false:
		get_parent().get_node("tree_slot2").visible = true
	elif get_parent().get_node("tree_slot3").visible == false:
		get_parent().get_node("tree_slot3").visible = true
	elif get_parent().get_node("tree_slot4").visible == false:
		get_parent().get_node("tree_slot4").visible = true
	elif get_parent().get_node("tree_slot5").visible == false:
		get_parent().get_node("tree_slot5").visible = true
	elif get_parent().get_node("tree_slot6").visible == false:
		get_parent().get_node("tree_slot6").visible = true

func _on_sig_tree_recieved(selected_tree, position_x):
	add_child(create_tree(position_x, selected_tree))

func _start_wave():
	launch()

func _start_game():
	var instance = main_tree.instance()
	instance.position.x = 0
	instance.position.y = floor_level
	add_child(instance)
	connect("enemy_killed", instance, "_on_Enemy_Killed")
	launch()
