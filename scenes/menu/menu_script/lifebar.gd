extends Node2D

signal loose

func _ready():
	connect("loose", get_parent().get_parent(), "_on_loose")

func _physics_process(delta):
	if $LifebarFill.position.x <= -540:
		$LifebarFill.position.x = -539
		emit_signal("loose")

func _attacked(dmg):
	$LifebarFill.position.x -= dmg
