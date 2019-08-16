extends Path2D

class_name AttackArrow,"res://Resources/Sprites/Attack.png"

export var fwd_accl : float = 20
export var fwd_speed : float = 20
export var bkwd_accl : float = 2
export var bkwd_speed : float = 4

export var colour : Color

var fwd = true
var speed = 0
var pos = 0

const CROP_START = 12
const CROP_END = 24

func _ready():
	modulate = colour

func _process(delta):
	if fwd:
		if speed < fwd_speed:
			speed = min(fwd_speed, speed + delta * fwd_accl)
		if pos < curve.get_baked_length() - CROP_END:
			pos = min(curve.get_baked_length() - CROP_END, pos + delta * speed)
		else:
			speed = 0
			fwd = false
	else:
		if speed < bkwd_speed:
			speed = min(bkwd_speed, speed + delta * bkwd_accl)
		if pos > CROP_START:
			pos = max(CROP_START, pos - delta * speed)
		else:
			speed = 0
			fwd = true
	
	$PathFollow2D.offset = pos
	
func switch_on(unit):
	curve.set_point_position(0,Vector2(0,0))
	curve.set_point_position(1,to_local(unit.global_position))
	visible = true
	
func switch_off():
	visible = false