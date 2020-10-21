extends body
#sinal responsável por informar ao nó cobra que a cabeça foi movida
signal move(direction)
#variável que verifica se pode mudar de direção, 
#para evitar que o jogador mude a direção muito rápido
var can_change_direction = true

#função que verifica se o jogador está dentro da parede
func is_inside_wall():
	var viewport = get_viewport_rect()
	if (position.x < 0 or position.x > viewport.size.x
	or position.y < 0 or position.y > viewport.size.y):
		return true
	return false
		
func _process(delta):
	if (Input.is_action_just_pressed("ui_up") and self.direction != Vector2.DOWN 
	and self.can_change_direction and not is_inside_wall()):
		self.direction = Vector2.UP
		self.can_change_direction = false
		
	elif (Input.is_action_just_pressed("ui_down") and self.direction != Vector2.UP 
	and self.can_change_direction and not is_inside_wall()):
		self.direction = Vector2.DOWN
		self.can_change_direction = false
		
	elif (Input.is_action_just_pressed("ui_left") and self.direction != Vector2.RIGHT 
	and self.can_change_direction and not is_inside_wall()):
		self.direction = Vector2.LEFT
		self.can_change_direction = false
		
	elif (Input.is_action_just_pressed("ui_right") and self.direction != Vector2.LEFT 
	and self.can_change_direction and not is_inside_wall()):
		self.direction = Vector2.RIGHT
		self.can_change_direction = false	

#sinal do timer para movimentar a cobra
func _on_Timer_timeout():
	self.cell_pos += self.direction
	
	if (self.cell_pos.x < 0):
		self.cell_pos.x = self.n_cols
		
	elif (self.cell_pos.x > n_cols):
		self.cell_pos.x = 0
		
	elif (self.cell_pos.y < 0):
		self.cell_pos.y = self.n_rows
		
	elif (self.cell_pos.y > self.n_rows):
		self.cell_pos.y = 0
	
	self.previous_position = self.position
	self.position = self.get_position_from_cell_pos(self.cell_pos)	
	emit_signal("move", self.direction)
	self.can_change_direction = true

func get_max_rows():
	return self.n_rows

func get_max_columns():
	return self.n_cols	
