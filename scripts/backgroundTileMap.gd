extends Node2D

var current_level = 1
var map_set 

func _ready():
#	set_tileset_map()
	var texture = create_texture("res://assets/tiile_base.png")
	var tilemap = load_image_to_tilemap(texture, Vector2(599, 576))
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
	
	tilemap.set_tileset(texture)
	tilemap.set_cell_size(texture.autotile_get_size(1))
	
	# Boucle pour remplir le tileMap avec la taille définie
	for x in range(0, size.x, texture.autotile_get_size(1).x):
		for y in range(0, size.y, texture.autotile_get_size(1).y):
			print(x)
			tilemap.set_cell(x / texture.autotile_get_size(1).x, y / texture.autotile_get_size(1).y, 1)
	return tilemap

