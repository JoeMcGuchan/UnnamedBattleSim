extends Node2D

export var colour : Color

var alpha = 1
var t = 0

# alpha = sin(t) * amp + c
const AMP = 0.2
const C = 0.8
const FREQ = 2

func switch_on(unit):
	$Sprite.rotation = to_local(unit.global_position).angle()
	visible = true
	
func switch_off():
	visible = false
	
func _ready():
	modulate = Color(colour.r,colour.g,colour.b,alpha)
	
func _process(delta):
	t = fmod(t + delta * FREQ,TAU)
	alpha = sin(t) * AMP + C
	modulate = Color(colour.r,colour.g,colour.b,alpha)