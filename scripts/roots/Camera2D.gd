extends Camera2D

var pad = 50


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(_delta):
	var parent = get_parent().get_parent().get_position()
	var v = get_viewport().get_size()
	position = parent
	position.x = clamp(position.x, v.x/2 - pad, v.x/2 + pad)
#	position.x = v.x / 2
	
#	position = Vector2(position.x + 100, position.y)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	var parent = get_parent().get_parent().get_position()
#	var view = get_viewport().get_size()
#	position.x = clamp(position.x, padding, view.x - padding)
#	position.y = parent.y
#	print(view, " ", parent)
