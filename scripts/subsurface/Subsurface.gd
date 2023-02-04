extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
#var backgrounlen = 3 * 176
#var backgrounlen = 9 * 176 

# Called when the node enters the scene tree for the first time.
func _ready():
	var v = get_viewport().get_size()
	$background.position.x = v.x / 2 - $background.get_tile_size() / 2
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
