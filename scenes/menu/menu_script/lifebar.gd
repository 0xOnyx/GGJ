extends Node2D

func _physics_process(delta):
	if $LifebarFill.position.x <= -540:
		$LifebarFill.position.x = 0
		print("loose")

func _attacked(dmg):
	$LifebarFill.position.x -= dmg
