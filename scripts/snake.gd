extends Node2D

signal move_body
const body_scene = preload("res://body.tscn")
var occupied_positions = []

func _ready():
	pass
	
func get_free_positions():
	var head = get_child(0)
	var max_rows = head.get_max_rows()
	var max_cols = head.get_max_columns()
	var free_positions = []
	
	for col in range(0, max_cols):
		for row in range(0, max_rows):
			var cell_pos = Vector2(col, row)
			var search = occupied_positions.find(cell_pos)
			if (search == -1):
				free_positions.append(cell_pos)
	return free_positions		
		
func get_cell_pos(free_cell_pos):
	var head = get_child(0)
	return head.get_position_from_cell_pos(free_cell_pos)

func _on_head_move(direction):
	if (get_child_count() > 1):
		#mover todas as outras partes
		pass
	occupied_positions = []
	for child_index in range(0, get_child_count()):
		var cell_position = get_child(child_index).get_cell_pos()
		occupied_positions.append((cell_position))
		
func _on_game_grow_snake():
	var body_part = body_scene.instance()
	var last_body_part = get_child(get_child_count()-1)
	var direction = last_body_part.get_cell_direction()
	var cell_pos = last_body_part.get_cell_pos() - direction
	add_child(body_part)
	body_part.set_cell_direction(direction)
	body_part.set_cell_pos(cell_pos)
	body_part.update_position()
