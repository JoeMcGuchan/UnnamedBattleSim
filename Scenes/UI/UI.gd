extends Camera2D

signal adjudicate

#HOW THIS UI WORKS
#We are focused on the moves for a specific unit, when we are done we move onto the next unit

var current_unit : Unit
var next_units



#jump to the first unit and update the current list of units
func reset_units():
	next_units = get_tree().get_nodes_in_group("units")
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
	position = unit.position
	
func _ready():
	reset_units()

func _on_AdjudicateButton_pressed():
	emit_signal("adjudicate")

func _on_hold_and_release_button_pressed(action):
	current_unit._add_action(action)
