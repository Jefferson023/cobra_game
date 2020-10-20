extends Node2D

signal move_body
#cena que representa o corpo da cobra
const body_scene = preload("res://body.tscn")
#variável que armazena as posições que estão ocupadas no momento
var occupied_positions = []
#variável que verifica se o movimento acabou antes de colocar a comida na tela
var move_end = true

func _ready():
	pass
	
func get_free_positions():
	#espera até todo o corpo se mover
	while (move_end == false):		
		pass
		
	var head = get_child(0)
	var max_rows = head.get_max_rows()
	var max_cols = head.get_max_columns()
	var all_positions = []
	var free_positions = []
	
	for col in range(0, max_cols):
		for row in range(0, max_rows):
			var cell_pos = Vector2(col, row)
			all_positions.append(cell_pos)
			
	for cell_position in all_positions:
		if (not (cell_position in occupied_positions)):
			free_positions.append(cell_position)	
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
