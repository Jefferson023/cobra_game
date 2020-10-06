extends KinematicBody2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func movimenta(delta, velocidade, sentido_x, sentido_y):
	var movimento = Vector2.ZERO
	movimento.x = delta*velocidade*sentido_x
	movimento.y = delta*velocidade*sentido_y
	move_and_collide(movimento)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
