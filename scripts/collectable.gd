extends Area2D


var pics = []

# Called when the node enters the scene tree for the first time.
func _ready():
#	print("loaded collectable sprites")
	var path = "res://assets/collectables/"
	var dir = Directory.new()
	dir.open(path)
	dir.list_dir_begin()
	while true:
		var file_name = dir.get_next()
		if file_name == "":
			#break the while loop when get_next() returns ""
			break
		elif !file_name.begins_with(".") and !file_name.ends_with(".import"):
			#if !file_name.ends_with(".import"):
			pics.append(load(path + "/" + file_name))
	dir.list_dir_end()
	
	$Sprite.set_texture(pics[rand_range(0, pics.size())])
	var shape = CircleShape2D.new()
	shape.set_radius($Sprite.get_texture().get_width()*.4)
#	var collision = CollisionShape2D.new()
	$CollisionShape2D.set_shape(shape)
	

func _on_Collectable_body_entered(body):
#	print(body.get_name(), " hit collectable")
	if (body.get_name() == "Root"):
		$DeathParticles.set_emitting(true)
		$DeathparticlesTimer.start()
		$Sprite.set_visible(false)
		$DeathparticlesTimer.wait_time = $DeathParticles.lifetime * 2
	else:
		queue_free()

func _on_DeathparticlesTimer_timeout():
	queue_free()


