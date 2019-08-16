extends ActionMaker

#class contains all the LIMITIATIONS on a move action.

class_name AttackActionMaker,"res://Resources/Sprites/Attack.png"

var attack_action_scene = preload("res://Scenes/Actions/AttackAction.tscn") 

export var attack_distance = 32
export var attack_strength = 20
export var attack_cost = 20

var units_attackable = []

#checks if the parent unit CAN perform the action, so whether or not to
#display that action as a HoldAndReleaseButton
func check_possible():
	units_attackable = []
	for unit in get_tree().get_nodes_in_group("unit"):
		if not unit == get_parent():
			if unit.global_position.distance_to(global_position) < attack_distance + unit.radius + get_parent().radius:
				units_attackable.append(unit)
	return not units_attackable.empty()
	
func _ready():
	pass
	
#takes an action and checks if it is an action this node could produce
func check_legal(action):
	pass

func make_action():
	var a = attack_action_scene.instance()
	return a

#all actions take only a mouse position (in local coordinates) to produce
#this function gets the action corresponding to the position.
func update_action(action, pos):
	action.init(get_near_unit(pos),attack_strength,attack_cost)
	pass
	
func get_near_unit(pos):
	var dist = INF
	var nearunit = null
	for unit in units_attackable:
		if to_local(unit.global_position).distance_to(pos) < dist:
			dist = to_local(unit.global_position).distance_to(pos)
			nearunit = unit
	return nearunit

func draw_active(delta, pos):
	$AttackArrow.switch_on(get_near_unit(pos))