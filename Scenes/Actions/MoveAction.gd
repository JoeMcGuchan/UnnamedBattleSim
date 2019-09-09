extends Action

#implements all the functionality of a move action

class_name MoveAction

# the speed of the unit, 1 is default
var speed = 1

var phase = PhaseType.MOVE
export var path : Curve2D 

var dist_traveled
var path_length

export var clearance = 0.0

func add_point(pos):
	path.add_point(pos)
	path_length = path.get_baked_length()
	update_dist_traveled(path_length)
	
func update_dist_traveled(x):
	$MovingArrowLine.distance_traveled = x
	dist_traveled = x

#returns the distance value at which this action would
#collide with the other action
func collision_dist(other_action : MoveAction):
	var max_dist = max(path_length,other_action.dist_traveled)
	for x in range(0,max_dist,1):
		var distance_along = min(x,path_length)
		var distance_along_other = min(x * other_action.speed / speed,other_action.dist_traveled)
		
		var distance_to_other = get_point_at(distance_along).distance_to(other_action.get_point_at(distance_along_other))
		if distance_to_other < (clearance + other_action.clearance):
			update_dist_traveled(min(dist_traveled,distance_along))
	
func _ready():
	$MovingArrowLine.curve = path
	$MovingArrowLine.modulate = Color.black

#returns the (vector2) position of the unit at distance x
func get_point_at(x : float):
	return path.interpolate_baked(x)

func get_end_point():
	return path.get_point_position(path.get_point_count()-1)

func reset_state():
	update_dist_traveled(path_length)
	
#updates the state, returns true if any change was made
func update_state():
	return false
	 
func resolve():
	pass