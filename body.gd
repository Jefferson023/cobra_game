extends Area2D
class_name body

export var is_head = false
var n_rows = 0
var n_cols = 0
var cell_width = 0
var cell_height = 0
var cell_pos = Vector2.ZERO
var direction = Vector2.ZERO

func _ready():
	var viewport = get_viewport_rect()
	cell_width = $snake_sprite.texture.get_width()
	cell_height = $snake_sprite.texture.get_height()
	n_rows = ceil(viewport.size.y/cell_height)
	n_cols = ceil(viewport.size.x/cell_width)
	
	if (is_head == true):
		cell_pos = Vector2(n_cols/2, n_rows/2)
		position = get_position_from_cell_pos(cell_pos)
	
func get_position_from_cell_pos(cell):
	var x = cell.x
	var y = cell.y
	return Vector2(x*cell_width + (cell_width/2), y*cell_height + (cell_height/2))

func move():
	pass

func get_cell_pos():
	return cell_pos

func get_cell_direction():
	return direction	
	
func update_position():
	position = get_position_from_cell_pos(cell_pos)	
	
func set_cell_pos(cell_pos):
	self.cell_pos = cell_pos
	
func set_cell_direction(direction):
	self.direction = direction
