extends Node2D

signal sig_tree_selected

onready var selected_tree = ""

#Quand on clique sur le bouton, ça se connect au parent 
#(vu que le menu est une instance) et ça emet le signal 
#correspondant a l'arbre selectionné

func _physics_process(delta):
	$but_confirm.text = String("confirm " + selected_tree + " ?")

func _on_but_tree1_pressed():
	selected_tree = "tree1"
	$animplay.play("confirm_appear")


func _on_but_tree2_pressed():
	selected_tree = "tree2"
	$animplay.play("confirm_appear")


func _on_but_tree3_pressed():
	selected_tree = "tree3"
	$animplay.play("confirm_appear")

func _on_but_confirm_pressed():
	connect("sig_tree_selected", get_parent(), "_on_sig_tree_recieved")
	emit_signal("sig_tree_selected", selected_tree)
	$animplay.play_backwards("appear")
	$animplay/Timer.start()


func _on_Area2D_mouse_entered():
	$animplay.play_backwards("appear")
	$animplay/Timer.start()


func _on_Timer_timeout():
	queue_free()
