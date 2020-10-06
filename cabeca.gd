extends KinematicBody2D

export var velocidade = 50
var sentido_x = 0
var sentido_y = 0
var rotacao_angulo = 0

func _ready():
	pass
		
#verifica a posição para mover e ajusta o angulo
func troca_posicao(delta):
	if Input.is_action_just_pressed("ui_left") and sentido_x != 1:
		rotacao_angulo = 94*delta
		return [-1, 0]
	elif Input.is_action_just_pressed("ui_right") and sentido_x != -1:
		#rotation_dir = -63
		rotacao_angulo = -94*delta
		return [1, 0]
	elif Input.is_action_just_pressed("ui_up") and sentido_y != 1:
		rotacao_angulo = 94*2*delta
		return [0, -1]
	elif Input.is_action_just_pressed("ui_down") and sentido_y != -1:
		rotacao_angulo = 0
		return [0, 1]
	return [sentido_x, sentido_y]	
	
func _process(delta):
	var movimento = Vector2.ZERO
	var posicoes = troca_posicao(delta)
	if (posicoes[0] != sentido_x or posicoes[1] != sentido_y):
		sentido_x = posicoes[0]
		sentido_y = posicoes[1]
		rotation = rotacao_angulo
		
	#move a cobra
	movimento.x = delta*velocidade*sentido_x
	movimento.y = delta*velocidade*sentido_y
	move_and_collide(movimento)
	get_parent().emit_signal("movimentacao_corpo", delta, velocidade, sentido_x, sentido_y)
