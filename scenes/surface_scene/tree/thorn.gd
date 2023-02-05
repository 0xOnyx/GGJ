extends KinematicBody2D

var vel = Vector2(0, 0)
var speed = 1900
var direction = 1

func _ready():
	vel.x = 1930 * direction
	scale.x *= direction

func _physics_process(delta):
	#if position.x > 960 or position.x < -960 or position.y > 1080:
		#queue_free()
	var collision_info = move_and_collide(vel.normalized() * delta * speed)
	vel.y += delta * (speed /2)


func _on_Area2D_area_entered(area):
	if area.get_parent().has_signal("Enemy"):
		get_parent().get_parent().damage_enemy(self, area.get_parent(), 80)
		queue_free()
