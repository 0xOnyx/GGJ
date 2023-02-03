extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_Collectable_body_entered(body):
	print(body.get_name(), " hit collectable")
	$DeathParticles.set_emitting(true)
	$DeathparticlesTimer.start()
	$Sprite.set_visible(false)
	$DeathparticlesTimer.wait_time = $DeathParticles.lifetime * 2

func _on_DeathparticlesTimer_timeout():
	queue_free()
