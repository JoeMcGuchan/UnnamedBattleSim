extends Path2D

class_name AttackArrow,"res://Resources/Sprites/Attack.png"

export var fwd_accl : float = 100
export var fwd_speed : float = 100
export var bkwd_accl : float = 5
export var bkwd_speed : float = 10

export var colour : Color

var fwd = true
var speed = 0
var pos = 0

func _ready():
	modulate = colour

func _process(delta):
	if fwd:
		if speed < fwd_speed:
			speed = min(fwd_speed, speed + delta * fwd_accl)
		if pos < curve.get_baked_length():
			pos = min(curve.get_baked_length(), pos + delta * speed)
		else:
			speed = 0
			fwd = false
	else:
		if speed < bkwd_speed:
			speed = min(bkwd_speed, speed + delta * bkwd_accl)
		if pos > 0:
			pos = max(0, pos - delta * speed)
		else:
			speed = 0
			fwd = true
	
	$PathFollow2D.offset = pos