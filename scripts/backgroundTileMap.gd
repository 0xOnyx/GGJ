extends Node2D

var current_level = 1
var map_set 

var noise = OpenSimplexNoise.new()
onready var Collectable = load("res://scenes/collectable.tscn")

func _ready():
	# Configure
	noise.seed = randi()
	noise.octaves = 4
	noise.period = 20.0
	noise.persistence = 0.8
#	set_tileset_map()
	var texture = create_texture("res://assets/tiile_base.png")
	var tilemap = load_image_to_tilemap(texture, Vector2(1000, 2000))
	tilemap.z_index = -1
	add_child(tilemap)

func create_texture(path_img):
	var image = load(path_img) # Charge l'image PNG
	var tileset = TileSet.new() # Crée un nouveau tileset
	tileset.create_tile(1)
	tileset.tile_set_name(1, path_img)
	tileset.tile_set_texture(1, image)
	tileset.autotile_set_size(1, Vector2(image.get_width(), image.get_height()))
	return tileset

func load_image_to_tilemap(texture, size):
	var tilemap = TileMap.new()
	var collect_tmp
	tilemap.set_tileset(texture)
	tilemap.set_cell_size(texture.autotile_get_size(1))
	
	# Boucle pour remplir le tileMap avec la taille définie
	for x in range(0, size.x, texture.autotile_get_size(1).x):
		for y in range(0, size.y, texture.autotile_get_size(1).y):
			
			
			for x_x in range(0, x, 10):
				for y_y in range(0, y, 10):
					var noise_res = noise.get_noise_2d(x_x, y_y)
					if (noise_res >= 0.6):
						collect_tmp = Collectable.instance()
						collect_tmp.set_position(Vector2(x_x, y_y))
						add_child(collect_tmp)
						x_x += 2000
						y_y += 2000
			tilemap.set_cell(x / texture.autotile_get_size(1).x, y / texture.autotile_get_size(1).y, 1)
	return tilemap

