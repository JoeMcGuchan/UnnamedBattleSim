extends Node2D

class_name Unit,"res://Resources/Sprites/Icons/UnitIcon.png"

var health = 100
var breath = 100

var experience = 0

var next_action

var radius = 16

func _ready():
	#get the first child that is an action
	find_next_action()

#searches the children and returns the next_action
func get_action():
	if (next_action == null): find_next_action()
	return next_action

func find_next_action():
	for child in get_children():
		if child is Action:
			next_action = child
			break

func _add_action(action):
	if (next_action != null):
		clear_action()
	add_child(action)
	next_action = action
	
func clear_action():
	next_action.queue_free()
	next_action = null
	
func get_action_makers():
	var action_makers = []
	for node in get_children():
		if node.is_in_group("action_maker"):
			action_makers.append(node)
	return action_makers