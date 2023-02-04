extends Node2D

var life = 0

func _physics_process(delta):
	$LifebarFill.position.x = 0 - life
	if Input.is_action_just_pressed("ui_accept") and life >= 0:
		$anim.play("dmg")
		life += 42
	if Input.is_action_just_pressed("ui_cancel") and life > 0:
		$anim.play("heal")
		life -= 42
