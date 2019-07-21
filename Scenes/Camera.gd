extends Node2D

#This is the boundary between the UI and the game state. It takes in from the
#UI when an action card has been selected, and other button presses. It takes
#from the scene a sequence of units. It translates the button presses from UI
#into actions to perform on the units.

signal adjudicate
signal add_unit(unit)

#HOW THIS UI WORKS
#We are focused on the moves for a specific unit, when we are done we move onto the next unit

var current_unit : Unit
var next_units

var target_pos

#amount to interpolate between camera pos and target pos
const MOVE_FACTOR = 5
#max dist the camera can move
const MOVE_MIN_SPEED = 0.01
#min dist the camera can move
const MOVE_MAX_SPEED = 10

#jump to the first unit and update the current list of units
func reset_units():
	next_units = get_tree().get_nodes_in_group("unit")
	if not next_units.empty():
		set_unit(next_units.pop_front())
	else:
		pass
		#TODO

func next_unit():
	if not next_units.empty():
		set_unit(next_units.pop_front())
	else:
		reset_units()

func set_unit(unit):
	current_unit = unit
	target_pos = unit.position
	emit_signal("add_unit",unit)
	
func _ready():
	reset_units()

func _on_AdjudicateButton_pressed():
	emit_signal("adjudicate")

func _on_hold_and_release_button_pressed(action):
	current_unit._add_action(action)
	
func _process(delta):
	if ($Camera.position != target_pos):
		var speed = (target_pos - $Camera.position)*MOVE_FACTOR*delta
		speed = speed.clamped(MOVE_MAX_SPEED)
		if (speed.length() < MOVE_MIN_SPEED): 
			$Camera.position = target_pos
		else: 
			$Camera.position += speed
		