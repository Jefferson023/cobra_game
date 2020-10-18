extends Node2D

const food_scene = preload("res://food.tscn")
var food = null
var rng = RandomNumberGenerator.new()
signal grow_snake
var actual_score = 0
var player_score = null

func _ready():
	player_score = get_node("/root/PlayerScore")
	print("Last score: " + str(player_score.last_score))
	$score.text = "score: 0"
	erase_and_show_food()
	
func _process(delta):
	if (get_tree().paused == true and Input.is_action_just_pressed("ui_accept")):
		get_tree().reload_current_scene()
	elif ((Input.is_action_just_pressed("ui_left") or Input.is_action_just_pressed("ui_right")
	or Input.is_action_just_pressed("ui_up") or Input.is_action_just_pressed("ui_down"))
	and get_tree().paused == false):
		$welcome_msg.text = ""
			
func erase_and_show_food():
	if (food != null):
		food.queue_free()
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
		emit_signal("grow_snake")
		erase_and_show_food()
		actual_score += 1
		$score.text = "score: " + str(actual_score)
	else:
		$welcome_msg.text = "Game Over. Press enter to restart"
		player_score.last_score = actual_score
		get_tree().paused = true
