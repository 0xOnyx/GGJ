extends Node2D

onready var loose_sc = preload("res://scenes/surface_scene/tree/loose.tscn")

var root_or_td = 0

signal start_wave
signal end_wave
signal start_game

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	connect("end_wave", $SubsurfaceViewportContainer/SubsurfaceViewport/SubsurfaceNode2D.get_node("RootSystemNode2D") , "_death_signal_recieved")
	connect("start_wave", $SubsurfaceViewportContainer/SubsurfaceViewport/SubsurfaceNode2D.get_node("RootSystemNode2D") , "root_instance")
	connect("start_game", $SubsurfaceViewportContainer/SubsurfaceViewport/SubsurfaceNode2D.get_node("RootSystemNode2D") , "root_instance")
	connect("start_wave", $SurfaceViewportContainer/SurfaceViewport/tower_defense.get_node("Surface") , "_start_wave")
	connect("start_game", $SurfaceViewportContainer/SurfaceViewport/tower_defense.get_node("Surface") , "_start_game")
	$anim.play("intro")
	$UI/coins/Label.text = "Coins: " + String(g.coins) + "\nTime: " + String(int($start_wave.time_left))
	$start_wave.start()

func _physics_process(delta):
	if Input.is_action_pressed("ui_cancel"):
		get_tree().quit()
	if Input.is_action_pressed("space") && g.game_state == 2:
		$start_wave.stop()
		$start_wave.wait_time = 1
		$start_wave.start()
	$UI/coins/Label.text = "Coins: " + String(g.coins) + "\nTime: " + String(int($start_wave.time_left))

func _on_end_wave(nb_wave):
	emit_signal("end_wave")
	$anim.play("Tower_Defense")
	$start_wave.wait_time = 10
	$start_wave.start()
	g.game_state == 2

func _on_loose():
	g.game_state = 0 # Pour savoir partout que c fini
	if g.loose == false:
		var ins = loose_sc.instance()
		add_child(ins)
		g.loose = true


func _on_start_wave_timeout():
	if g.game_state == 0:
		emit_signal("start_game")
		$anim/MainTree.queue_free()
		g.game_state = 1
	else:
		emit_signal("start_wave")
		g.game_state = 1
	$anim.play("root")
