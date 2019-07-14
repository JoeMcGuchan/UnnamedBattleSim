extends Control

var alpha = 0
export var active = false

const FADE_SPEED = 1

func _process(delta):
	if active and alpha < 1:
		alpha = min(alpha + FADE_SPEED * delta, 1)
		modulate = Color(1,1,1,alpha)
	else: if not active and alpha > 0:
		alpha = max(alpha - FADE_SPEED * delta, 0)
		modulate = Color(1,1,1,alpha)
		
func activate(title,description,colour):
	active = true
	$MarginContainer/VBoxContainer/NameOfAction.text = title
	$MarginContainer/VBoxContainer/DescriptionOfAction.text = description
	$TextureRect.modulate = colour
	
func deactivte():
	active = false