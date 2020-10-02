extends KinematicBody2D

export var velocidade = 50
var x = 0
var y = 0
func _ready():
	pass
func rotacao(delta):
	var teste = Vector2(velocidade*delta*x, velocidade*delta*y)
	#var rotation = Vector2(position.x*delta, position.y*delta).angle_to(teste)
	rotation = Vector2(position.x, position.y).angle_to_point(teste)
	print(rotation*delta)
	return rotation*delta
#verifica a posição para mover
func troca_posicao():
	if Input.is_action_just_pressed("ui_left") and x != 1:
		return [-1, 0]
	elif Input.is_action_just_pressed("ui_right") and x != -1:
		return [1, 0]
	elif Input.is_action_just_pressed("ui_up") and y != 1:
		return [0, -1]
	elif Input.is_action_just_pressed("ui_down") and y != -1:
		return [0, 1]
	return [x, y]	
func _process(delta):
	var movimento = Vector2.ZERO
	var posicoes = troca_posicao()
	if (posicoes[0] != x or posicoes[1] != y):
		x = posicoes[0]
		y = posicoes[1]
		rotate(rotacao(delta))
	#move a cobra
	movimento.x = velocidade*delta*x
	movimento.y = velocidade*delta*y
	move_and_collide(movimento)
