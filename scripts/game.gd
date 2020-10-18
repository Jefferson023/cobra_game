extends Node2D

const food_scene = preload("res://food.tscn")
var food = null
var rng = RandomNumberGenerator.new()
signal grow_snake

func _ready():
	erase_and_show_food()
	
func erase_and_show_food():
	if (food != null):
		food.free()
	food = food_scene.instance()
	food.position = select_random_position_food()
	add_child(food)
	
func select_random_position_food():
	rng.randomize()
	var snake = get_child(0)
	var free_positions = snake.get_free_positions()
	var free_cell_pos = free_positions[rng.randi_range(0, 
	free_positions.size()-1)]
	return snake.get_cell_pos(free_cell_pos)

func _on_head_area_shape_entered(area_id, area, area_shape, self_shape):
	if (food.get_instance_id() == area_id):
		erase_and_show_food()
		#aumentar os pontos
		emit_signal("grow_snake")
	else:
		print("colidiu com o corpo")	
