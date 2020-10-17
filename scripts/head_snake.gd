extends Area2D

var n_rows = 0
var n_cols = 0
var cell_width = 0
var cell_height = 0
var direction = Vector2.ZERO
var cell_pos = null
var delta2 = 0

func _ready():
	var viewport = get_viewport_rect()
	cell_width = $snake_sprite.texture.get_width()
	cell_height = $snake_sprite.texture.get_height()
	n_rows = ceil(viewport.size.y/cell_height)
	n_cols = ceil(viewport.size.x/cell_width)
	cell_pos = Vector2(n_cols/2, n_rows/2)
	position = get_cell_pos(cell_pos)
	
func get_cell_pos(cell):
	var x = cell.x
	var y = cell.y
	return Vector2(x*cell_width + (cell_width/2), y*cell_height + (cell_height/2))

func get_max_rows():
	return n_rows

func get_max_columns():
	return n_cols	
	
func _process(delta):
	if (Input.is_action_just_pressed("ui_up")):
		direction = Vector2.UP
	elif (Input.is_action_just_pressed("ui_down")):
		direction = Vector2.DOWN
	elif (Input.is_action_just_pressed("ui_left")):
		direction = Vector2.LEFT
	elif (Input.is_action_just_pressed("ui_right")):
		direction = Vector2.RIGHT	
	var delta2 = delta		

func _on_Timer_timeout():
	if (cell_pos.x < 0):
		cell_pos.x = n_cols
		
	elif (cell_pos.x > n_cols):
		cell_pos.x = 0
		
	elif (cell_pos.y < 0):
		cell_pos.y = n_rows
		
	elif (cell_pos.y > n_rows):
		cell_pos.y = 0
	
	cell_pos += direction
	position = get_cell_pos(cell_pos)	
