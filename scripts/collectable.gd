extends Area2D

var pics = []
var type = 0

func create(biome):
	#	print("loaded collectable sprites")
	var path = "res://assets/collectables/" + String(biome)
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
			pics.append(load(path + "/"  + file_name))
	dir.list_dir_end()
	type = rand_range(0, pics.size())
	$Sprite.set_texture(pics[type])
	var shape = CircleShape2D.new()
	shape.set_radius($Sprite.get_texture().get_width()*.4)
#	var collision = CollisionShape2D.new()
	$CollisionShape2D.set_deferred("shape", shape)
	$Sprite.set_rotation_degrees(rand_range(0, 180))

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	

func _on_Collectable_body_entered(body):
	if (body.get_name() == "Root"):
		var audio_path
		if "duck" in $Sprite.texture.resource_path:
			audio_path = load(str("res://assets/sound/collectible/Canard/Canard.ogg"))
		if "cristal" in $Sprite.texture.resource_path:
			audio_path = load(str("res://assets/sound/collectible/Christal/Christal_1.ogg"))
		if "water" in $Sprite.texture.resource_path:
			audio_path = load(str("res://assets/sound/collectible/Goute/Goute_1.ogg"))
		if "gland" in $Sprite.texture.resource_path or "seed" in $Sprite.texture.resource_path:
			audio_path = load(str("res://assets/sound/collectible/Graine/Graine_1.ogg"))
		$son.stream = audio_path
		$DeathParticles.set_emitting(true)
		$DeathparticlesTimer.start()
		$Sprite.set_visible(false)
		$DeathparticlesTimer.wait_time = $DeathParticles.lifetime * 2
		g.coins += int(type) + 1
		$son.play()
	else:
		queue_free()

func _on_DeathparticlesTimer_timeout():
	queue_free()


