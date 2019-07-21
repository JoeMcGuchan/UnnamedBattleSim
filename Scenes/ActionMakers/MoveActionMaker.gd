extends ActionMaker

#class contains all the LIMITIATIONS on a move action.

class_name MoveActionMaker,"res://Resources/Sprites/MoveIcon.png"

var speed = 1
var max_distance = 100

var move_action_scene = preload("res://Scenes/Actions/MoveAction.tscn") 

#checks if the parent unit CAN perform the action, so whether or not to
#display that action as a HoldAndReleaseButton
func check_possible():
	return true

#takes an action and checks if it is an action this node could produce
func check_legal(action):
	if not action is MoveAction: return false
	if action.speed != speed: return false
	if action.path.get_baked_length() > 100: return false
	return true

func make_action():
	var a = move_action_scene.instance()
	a.add_point(Vector2(0,0))
	a.add_point(Vector2(0,0))
	##put a second value in a for now (will be overwritten)
	return a

#all actions take only a mouse position (in local coordinates) to produce
#this function gets the action corresponding to the position.
func update_action(action, pos):
	action.path.set_point_position(1,pos)
	action.update()
	
func draw_active(delta):
	pass