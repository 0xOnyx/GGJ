extends Node2D

#On récupère le parent du menu option (donc normalement le menu_start)
#Et on get son animation node pour faire l'animation à l'envers.
func _on_Button_pressed():
	$son.play()
	get_parent().get_node("anim").play_backwards("show_hide_option")


func _on_HSlider_value_changed(value):
	g.volume_music = $HSlider.value


func _on_value_changed(value):
	pass # Replace with function body.
