extends TileMap

var current_level = 1

func _ready():
	set_tileset_background()

func set_tileset_background():
	var tileset
	if current_level == 1:
		tileset = load("res://assets/basic-platformer-tileset.png")
	elif current_level == 2:
		tileset = load("res://assets/basic-platformer-tileset.png")
	else:
		tileset = load("res://assets/basic-platformer-tileset.png")
		
	var tile_width = tileset.get_tile_width()
	var tile_height = tileset.get_tile_height()
	set_cell_size(Vector2(tile_width, tile_height))
	set_tileset(tileset)
