extends KinematicBody2D

export var velocidade = 50
var x = 0
var y = 0

func _ready():
	pass
	
func _process(delta):
	var movimento = Vector2.ZERO
	
	#verifica a posição para mover
	var direcao_atual = ""
	if Input.is_action_just_pressed("ui_left") and x != 1:
		direcao_atual = "esquerda"
		x = -1
		y = 0
	elif Input.is_action_just_pressed("ui_right") and x != -1:
		direcao_atual = "direita"
		x = 1
		y = 0
	elif Input.is_action_just_pressed("ui_up") and y != 1:
		direcao_atual = "cima"
		x = 0
		y = -1
	elif Input.is_action_just_pressed("ui_down") and y != -1:
		direcao_atual = "baixo"	
		x = 0
		y = 1
	
	#move a cobra
	movimento.x = velocidade*delta*x
	movimento.y = velocidade*delta*y
	move_and_collide(movimento)
