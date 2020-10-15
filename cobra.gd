extends Node2D

func _ready():
	var viewport = get_viewport_rect()
	position.x = viewport.size.x/2
	position.y = viewport.size.y/2

#func _process(delta):
#	pass


func _on_Timer_timeout():
	pass # Replace with function body.
