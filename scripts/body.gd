extends Area2D
#classe genérica de um corpo da cobra
class_name body

#variável que indica se essa parte do corpo é uma cobra ou não
export var is_head = false
var n_rows = 0
var n_cols = 0
var cell_width = 0
var cell_height = 0
#armazena a celula em que a parte está
var cell_pos = Vector2.ZERO
#armazena a direção do movimento
var direction = Vector2.ZERO
#armazena a posiçao anterior
var previous_position = Vector2.ZERO

func _ready():
	var viewport = get_viewport_rect()
	cell_width = $snake_sprite.texture.get_width()
	cell_height = $snake_sprite.texture.get_height()
	n_rows = ceil(viewport.size.y/cell_height)
	n_cols = ceil(viewport.size.x/cell_width)
	
	#se for a cabeça, comece no meio
	if (is_head == true):
		cell_pos = Vector2(n_cols/2, n_rows/2)
		position = get_position_from_cell_pos(cell_pos)

#converte uma posição de celula em uma posição x e y	
func get_position_from_cell_pos(cell):
	var x = cell.x
	var y = cell.y
	return Vector2(x*cell_width + (cell_width/2), y*cell_height + (cell_height/2))

func get_previous_position():
	return previous_position

#move a parte do corpo e atualiza a posição anteiror	
func move(new_position):
	previous_position = position
	position = new_position

func get_cell_pos():
	return cell_pos

func get_cell_direction():
	return direction	
	
func set_cell_pos(cell_pos):
	self.cell_pos = cell_pos
	
func set_cell_direction(direction):
	self.direction = direction
