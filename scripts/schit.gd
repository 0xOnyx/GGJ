func fill_with_tileset(tileset, size):
	set_cell_size(Vector2(tileset.get_tile_width(), tileset.get_tile_height()))
	set_tileset(tileset)

	var x_count = size.x / tileset.get_tile_width()
	var y_count = size.y / tileset.get_tile_height()

	for x in range(x_count):
		for y in range(y_count):
			set_cell(x, y, 1)

func set_tileset_map():
	var size = Vector2(1024, 768)
	Image.new()
	if current_level == 1:
		map_set = load("res://assets/tiile_base.png")
	elif current_level == 2:
		map_set = load("res://assets/tiile_base.png")
	else:
		map_set = load("res://assets/tiile_base.png")
	var tileset = TileSet.new()
	tileset.tile_size = Vector2(176, 176)
	tileset.orientation = TileSet.ORIENTATION_ORTHOGONAL
	tileset.add_tile(map_set)


