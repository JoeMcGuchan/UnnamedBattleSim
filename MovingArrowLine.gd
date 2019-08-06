extends Path2D

#Describes a line populated by arrows that move slowly

# speed of units
export var speed = 5

export var dist_between_arrows = 24

#pixel distance of fades
export var fade_in = 10
export var fade_out = 10

#distance before start and end of motion 
export var crop_in = 0
export var crop_out = 8

export var target_rev_speed = 0.5

var move_arrow_offsets = 0
var move_arrow_scene = preload("res://Scenes/GraphicalItems/MoveArrow.tscn") 

var move_arrows = []
	
func _process(delta):
	if curve.get_baked_length() > 0:
		visible = true
		
		move_arrow_offsets = fmod(move_arrow_offsets + delta * speed,float(dist_between_arrows))
		
		var numOfArrows = max(curve.get_baked_length() - crop_in - crop_out,0)
		
		numOfArrows = int(numOfArrows / dist_between_arrows)
		
		if numOfArrows > 0: numOfArrows = numOfArrows + 1
		
		#add any arrows that need to be added
		while (move_arrows.size() < numOfArrows):
			var move_arrow = move_arrow_scene.instance()
			move_arrows.append(move_arrow)
			add_child(move_arrow)
		
		var n = 0
		for move_arrow in move_arrows:	
			if (n < numOfArrows):
				move_arrow.offset = move_arrow_offsets + crop_in + n * dist_between_arrows
				
				#set fade
				var alpha = 1.0
				if (move_arrow.offset - crop_in < fade_in):
					alpha = (move_arrow.offset - crop_in)/fade_in
				if (curve.get_baked_length() - move_arrow.offset - crop_out < fade_out):
					alpha = (curve.get_baked_length() - move_arrow.offset - crop_out) / fade_out
				move_arrow.modulate = Color(1.0,1.0,1.0,alpha)
				
				n += 1
			else:
				move_arrow.queue_free()
			
		move_arrows.resize(numOfArrows)
		
		#rotate the target
		$Target.rotation = fmod($Target.rotation + delta * target_rev_speed,TAU)
		$Target.position = curve.get_point_position(curve.get_point_count() - 1)
	else:
		visible = false