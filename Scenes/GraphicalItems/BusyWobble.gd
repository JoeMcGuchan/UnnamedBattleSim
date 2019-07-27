extends Node2D

class_name BusyWobble,"res://Resources/Sprites/Icons/BusyWobble.png"

#causes the children nodes to wobble excitedly when active

enum ACTIVITY_LEVEL {OFF, LOW, HIGH}

const WOBBLE_AMPLITUDE_LOW = 1
const WOBBLE_FREQUENCY_LOW = 0.05

const WOBBLE_AMPLITUDE_HIGH = 1
const WOBBLE_FREQUENCY_HIGH = 0.1

var xsin
var ysin

var mode = ACTIVITY_LEVEL.HIGH

func _ready():
	xsin = randf()*TAU
	ysin = randf()*TAU
	
func _process(delta):
	if mode == ACTIVITY_LEVEL.LOW:
		xsin = fmod(xsin + randf()*WOBBLE_FREQUENCY_LOW,TAU)
		ysin = fmod(ysin + randf()*WOBBLE_FREQUENCY_LOW,TAU)
		position = Vector2(sin(xsin) * WOBBLE_AMPLITUDE_LOW, sin(ysin) * WOBBLE_AMPLITUDE_LOW)
	else: if mode == ACTIVITY_LEVEL.HIGH:
		xsin = fmod(xsin + randf()*WOBBLE_FREQUENCY_HIGH,TAU)
		ysin = fmod(ysin + randf()*WOBBLE_FREQUENCY_HIGH,TAU)
		position = Vector2(sin(xsin) * WOBBLE_AMPLITUDE_HIGH, sin(ysin) * WOBBLE_AMPLITUDE_HIGH)
		
func set_mode(new_mode):
	mode = new_mode
	if new_mode == ACTIVITY_LEVEL.OFF: position = Vector2(0,0)