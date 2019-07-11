extends Action

#implements all the functionality of a move action

class_name MoveAction

# the time that it takes for the unit to go from the start to the end of the path
# where 1 is the length of a regular movement
var length_in_time : float = 1

var phase = PhaseType.MOVE
export var path : Curve2D 

func set_path(path_new):
	path = path_new
	
func add_point(pos):
	path.add_point(pos)

#returns the time value when a unit passing on this path comes within x of the unit on another path,
#reutning lenthintime otherwise	
func collision_time(other_action : MoveAction, maxdist : float):
	pass

#returns the (vector2) position of the unit at time t (as defined above)
func get_point_at(t : float):
	var time_per_point = length_in_time / path.get_point_count()
	return path.interpolatef(t / time_per_point)

func get_end_point():
	return get_point_at(length_in_time)
	
func _process(delta):
	print(path.get_point_count())

func _draw():
	draw_polyline(path.get_baked_points(), Color.red, 2.0)