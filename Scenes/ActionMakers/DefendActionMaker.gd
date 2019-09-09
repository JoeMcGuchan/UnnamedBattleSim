extends ActionMaker

#class contains all the LIMITIATIONS on a move action.

class_name DefendActionMaker,"res://Resources/Sprites/Icons/DefendIcon.png"

var defend_action_scene = preload("res://Scenes/Actions/DefendAction.tscn") 

var units_defendable = []

#checks if the parent unit CAN perform the action, so whether or not to
#display that action as a HoldAndReleaseButton
func check_possible():
	units_defendable = []
	for unit in get_tree().get_nodes_in_group("unit"):
		if not unit == get_parent():
			if is_attackable_by(unit):
				units_defendable.append(unit)
	return not units_defendable.empty()
	
func _ready():
	pass
	
func is_attackable_by(unit):
	for action_maker in unit.get_all_action_makers():
		if action_maker is AttackActionMaker:
			if unit.global_position.distance_to(global_position) < action_maker.attack_distance + unit.radius + get_parent().radius:
				return true
	return false
	
#takes an action and checks if it is an action this node could produce
func check_legal(action):
	pass

func make_action():
	var a = defend_action_scene.instance()
	return a

#all actions take only a mouse position (in local coordinates) to produce
#this function gets the action corresponding to the position.
func update_action(action, pos):
	action.init(get_near_unit(pos))
	pass
	
func get_near_unit(pos):
	var dist = INF
	var nearunit = null
	for unit in units_defendable:
		if to_local(unit.global_position).distance_to(pos) < dist:
			dist = to_local(unit.global_position).distance_to(pos)
			nearunit = unit
	return nearunit

func draw_active(delta, pos):
	$DefendVisual.switch_on(get_near_unit(pos))