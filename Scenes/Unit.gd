extends Node2D

class_name Unit

var health = 100
var breath = 100

var experience = 0

var next_action

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
	
func _draw():
	draw_circle(Vector2(0,0), 16, Color.black)
	draw_circle(Vector2(0,0), 15, Color.lightblue)