extends Area2D
class_name body

var cell_pos = Vector2.ZERO
var direction = Vector2.ZERO

func _ready():
	pass # Replace with function body.

func move():
	pass

func get_cell_pos():
	return cell_pos

func get_cell_direction():
	return direction	
	
func set_cell_pos(cell_pos):
	self.cell_pos = cell_pos
	
func set_cell_direction(direction):
	self.direction = direction
