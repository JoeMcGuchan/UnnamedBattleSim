extends Control

export var active = false

#always smaller inactive than active!
const ACTIVE_BOTTOM_MARGIN = 96
const INACTIVE_BOTTOM_MARGIN = -32
const CHANGE_SPEED = 128

var maxMarg
var minMarg
var activeDir

func _process(delta):
	if active and margin_bottom < ACTIVE_BOTTOM_MARGIN:
		margin_bottom = min(margin_bottom + delta*CHANGE_SPEED,ACTIVE_BOTTOM_MARGIN)
	else: if not active and margin_bottom > INACTIVE_BOTTOM_MARGIN:
		margin_bottom = max(margin_bottom - delta*CHANGE_SPEED,INACTIVE_BOTTOM_MARGIN)
		
func activate():
	active = true
	
func deactivate():
	active = false