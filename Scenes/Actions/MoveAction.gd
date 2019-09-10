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

#for building the collision shape
var circle_shape = load("res://Scenes/Misc/CollisionShapes/CircleCollisionShape.tscn")
var rect_shape = load("res://Scenes/Misc/CollisionShapes/RectCollisionShape.tscn")

func add_point(pos):
	#add a circle where the pos is
	var circle_shape_instance = circle_shape.instance()
	circle_shape_instance.set_radius(clearance)
	circle_shape_instance.position = pos
	$CollisionArea.add_child(circle_shape_instance)
	
	if path.get_point_count() > 0:
		#add a rectangle to connect the last point with this one
		var last_point_pos = path.get_point_position(path.get_point_count() - 1)
		
		var rect_shape_instance = rect_shape.instance()
		rect_shape_instance.position = last_point_pos
		rect_shape_instance.stretch_to(pos-last_point_pos,clearance)
		$CollisionArea.add_child(rect_shape_instance)
	
	path.add_point(pos)
	path_length = path.get_baked_length()
	update_dist_traveled(path_length)
	
func update_dist_traveled(x):
	$MovingArrowLine.distance_traveled = x
	dist_traveled = x

#returns the distance value at which this action would
#collide with the other action, assuming we are not
#stopped by anything (and the other action has the right
#dist_traveled)
func collision_dist(other_action : MoveAction):
	var max_dist = max(path_length,other_action.dist_traveled)
	
	for x in range(0,max_dist,1):
		var distance_along = min(x,path_length)
		var this_point = self.to_global(get_point_at(distance_along))
		
		var distance_along_other = min(x * other_action.speed / speed,other_action.dist_traveled)
		var other_point = other_action.to_global(other_action.get_point_at(distance_along_other))

		var distance_to_other = this_point.distance_to(other_point)
		if distance_to_other < (clearance + other_action.clearance):
			return distance_along
			
	return path_length
	
func _ready():
	$MovingArrowLine.curve = path
	$MovingArrowLine.modulate = Color.black

#returns the (vector2) position of the unit at distance x
func get_point_at(x : float):
	return path.interpolate_baked(x)

func get_end_point():
	return path.get_point_position(path.get_point_count()-1)

func reset_state():
	if abs(path_length - dist_traveled) > 0.1:
		update_dist_traveled(path_length)
		return true
	return false
	
#updates the state, returns true if any change was made
func update_state():
	var any_change = false
	
	var min_dist = path_length
	for action in actions_affected_by:
		min_dist = min(min_dist,collision_dist(action))
	
	#equality in floats is spooky so instead we'll check if we're within
	#one pixel
	
	print(min_dist)
	
	if abs(min_dist - dist_traveled) > 0.1:
		update_dist_traveled(min_dist)
		any_change = true
	
	return any_change
	 
func resolve():
	pass

func _on_CollisionArea_area_entered(area):
	add_affected_by_action(area.get_parent())
