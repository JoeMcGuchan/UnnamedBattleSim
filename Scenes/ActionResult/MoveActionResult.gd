extends ActionResult

export var endpoint : Vector2 = Vector2(0,0)

#initialise with a curve and a percentage that move action
#should be completed by
func initialise(path : Curve2D, completion : float):
	pass

func resolve():
	get_parent().position += endpoint
	queue_free()
	pass