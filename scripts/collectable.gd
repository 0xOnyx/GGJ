extends Area2D

#var pics = []
var type = 0
signal heal(hl)

func create(biome):
	var a1 = load("res://assets/collectables/0/gland.png")
	var a2 = load("res://assets/collectables/0/seed_final.png")
	var a3 = load("res://assets/collectables/0/water.png")
	var a0 = load("res://assets/collectables/0/duck.png")
	
	var b0 = load("res://assets/collectables/1/cristal_diamond.png")
	var b1 = load("res://assets/collectables/1/cristal_final_1.png")
	var b2 = load("res://assets/collectables/1/cristal_final_2.png")
	var b3 = load("res://assets/collectables/1/cristal_final_3.png")

	var c0 = load("res://assets/collectables/2/alien.png")
	var c1 = load("res://assets/collectables/2/Amber_loot.png")
	var c2 = load("res://assets/collectables/2/sattelite.png")
	
	var a = [a0, a1, a2, a3]
	var b = [b0, b1, b2, b3]
	var c = [c0, c1, c2]
	
	if biome == 0:
		type = rand_range(0, 4)
		$Sprite.set_texture(a[type])
	if biome == 1:
		type = rand_range(0, 4)
		$Sprite.set_texture(b[type])
	if biome == 2:
		type = rand_range(0, 3)
		$Sprite.set_texture(c[type])
	var shape = CircleShape2D.new()
	shape.set_radius($Sprite.get_texture().get_width()*.4)
#	var collision = CollisionShape2D.new()
	$CollisionShape2D.set_deferred("shape", shape)
	$Sprite.set_rotation_degrees(rand_range(0, 180))


# using for quick and fun asset addtion duing the dev
#func create(biome):
#	#	print("loaded collectable sprites")
#	var path = "res://assets/collectables/" + String(biome)
#	var dir = Directory.new()
#	dir.open(path)
#	dir.list_dir_begin()
#	while true:
#		var file_name = dir.get_next()
#		if file_name == "":
#			#break the while loop when get_next() returns ""
#			break
#		elif !file_name.begins_with(".") and !file_name.ends_with(".import"):
#			#if !file_name.ends_with(".import"):
#			pics.append(load(path + "/"  + file_name))
#	dir.list_dir_end()
#	type = rand_range(0, pics.size())
#	$Sprite.set_texture(pics[type])
#	var shape = CircleShape2D.new()
#	shape.set_radius($Sprite.get_texture().get_width()*.4)
##	var collision = CollisionShape2D.new()
#	$CollisionShape2D.set_deferred("shape", shape)
#	$Sprite.set_rotation_degrees(rand_range(0, 180))

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("heal", get_tree().root.get_node("Node3D/UI/lifebar"), "_healed")


func _on_Collectable_body_entered(body):
	if (body.get_name() == "Root"):
		var audio_path
		if "duck" in $Sprite.texture.resource_path:
			audio_path = load(str("res://assets/sound/collectible/Canard/Canard.ogg"))
		if "cristal" in $Sprite.texture.resource_path:
			audio_path = load(str("res://assets/sound/collectible/Christal/Christal_1.ogg"))
		if "water" in $Sprite.texture.resource_path:
			audio_path = load(str("res://assets/sound/collectible/Goute/Goute_1.ogg"))
			emit_signal("heal", 10)
		if "gland" in $Sprite.texture.resource_path or "seed" in $Sprite.texture.resource_path:
			audio_path = load(str("res://assets/sound/collectible/Graine/Graine_1.ogg"))
		$son.stream = audio_path
		$DeathParticles.set_emitting(true)
		$DeathparticlesTimer.start()
		$Sprite.set_visible(false)
		$DeathparticlesTimer.wait_time = $DeathParticles.lifetime * 2
		g.coins += int(type) + 2
		g.score += int(type) + 2
		$Label.text = "+" + String(int(type) + 1)
		$son.play()
		$anim.play("+1")
	else:
		queue_free()

func _on_DeathparticlesTimer_timeout():
	queue_free()
