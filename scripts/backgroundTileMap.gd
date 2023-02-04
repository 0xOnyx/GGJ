extends Node2D

var current_level = 1
var map_set
var size_none = 176
var size = size_none * 3;
var last = Vector2(0, size)

var shape = RectangleShape2D.new()
var noise_collectable = OpenSimplexNoise.new()
var noise_water = OpenSimplexNoise.new()
var noise_rock = OpenSimplexNoise.new()
onready var Collectable = preload("res://scenes/collectable/Collectable.tscn")
onready var Rock = preload("res://scenes/obstacle/Obstacle.tscn")
onready var Marmotte = preload("res://scenes/obstacle/marmote.tscn")

func _ready():
	# Configure
	noise_collectable.seed = randi()
	noise_collectable.octaves = 4
	noise_collectable.period = 20.0
	noise_collectable.persistence = 0.8

	noise_rock.seed = randi()
	noise_rock.octaves = 4
	noise_rock.period = 20.0
	noise_rock.persistence = 0.8
	
	noise_water.seed = randi()
	noise_water.octaves = 4
	noise_water.period = 60.0
	noise_water.persistence = 0.8
	
	var texture = create_texture("res://assets/tiles/tiile_base.png")
	load_image_to_tilemap(texture, Vector2(size, size), Vector2(0, 0), 0)
	shape.set_extents(Vector2(size / 2, 10))
	$Area2D/CollisionShape2D.set_shape(shape)
#	set_deferred("shape", shape)
	$Area2D.set_position(Vector2(size / 2, size / 2))



func create_texture(path_img):
	var image = load(path_img) # Charge l'image PNG
	var tileset = TileSet.new() # Crée un nouveau tileset
	tileset.create_tile(1)
	tileset.tile_set_name(1, path_img)
	tileset.tile_set_texture(1, image)
	tileset.autotile_set_size(1, Vector2(image.get_width(), image.get_height()))
	return tileset

func load_image_to_tilemap(texture, size, position, biome):
	var tilemap = TileMap.new()
	var tmp_instance
	tilemap.set_tileset(texture)
	tilemap.set_cell_size(texture.autotile_get_size(1))
	var padding = (size_none * 4)

	# Boucle pour remplir le tileMap avec la taille définiepa
	for x in range(0, size.x + padding, texture.autotile_get_size(1).x):
		for y in range(0, size.y, texture.autotile_get_size(1).y):
			tilemap.set_cell(x / texture.autotile_get_size(1).x, y / texture.autotile_get_size(1).y, 1)
	for x in range(position.x, size.x + position.x, 10):
		for y in range(position.y, size.y + position.y, 10):
			if (noise_rock.get_noise_2d(x, y) >= 0.55 && biome == 0):
				tmp_instance = Marmotte.instance()
				tmp_instance.set_position(Vector2(x, y))
				call_deferred("add_child", tmp_instance)
				
			elif (noise_collectable.get_noise_2d(x, y) >= 0.47):
				tmp_instance = Collectable.instance()
				tmp_instance.create(biome)
				tmp_instance.set_position(Vector2(x, y))
#				add_child(tmp_instance)
				call_deferred("add_child", tmp_instance)
			elif (noise_rock.get_noise_2d(x, y) >= 0.47):
				tmp_instance = Rock.instance()
				tmp_instance.create(biome)
				tmp_instance.set_position(Vector2(x, y))
#				add_child(tmp_instance)
				call_deferred("add_child", tmp_instance)

#			set_deferred("position", Vector2(x, y))
#			tmp_instance.set_position(Vector2(x, y))
#			add_child(tmp_instance)
	tilemap.z_index = -1
	position.x -= padding / 2
	tilemap.position = position
	add_child(tilemap)


func _on_Area2D_body_entered(body):
	if body.get_name() == "Root":
		var texture
		var default_size = Vector2(size, size)
		var size_transition
		print(last.y)
		
		if last.y > ( size * 3 ) + size_none:
			texture = create_texture("res://assets/tiles/magma.png")
			load_image_to_tilemap(texture, default_size, last, 2 )
			last.y += size
		elif last.y >= size * 3 :
			texture = create_texture("res://assets/tiles/magma-transition.png")
			default_size = Vector2(size, size_none)

			load_image_to_tilemap(texture, default_size, last, 1)
			texture = create_texture("res://assets/tiles/magma.png")
			default_size = Vector2(size, size_none * 2)
			last.y += size_none
			load_image_to_tilemap(texture, default_size, last, 2 )
			last.y += size_none * 2
		elif last.y > ( size * 2 ) + size_none:
			texture = create_texture("res://assets/tiles/tiile_base_rock.png")
			load_image_to_tilemap(texture, default_size, last, 1 )
			last.y += size
		elif last.y >= size * 2 && last.y < ( size * 3 ) + size_none:
			texture = create_texture("res://assets/tiles/tile_transition.png")
			default_size = Vector2(size, size_none)

			load_image_to_tilemap(texture, default_size, last, 0)
			texture = create_texture("res://assets/tiles/tiile_base_rock.png")
			default_size = Vector2(size, size_none * 2)
			last.y += size_none
			load_image_to_tilemap(texture, default_size, last, 1 )
			last.y += size_none * 2
			


		else :
			texture = create_texture("res://assets/tiles/tiile_base.png")
			load_image_to_tilemap(texture, default_size, last , 0)

			last.y += size
		$Area2D/CollisionShape2D.set_shape(shape)
		$Area2D.set_position(Vector2(size / 2, last.y - (size / 2)))
