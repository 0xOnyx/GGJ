extends Node2D

var c = 0
var to_add = 1.5
var exploded = true
var direction = -1

func f(x):
	return  (x*x/100 - x * direction + c)

func _ready():
	c = position.y 

# warning-ignore:unused_argument
func _physics_process(delta):
	if (exploded):
		return
	if (position.y >= 0):
		explode();
		return
	position.y = f(position.x)
	position.x+= to_add * direction
	if (position.x >= 50):
		to_add+=0.04

func shoot():
	exploded = false

func explode():
	exploded = true
	$AnimationPlayer.play("explode")


func _on_Area2D_area_entered(area):
	if area.get_parent().has_signal("Enemy"):
		get_parent().get_parent().damage_enemy(get_parent(),area.get_parent(), 30)


func _on_AnimationPlayer_animation_finished(anim_name):
	queue_free()
