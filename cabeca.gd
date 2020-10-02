extends KinematicBody2D

export var velocidade = 50
var x = 0
var y = 0
var rotacao_angulo = 0

func _ready():
	pass
		
#verifica a posição para mover e ajusta o angulo
func troca_posicao(delta):
	if Input.is_action_just_pressed("ui_left") and x != 1:
		rotacao_angulo = 94*delta
		return [-1, 0]
	elif Input.is_action_just_pressed("ui_right") and x != -1:
		#rotation_dir = -63
		rotacao_angulo = -94*delta
		return [1, 0]
	elif Input.is_action_just_pressed("ui_up") and y != 1:
		rotacao_angulo = 94*2*delta
		return [0, -1]
	elif Input.is_action_just_pressed("ui_down") and y != -1:
		rotacao_angulo = 0
		return [0, 1]
	return [x, y]	
	
func _process(delta):
	var movimento = Vector2.ZERO
	var posicoes = troca_posicao(delta)
	if (posicoes[0] != x or posicoes[1] != y):
		x = posicoes[0]
		y = posicoes[1]
		rotation = rotacao_angulo
	#move a cobra
	movimento.x = velocidade*delta*x
	movimento.y = velocidade*delta*y
	move_and_collide(movimento)
