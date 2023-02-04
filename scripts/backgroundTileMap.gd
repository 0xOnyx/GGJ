extends Node2D

var current_level = 1
var map_set 
var size = 1760;
var last = Vector2(0, size)

var shape = RectangleShape2D.new()
var noise_collectable = OpenSimplexNoise.new()
var noise_rock = OpenSimplexNoise.new()
onready var Collectable = preload("res://scenes/collectable/Collectable.tscn")
onready var Rock = preload("res://scenes/obstacle/Obstacle.tscn")

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
	var texture = create_texture("res://assets/tiile_base.png")
	load_image_to_tilemap(texture, Vector2(size, size), Vector2(0, 0) )
	shape.set_extents(Vector2(size / 2, 10))
	$Area2D/CollisionShape2D.set_shape(shape)
	$Area2D.set_position(Vector2(size / 2, size / 2))
	


func create_texture(path_img):
	var image = load(path_img) # Charge l'image PNG
	var tileset = TileSet.new() # Crée un nouveau tileset
	tileset.create_tile(1)
	tileset.tile_set_name(1, path_img)
	tileset.tile_set_texture(1, image)
	tileset.autotile_set_size(1, Vector2(image.get_width(), image.get_height()))
	return tileset

func load_image_to_tilemap(texture, size, position):
	var tilemap = TileMap.new()
	var tmp_instance
	tilemap.set_tileset(texture)
	tilemap.set_cell_size(texture.autotile_get_size(1))
	
	# Boucle pour remplir le tileMap avec la taille définiepa
	for x in range(0, size.x, texture.autotile_get_size(1).x):
		for y in range(0, size.y, texture.autotile_get_size(1).y):
			tilemap.set_cell(x / texture.autotile_get_size(1).x, y / texture.autotile_get_size(1).y, 1)
			
	for x in range(0, size.x, 10):
		for y in range(0, size.y, 10):
			if (noise_collectable.get_noise_2d(x, y) >= 0.4):
				tmp_instance = Collectable.instance()
				tmp_instance.set_position(Vector2(x, y))
				add_child(tmp_instance)
			elif (noise_rock.get_noise_2d(x, y) >= 0.47):
				tmp_instance = Rock.instance()
				tmp_instance.set_position(Vector2(x, y))
				add_child(tmp_instance)
	tilemap.z_index = -1
	tilemap.position = position
	add_child(tilemap)




func _on_Area2D_body_entered(body):
	if body.get_name() == "Root":
		var texture = create_texture("res://assets/tiile_base.png")
		load_image_to_tilemap(texture, Vector2(size, size), last )
		last.y += size
		$Area2D/CollisionShape2D.set_shape(shape)
		$Area2D.set_position(Vector2(size / 2, last.y - (size / 2)))
		print("COOOLISIONNNN!")

