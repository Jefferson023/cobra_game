extends Node2D

signal movimentacao_corpo

#armazena 1 se deve realizar uma curva na i-esima parte do corpo
var realiza_curva = []

func _ready():
	var viewport = get_viewport_rect()
	position.y = viewport.size.y/2
	position.x = viewport.size.x/2
	self.connect("movimentacao_corpo", self, "_movimentacao_corpo_cobra")
	#self.connect("curva", self, "_curva_corpo_cobra")
	
func _movimentacao_corpo_cobra(delta, velocidade, sentido_x, sentido_y):
	if (self.get_child_count() == 2):
		self.get_child(1).movimenta(delta, velocidade, sentido_x, sentido_y)
	else:
		pass	
		
func _curva_corpo_cobra():
	pass	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
