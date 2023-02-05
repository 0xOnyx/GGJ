extends Node2D

onready var loose_sc = preload("res://scenes/surface_scene/tree/loose.tscn")

var root_or_td = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var screen = get_viewport().size

func _physics_process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		if root_or_td == 0:
			root_or_td = 1
			$anim.play("root")
		else:
			root_or_td = 0
			$anim.play("Tower_Defense")
	$UI/coins/Label.text = "Coins: " + String(g.coins)

func _on_loose():
	g.game_state = 0 # Pour savoir partout que c fini
	var ins = loose_sc.instance()
	add_child(ins)
