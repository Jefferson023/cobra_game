extends Node2D

const food_scene = preload("res://food.tscn")
var food = null
var rng = RandomNumberGenerator.new()

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
	var free_columns = snake.get_free_columns()
	var free_rows = snake.get_free_rows()
	var x = free_columns[rng.randi_range(0, free_columns.size()-1)]
	var y = free_rows[rng.randi_range(0, free_rows.size()-1)]
	return snake.get_cell_pos(x, y)

func _on_head_area_shape_entered(area_id, area, area_shape, self_shape):
	if (food.get_instance_id() == area_id):
		erase_and_show_food()
	else:
		print("colidiu com o corpo")	
