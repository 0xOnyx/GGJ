extends Node2D

func _on_but_start_pressed():
	get_tree().change_scene("") #Pour passer a la scene principale de jeu


func _on_but_option_pressed():
	if transform.x.x >= 0:
		$anim.play("show_hide_option")
	else:
		$anim.play_backwards("show_hide_option")
