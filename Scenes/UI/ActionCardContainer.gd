extends HBoxContainer

var alpha = 1
export var active = true

const FADE_SPEED = 3

func _process(delta):
	if active and alpha < 1:
		alpha = min(alpha + FADE_SPEED * delta, 1)
		modulate = Color(1,1,1,alpha)
	else: if not active and alpha > 0:
		alpha = max(alpha - FADE_SPEED * delta, 0)
		modulate = Color(1,1,1,alpha)
		
func activate():
	active = true
	
func deactivate():
	active = false