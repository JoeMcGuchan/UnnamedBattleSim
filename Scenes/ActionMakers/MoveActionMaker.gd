extends ActionMaker

#class contains all the LIMITIATIONS on a move action.

class_name MoveActionMaker,"res://Resources/Sprites/MoveIcon.png"

var speed = 1
var max_distance = 150

#distance to steer clear of other units, typically the radius
#of the unit plus some amount
var clear_distance = 16

const CIRCLE_POINTS = 32

var move_action_scene = preload("res://Scenes/Actions/MoveAction.tscn") 

#checks if the parent unit CAN perform the action, so whether or not to
#display that action as a HoldAndReleaseButton
func check_possible():
	return true
	
func _ready():
	var nav_poly = NavigationPolygon.new()

	nav_poly.add_outline(make_circle_poly(CIRCLE_POINTS,max_distance,Vector2(0,0)))
#
#	for unit in get_tree().get_nodes_in_group("unit"):
#		nav_poly.add_outline(
#			make_circle_poly(
#				CIRCLE_POINTS,
#				clear_distance+unit.radius,
#				to_local(unit.global_position)))

	nav_poly.make_polygons_from_outlines()

	$Nav.navpoly_add(nav_poly,Transform2D())

func make_circle_poly(precision, r, translation):
	var p = PoolVector2Array([])
	for n in range(precision):
		var angle = TAU * float(n) / float(precision)
		p.append(Vector2(sin(angle) * r,cos(angle) * r)+translation)
	return p
		
#takes an action and checks if it is an action this node could produce
func check_legal(action):
	if not action is MoveAction: return false
	if action.speed != speed: return false
	if action.path.get_baked_length() > max_distance: return false
	return true

func make_action():
	var a = move_action_scene.instance()
	#put a second value in a for now (will be overwritten)
	return a

#all actions take only a mouse position (in local coordinates) to produce
#this function gets the action corresponding to the position.
func update_action(action, pos):
	action.clearance = clear_distance
	for vec in $Nav.get_simple_path(Vector2(0,0),pos):
		action.add_point(vec)
	
func draw_active(delta, pos):
	var c = Curve2D.new()
	for vec in $Nav.get_simple_path(Vector2(0,0),pos):
		c.add_point(vec)
	$MovingArrowLine.curve = c