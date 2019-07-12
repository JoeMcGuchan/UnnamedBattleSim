extends Action

#implements all the functionality of a move action

class_name MoveAction

# the speed of the unit, 1 is default
var speed = 1

var phase = PhaseType.MOVE
export var path : Curve2D 

#constants for use by the yellow arrow animation
const SPEED_MULTIPLY = 10
const DIST_BETWEEN_ARROWS = 24

const FADE_IN = 32
const FADE_OUT = 32

var move_arrow_offsets = 0
var move_arrow_scene = preload("res://Scenes/UI/MoveArrow.tscn") 

var moving = true

var move_arrows = []

func add_point(pos):
	path.add_point(pos)

#returns the time value when a unit passing on this path comes within x of the unit on another path,
#reutning lenthintime otherwise	
func collision_time(other_action : MoveAction, maxdist : float):
	pass
	
func _ready():
	$PathForArrows.curve = path

#returns the (vector2) position of the unit at time t (as defined above)
func get_point_at(t : float):
	return path.interpolatef(t * speed / path.get_point_count())

func get_end_point():
	return path.get_point_position(path.get_point_count()-1)
	
func _process(delta):
	if moving:
		move_arrow_offsets = fmod(move_arrow_offsets + delta * speed * SPEED_MULTIPLY,float(DIST_BETWEEN_ARROWS))
		var numOfArrows = int(path.get_baked_length() / DIST_BETWEEN_ARROWS) + 1
		
		#add any arrows that need to be added
		while (move_arrows.size() < numOfArrows):
			var move_arrow = move_arrow_scene.instance()
			move_arrows.append(move_arrow)
			$PathForArrows.add_child(move_arrow)
		
		var n = 0
		for move_arrow in move_arrows:	
			if (n < numOfArrows):
				move_arrow.offset = move_arrow_offsets + n * DIST_BETWEEN_ARROWS
				
				#set fade
				var alpha = 1.0
				if (move_arrow.offset < FADE_IN):
					alpha = move_arrow.offset/FADE_IN
				if (path.get_baked_length() - move_arrow.offset < FADE_OUT):
					alpha = (path.get_baked_length() - move_arrow.offset) / FADE_OUT
				move_arrow.modulate = Color(1.0,1.0,1.0,alpha)
				
				n += 1
			else:
				move_arrow.queue_free()
			
		move_arrows.resize(numOfArrows)
	