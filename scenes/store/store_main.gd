extends Node2D

signal sig_tree_selected(selected_tree, position_x)


#Quand on clique sur le bouton, ça se connect au parent 
#(vu que le menu est une instance) et ça emet le signal 
#correspondant a l'arbre selectionné

func _ready():
	$animplay.play("appear")

func _on_but_tree1_pressed():
	if g.coins >= 10:
		g.coins -= 10
		_spawn_tree(1)


func _on_but_tree2_pressed():
	if g.coins >= 15:
		g.coins -= 15
		_spawn_tree(2)


func _on_but_tree3_pressed():
	if g.coins >= 20:
		g.coins -= 20
		_spawn_tree(3)

#Les anims play c'est pour quand ce sera bon pour faire jolie

func _spawn_tree(selected_tree):
	if selected_tree > 0:
		var posx_to_send = get_parent().position.x
		connect("sig_tree_selected", get_parent().get_parent().get_node("Surface"), "_on_sig_tree_recieved")
		if posx_to_send < 960:
			posx_to_send = 960 - posx_to_send
			posx_to_send *= -1
		else:
			posx_to_send -= 960
		posx_to_send /= 4

		emit_signal("sig_tree_selected", selected_tree, posx_to_send)
		$animplay.play_backwards("appear")
		$animplay/Timer.start()
		get_parent().queue_free()

func _on_Area2D_mouse_entered():
	$animplay.play_backwards("appear")
	get_parent().menu_is_here = false
	$animplay/Timer.start()


func _on_Timer_timeout():
	queue_free()
