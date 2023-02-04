extends Node2D

func _physics_process(delta):
	pass

func _on_wait_wind_timeout():
	$BackgroundSheet/anim.play("bckg_wind")
	$wait_wind.wait_time = randi()%3 + 15
	$wait_wind.start()
