extends StaticBody2D

#var pics = []
var type = 0

func create(biome):
	var a1 = load("res://assets/obstacles/0/bones_final_1.png")
	var a2 = load("res://assets/obstacles/0/bones_final_2.png")
	var a0 = load("res://assets/obstacles/0/bottle.png")
	var a3 = load("res://assets/obstacles/0/tire.png")
	
	var b0 = load("res://assets/obstacles/1/bones_final_3.png")
	var b1 = load("res://assets/obstacles/1/roman.png")
	var b2 = load("res://assets/obstacles/1/sldier.png")

	var c0 = load("res://assets/obstacles/2/rock_final_1.png")
	var c1 = load("res://assets/obstacles/2/rock_final_2.png")
	var c2 = load("res://assets/obstacles/2/rock_final_3.png")
	var c3 = load("res://assets/obstacles/2/redioactif.png")
	
	var a = [a0, a1, a2, a3]
	var b = [b0, b1, b2]
	var c = [c0, c1, c2, c3]
	
	if biome == 0:
		type = rand_range(0, 4)
		$Sprite.set_texture(a[type])
	if biome == 1:
		type = rand_range(0, 3)
		$Sprite.set_texture(b[type])
	if biome == 2:
		type = rand_range(0, 4)
		$Sprite.set_texture(c[type])
	var shape = CircleShape2D.new()
	shape.set_radius($Sprite.get_texture().get_width()*.4)
#	var collision = CollisionShape2D.new()
	$CollisionShape2D.set_deferred("shape", shape)
	$Sprite.set_rotation_degrees(rand_range(0, 180))

#func create(biome):
#	#	print("loaded obstacle sprites")
#	var path = "res://assets/obstacles/" + String(biome)
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
#			pics.append(load(path + "/" + file_name))
#	dir.list_dir_end()
#
#	$Sprite.set_texture(pics[rand_range(0, pics.size())])
#	var shape = CircleShape2D.new()
#	shape.set_radius($Sprite.get_texture().get_width()*.48)
##	var collision = CollisionShape2D.new()
#	$CollisionShape2D.set_deferred("shape", shape)
##	$CollisionShape2D.set_shape(shape)
#	$Sprite.set_rotation_degrees(rand_range(0, 180))


# Called when the node enters the scene tree for the first time.
func _ready():
	pass
