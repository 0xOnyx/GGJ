extends Node2D

signal sig_tree_selected(selected_tree, position_x)

onready var selected_tree = -1

#Quand on clique sur le bouton, ça se connect au parent 
#(vu que le menu est une instance) et ça emet le signal 
#correspondant a l'arbre selectionné

func _ready():
	$animplay.play("appear")

func _on_but_tree1_pressed():
	selected_tree = 1
	$animplay.play("confirm_appear")


func _on_but_tree2_pressed():
	selected_tree = 2
	$animplay.play("confirm_appear")


func _on_but_tree3_pressed():
	selected_tree = 3
	$animplay.play("confirm_appear")

func _on_but_confirm_pressed():
	connect("sig_tree_selected", get_parent(), "_on_sig_tree_recieved")
	emit_signal("sig_tree_selected", selected_tree, position.x)
	queue_free()
	$animplay.play_backwards("appear")
	$animplay/Timer.start()

#Les anims play c'est pour quand ce sera bon pour faire jolie

func _on_Area2D_mouse_entered():
	queue_free()
	$animplay.play_backwards("appear")
	get_parent().menu_is_here = false
	$animplay/Timer.start()


func _on_Timer_timeout():
	queue_free()
