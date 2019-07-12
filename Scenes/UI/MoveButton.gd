extends HoldAndReleaseButton

var move_action_scene = preload("res://Scenes/Actions/MoveAction.tscn") 

#overwritten by child
func create_action():
	var a = move_action_scene.instance()
	a.add_point(Vector2(0,0))
	a.add_point(Vector2(0,0))
	##put a second value in a for now (will be overwritten)
	return a
	
#overwritten by child
func update_action(action):
	var pos = get_global_mouse_position()
	pos = action.to_local(pos)
	action.update()
	action.path.set_point_position(1,pos)
	
func release_action(action):
	action.moving = false