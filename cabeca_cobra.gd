extends KinematicBody2D

var n_rows = 0
var n_cols = 0
var cell_width = 0
var cell_height = 0
var direction = Vector2.ZERO
var cell_pos = Vector2.ZERO

func _ready():
	var viewport = get_viewport_rect()
	cell_width = $cobra_sprite.texture.get_width()
	cell_height = $cobra_sprite.texture.get_height()
	n_rows = ceil(viewport.size.y/cell_height)
	n_cols = ceil(viewport.size.x/cell_width)

func get_cell_pos(cell):
	var x = cell.x
	var y = cell.y
	return Vector2(x*cell_width + (cell_width/2), y*cell_height + (cell_height/2))

func _process(delta):
	if (Input.is_action_just_pressed("ui_up")):
		direction = Vector2.UP
	elif (Input.is_action_just_pressed("ui_down")):
		direction = Vector2.DOWN
	elif (Input.is_action_just_pressed("ui_left")):
		direction = Vector2.LEFT
	elif (Input.is_action_just_pressed("ui_right")):
		direction = Vector2.RIGHT		
		
	#move_and_collide(get_cell_pos(cell_pos))


func _on_Timer_timeout():
	cell_pos += direction
	position = get_cell_pos(cell_pos)
