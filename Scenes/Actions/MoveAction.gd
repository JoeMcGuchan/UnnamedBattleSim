extends Action

#implements all the functionality of a move action

class_name MoveAction

# the speed of the unit, 1 is default
var speed = 1

var phase = PhaseType.MOVE
export var path : Curve2D 

func add_point(pos):
	path.add_point(pos)

#returns the time value when a unit passing on this path comes within x of the unit on another path,
#reutning lenthintime otherwise	
func collision_time(other_action : MoveAction, maxdist : float):
	pass
	
func _ready():
	$MovingArrowLine.curve = path
	$MovingArrowLine.modulate = Color.black

#returns the (vector2) position of the unit at time t (as defined above)
func get_point_at(t : float):
	return path.interpolatef(t * speed / path.get_point_count())

func get_end_point():
	return path.get_point_position(path.get_point_count()-1)