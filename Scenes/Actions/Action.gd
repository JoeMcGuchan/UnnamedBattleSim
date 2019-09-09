extends Node2D

class_name Action

enum PhaseType {DEFEND, ATTACK, MOVE, SHOOT, NO_ACTION}

#these are actions that will be affected by a change in this action
var actions_affecting = []

#these are the actions that this action will need to consider when updating
var actions_affected_by = []

func _ready():
	for action in actions_affecting:
		add_affecting_action(action)

func add_affecting_action(action):
	if not actions_affecting.has(action): actions_affecting.append(action)
	if not action.actions_affected_by.has(action): action.actions_affected_by.append(action)
	
func add_affected_by_action(action):
	if not action.actions_affecting.has(action): action.actions_affecting.append(action)
	if not actions_affected_by.has(action): actions_affected_by.append(action)

#resets the action, CALLED EXTERNALLY
func reset_state_recursive():
	var reset_actions = QueueWithFastFind.new()
	var unexplored_actions = QueueWithFastFind.new()
	
	unexplored_actions.push_if_not_duplicate(self)
	
	while not unexplored_actions.empty():
		var action = unexplored_actions.pop()
		for affected_action in action.actions_affecting:
			if not reset_actions.has(affected_action):
				affected_action.reset_state()
				reset_actions.push_if_not_duplicate(affected_action)
				unexplored_actions.push_if_not_duplicate(affected_action)

func reset_state():
	pass

#updates the state of the action and ALL ACTIONS THAT ARE DEPENDANT ON IT
func update_state_recursive():
	var actions_to_update = QueueWithFastFind.new()
	actions_to_update.push_if_not_duplicate(self)
	
	while not actions_to_update.empty():
		var action = actions_to_update.pop()
		if action.update_state():
			for action_affected in action.actions_affecting:
				actions_to_update.push_if_not_duplicate(action_affected)
			
#updates the state, returns true if any change was made
func update_state():
	return false

#resets every action that is dependant on this one, and then updates when all
func reset_and_update_state():
	reset_state_recursive()
	update_state_recursive()

func resolve():
	pass

func get_unit():
	return get_parent()
	
func queue_free():
	for action in actions_affecting: action.actions_affected_by.remove(self)
	for action in actions_affected_by: action.actions_affecting.remove(self)
	.queue_free()