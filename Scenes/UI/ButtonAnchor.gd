extends Node2D

#moves towards mouse when active, otherwise moves

signal card_selected
signal card_released
signal update_overlay(title, desc, color)
signal deactivate_overlay

export var card_text : String
export var card_colour : Color

export var overlay_title : String
export var overlay_description : String
export var overlay_colour : Color

const ATTRACTION_TO_MOUSE = 0.5
const ATTRACTION_TO_CENTER = 0.1

const RELEASE_DISTANCE = 120

enum STATE {PRESSED,SELECTED,RELEASED}
var current_state = STATE.RELEASED

var node_followed

var alpha = 0

const FADE_OUT = 2
const FADE_IN = 2

func _ready():
	$BusyWobble/Button/Label.text = card_text
	card_colour.a = alpha
	modulate = card_colour

func set_following(node):
	node_followed = node

func _process(delta):
	if current_state == STATE.RELEASED:
		position += to_local(node_followed.global_position)*ATTRACTION_TO_CENTER
		if alpha < 1:
			alpha = min(1,alpha + delta * FADE_IN)
			card_colour.a = alpha
			modulate = card_colour 
	else:
		position += get_local_mouse_position()*ATTRACTION_TO_MOUSE
		if current_state == STATE.SELECTED:
			if alpha > 0:
				alpha = max(0,alpha - delta * FADE_OUT)
				card_colour.a = alpha
				modulate = card_colour 
			if node_followed.global_position.y - position.y < RELEASE_DISTANCE:
				update_state(STATE.PRESSED)
		else: 
			if node_followed.global_position.y - position.y > RELEASE_DISTANCE:
				update_state(STATE.SELECTED)
			if alpha < 1:
				alpha = min(1,alpha + delta * FADE_IN)
				card_colour.a = alpha
				modulate = card_colour 

func update_state(state):
	if state == STATE.RELEASED:
		if current_state == STATE.SELECTED:
			emit_signal("card_released")
			emit_signal("deactivate_overlay")
		current_state = STATE.RELEASED
		$BusyWobble.set_mode($BusyWobble.ACTIVITY_LEVEL.OFF)
		pass
	else: if state == STATE.SELECTED:
		current_state = STATE.SELECTED
		emit_signal("update_overlay",overlay_title,overlay_description,overlay_colour)
		emit_signal("card_selected")
		pass
	else: if state == STATE.PRESSED:
		if current_state == STATE.SELECTED:
			print("deactivate")
			emit_signal("deactivate_overlay")
		$BusyWobble.set_mode($BusyWobble.ACTIVITY_LEVEL.OFF)
		current_state = STATE.PRESSED
		pass

func _on_Button_button_down():
	update_state(STATE.PRESSED)


func _on_Button_button_up():
	update_state(STATE.RELEASED)
