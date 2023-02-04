extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	

func _on_Collectable_body_entered(body):
	print(body.get_name(), " hit collectable")
	if (body.get_name() == "Root"):
		$DeathParticles.set_emitting(true)
		$DeathparticlesTimer.start()
		$Sprite.set_visible(false)
		$DeathparticlesTimer.wait_time = $DeathParticles.lifetime * 2
	else:
		queue_free()

func _on_DeathparticlesTimer_timeout():
	queue_free()


