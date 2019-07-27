extends Node2D

class_name ActionMaker

export var card_text : String
export var card_colour : Color

export var overlay_title : String
export var overlay_description : String
export var overlay_colour : Color

var active = false
var action

#This is different to an action. It is inherited by a unit, and describes
#An action that that unit COULD, THEORETIALLY perform.

#When the adjudicator receives an action, it will need to check that that
#action is in fact feasable before executing

#checks if the parent unit CAN perform the action, so whether or not to
#display that action as a HoldAndReleaseButton
func check_possible():
	return false

#takes an action and checks if it is an action this node could produce
func check_legal(action):
	return false

func make_action():
	pass

#all actions take only a mouse position (in local coordinates) to produce
#this function gets the action corresponding to the position.
func update_action(action, pos):
	pass

func draw_active(delta):
	#draw_line(Vector2(0,0),get_local_mouse_position(),overlay_colour,1.0)
	pass

#switches the action maker "on"
func switch_on():
	active = true

#switched action maker "off", making an action in the process
func switch_off():
	action = make_action()
	add_child(action)
	update_action(action,get_local_mouse_position())
	active = false

func _process(delta):
	if active: draw_active(delta)