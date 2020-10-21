extends Node2D

signal move_body
#sinal que verifica se o movimento acabou antes de colocar a comida na tela
signal move_is_done

#cena que representa o corpo da cobra
const body_scene = preload("res://body.tscn")
#variável que armazena as posições que estão ocupadas no momento
var occupied_positions = []
var all_positions = []

func _ready():
	var head = get_child(0)
	var max_rows = head.get_max_rows()
	var max_cols = head.get_max_columns()
	all_positions = []
	
	#seleciona todas as posições disponíveis
	for col in range(0, max_cols):
		for row in range(0, max_rows):
			var cell_pos = Vector2(col, row)
			all_positions.append(cell_pos)
	#começa emitindo o sinal de que o movimento já foi feito
	emit_signal("move_is_done")

#retorna as posições livres na tela	
func get_free_positions():
	var free_positions = []
	#verifica as posições que estão livres		
	for cell_position in all_positions:
		if (not (cell_position in occupied_positions)):
			free_positions.append(cell_position)	

	return free_positions	

#transforma uma celula em uma posição x e y		
func get_cell_pos(free_cell_pos):
	var head = get_child(0)
	return head.get_position_from_cell_pos(free_cell_pos)

#função que move o resto do corpo quando a cabeça se mover
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
		
	#emite o sinal quando o movimento acabou
	emit_signal("move_is_done")	
	
#função que cresce a cobra quando o sinal for emitido	
func _on_game_grow_snake():
	var body_part = body_scene.instance()
	#a posição da nova parte do corpo é a posição anterior da 
	#ultima parte do corpo da cobra
	var last_body_part = get_child(get_child_count()-1)
	var new_position = last_body_part.get_previous_position()
	body_part.position = new_position
	add_child(body_part)
