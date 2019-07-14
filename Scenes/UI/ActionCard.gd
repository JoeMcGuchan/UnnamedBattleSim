extends Control

#this node can be picked up and dragged away from it's starting location, after a certain distance it sends a signal
#just like a button would.

signal card_selected
signal card_released
signal update_overlay(title, desc, color)
signal deactivate_overlay

export var text : String
export var color : Color

export var overlay_title : String
export var overlay_description : String
export var overlay_colour : Color

const ATTRACTION_TO_MOUSE = 0.5
const ATTRACTION_TO_CENTER = 0.1

const WOBBLE_AMPLITUDE = 2
const WOBBLE_FREQENCY = 0.01

const RELEASE_DISTANCE = 100

var xsin = 0
var ysin = 0

var chosen = false
var centerpoint

func _ready():
	$Center/Button/Label.text = text
	modulate = color
	centerpoint = rect_size/2

func _on_TextureButton_button_down():
	chosen = true

func _on_TextureButton_button_up():
	emit_signal("card_released")
	emit_signal("deactivate_overlay")
	chosen = false

func _process(delta):
	var pos = $Center.position + centerpoint
	if chosen:
		pos = (1 - ATTRACTION_TO_MOUSE) * pos + ATTRACTION_TO_MOUSE * get_local_mouse_position()
		if pos.y < -RELEASE_DISTANCE:
			emit_signal("card_selected")
			emit_signal("update_overlay",overlay_title,overlay_description,overlay_colour)
	else:
		xsin = fmod(xsin + randf()*WOBBLE_FREQENCY,TAU)
		ysin = fmod(ysin + randf()*WOBBLE_FREQENCY,TAU)
	
		var attract_to = Vector2(sin(xsin),sin(ysin))*WOBBLE_AMPLITUDE + centerpoint
	
		pos = (1 - ATTRACTION_TO_CENTER) * pos + ATTRACTION_TO_CENTER * attract_to
	$Center.position = pos - centerpoint