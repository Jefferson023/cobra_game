extends Node2D

signal move_body
const body_scene = preload("res://body.tscn")

func _ready():
	pass
	
func get_free_columns():
	var head = get_child(0)
	var max_columns = head.get_max_columns()
	var free_columns = []
	
	if (get_child_count() == 1):
		for column in range(0, max_columns):
			if (column != max_columns/2):
				free_columns.append(column)
	return free_columns
	
func get_free_rows():
	var head = get_child(0)
	var max_rows = head.get_max_rows()
	var free_rows = []
	
	#adicionar condição caso tenha mais de uma parte da cobra
	if (get_child_count() == 1):
		for row in range(0, max_rows):
			if (row != max_rows/2):
				free_rows.append(row)
				
	return free_rows
	
func get_cell_pos(x, y):
	var head = get_child(0)
	return head.get_position_from_cell_pos(Vector2(x, y))

func _on_head_move(direction):
	if (get_child_count() > 1):
		pass

func _on_game_grow_snake():
	var body_part = body_scene.instance()
	var last_body_part = get_child(get_child_count()-1)
	var direction = last_body_part.get_cell_direction()
	var cell_pos = last_body_part.get_cell_pos() - direction
	body_part.set_cell_direction(direction)
	body_part.set_cell_pos(cell_pos)
