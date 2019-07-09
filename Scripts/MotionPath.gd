#describes the motion of a move action RELATIVE TO THE WORLD
extends Curve2D

class_name MotionPath

# the time that it takes for the unit to go from the start to the end of the path
# where 1 is the length of a regular movement
var length_in_time : float 

#returns the (vector2) position of the unit at time t (as defined above)
func pos_at_time(t : float):
	pass

#returns the time value when a unit passing on this path comes within x of the unit on another path,
#reutning lenthintime otherwise	
func collision_time(path : MotionPath, maxdist : float):
	pass

func get_point_at(t : float):
	var time_per_point = length_in_time / get_point_count()
	return interpolatef(t / time_per_point)