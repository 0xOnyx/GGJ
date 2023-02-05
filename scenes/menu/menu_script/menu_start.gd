extends Node2D

func _on_but_start_pressed():
	$son.play()
	$anim.play("change_scene")
	#get_tree().change_scene("res://scenes/main.tscn") #Pour passer a la scene principale de jeu


func _on_but_option_pressed():
	$son.play()
	if transform.x.x >= 0:
		$anim.play("show_hide_option")
	else:
		$anim.play_backwards("show_hide_option")
		


func _on_anim_animation_finished(anim_name):
	if anim_name == "change_scene":
		get_tree().change_scene("res://scenes/main.tscn")
