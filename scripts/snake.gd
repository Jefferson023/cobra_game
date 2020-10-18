extends Node2D

signal move_body
const body_scene = preload("res://body.tscn")
var occupied_positions = []
var move_end = true

func _ready():
	pass
	
func get_free_positions():
	var head = get_child(0)
	var max_rows = head.get_max_rows()
	var max_cols = head.get_max_columns()
	var free_positions = []
	while (move_end == false):
		print("entrou")
	for col in range(0, max_cols):
		for row in range(0, max_rows):
			var cell_pos = Vector2(col, row)
			var search = occupied_positions.find(cell_pos)
			if (search == -1):
				free_positions.append(cell_pos)
	move_end = false			
	return free_positions		
		
func get_cell_pos(free_cell_pos):
	var head = get_child(0)
	return head.get_position_from_cell_pos(free_cell_pos)

func _on_head_move(direction):
	occupied_positions = []
	for child_index in range(0, get_child_count()):
		var child = get_child(child_index)
		#se for parte do corpo, atualize a posição antes de adicionar 
		#nas ocupadas
		if (child_index > 0):
			var previous_body_part = get_child(child_index-1)
			var new_position = previous_body_part.get_previous_position()
			child.move(new_position)
			
		var cell_position = child.get_cell_pos()
		occupied_positions.append((cell_position))
	move_end = true
func _on_game_grow_snake():
	var body_part = body_scene.instance()
	var last_body_part = get_child(get_child_count()-1)
	var new_position = last_body_part.get_previous_position()
	body_part.position = new_position
	add_child(body_part)
