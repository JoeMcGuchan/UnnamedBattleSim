extends ColorRect

#this node can be picked up and dragged away from it's starting location, after a certain distance it sends a signal
#just like a button would.

var alpha = 0
const FADE_IN_RATE = 5
	
func _process(delta):
	if alpha < 1:
		modulate.a = alpha
		alpha = alpha + delta * FADE_IN_RATE
	else: modulate.a = 1
	
func set_alpha(a):
	alpha = a
	
func get_middle_point():
	return $MiddlePoint