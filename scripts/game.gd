extends Node2D

#cena da comida
const food_scene = preload("res://food.tscn")
#variável que armazena a comida que está sendo exibida
var food = null
#gerador de números aleatórios
var rng = RandomNumberGenerator.new()
#sinal a ser enviado quando a cobra tiver de crescer
signal grow_snake
#pontuação atual do jogador
var actual_score = 0
#objeto que armazena a pontuação anterior
var player_score = null

func _ready():
	#caso o jogo estivesse pausado antes de reiniciar, faz ele resumir
	get_tree().paused = false
	player_score = get_node("/root/PlayerScore")
	print("Last score: " + str(player_score.last_score))
	$score.text = "score: 0"
	#adiciona a primeira comida na tela
	erase_and_show_food()
	
func _process(delta):
	#se o jogo estava pausado e foi pressionado enter, reinicie a cena
	if (get_tree().paused == true and Input.is_action_just_pressed("ui_accept")):
		get_tree().reload_current_scene()
	#senão, se o jogo começou e foi precionado alguma tecla, limpe o texto.
	elif ((Input.is_action_just_pressed("ui_left") or Input.is_action_just_pressed("ui_right")
	or Input.is_action_just_pressed("ui_up") or Input.is_action_just_pressed("ui_down"))
	and get_tree().paused == false):
		$welcome_msg.text = ""

#função que tira a comida da tela e coloca em uma nova posição			
func erase_and_show_food():
	#libere o objeto comida
	if (food != null):
		food.queue_free()
	#crie um novo objeto comida	
	food = food_scene.instance()
	var snake = get_child(0)
	#espere até que a cobra tenha terminado de se mover
	yield(snake, "move_is_done")
	#seleciona uma posição aleatória para a comida
	food.position = select_random_position_food()
	add_child(food)

#função que seleciona uma posição aleatória com base nas posições livres	
func select_random_position_food():
	rng.randomize()
	var snake = get_child(0)
	var free_positions = snake.get_free_positions()
	var free_cell_pos = free_positions[rng.randi_range(0, 
	free_positions.size()-1)]
	return snake.get_cell_pos(free_cell_pos)

#função chamada caso haja uma colisão
func _on_head_area_shape_entered(area_id, area, area_shape, self_shape):
	#se a colisão foi com a comida, aumente o score, coloque nova comida
	# e emita um sinal pra cobra crescer
	if (food.get_instance_id() == area_id):
		emit_signal("grow_snake")
		erase_and_show_food()
		actual_score += 1
		$score.text = "score: " + str(actual_score)
	#se a colisão foi com o corpo, pause o jogo e espere para reiniciar	
	else:
		$welcome_msg.text = "Game Over. Press enter to restart"
		player_score.last_score = actual_score
		get_tree().paused = true
