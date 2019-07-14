extends Node2D

class_name ActionMaker

var action_name = "action"
var color = Color.white

var active = false
var action

#This is different to an action. It is inherited by a unit, and describes
#An action that that unit COULD, THEORETIALLY perform.

#When the adjudicator receives an action, it will need to check that that
#action is in fact feasable before executing

#checks if the parent unit CAN perform the action, so whether or not to
#display that action as a HoldAndReleaseButton
func CheckPossible():
	return false

#takes an action and checks if it is an action this node could produce
func CheckLegal(action):
	return false

func MakeAction():
	pass

#all actions take only a mouse position (in local coordinates) to produce
#this function gets the action corresponding to the position.
func UpdateAction(action, pos):
	pass

#switches the action maker "on", creates an action and sets it as it's child
func SwitchOn():
	action = MakeAction()
	active = true
	add_child(action)

func SwitchOff():
	active = false
	
func _process(delta):
	if active: UpdateAction(action, get_local_mouse_position())