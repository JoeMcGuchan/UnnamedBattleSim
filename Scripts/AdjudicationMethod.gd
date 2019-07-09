#as per the Method pattern, this resource is used by an adjuicator to... well... adjuicate
extends Resource

class_name AdjudicationMethod

func adjudicate(units):
#sort into lists 
	var defending_units = []
	var attacking_units = []
	var moving_units = []
	var shooting_units = []

	for unit in units:
		match unit.get_action().phase:
			Action.PhaseType.DEFEND:
				defending_units.append(unit)
			Action.PhaseType.ATTACK:
				attacking_units.append(unit)
			Action.PhaseType.MOVE:
				moving_units.append(unit)
			Action.PhaseType.SHOOT:
				shooting_units.append(unit)

	call_melee_phase(defending_units, attacking_units)
	call_move_phase(moving_units)
	call_shooting_phase(shooting_units)
	
	pass

#call all attcks, blocks, counterattacks, grapples
func call_melee_phase(defending_units, attacking_units):
	call_block_phase(defending_units)
	call_attack_phase(attacking_units)
	pass

func call_block_phase(defending_units):
	pass
	
func call_attack_phase(attacking_units):
	pass

#call all moves, charge attacks, rests, insights, heals, etc
func call_move_phase(moving_units):
	for unit in moving_units:
		var action = unit.get_action()
		if action is MoveAction:
			unit.global_position = action.destination
		pass
	pass

#fire all guns
func call_shooting_phase(shooting_units):
	pass