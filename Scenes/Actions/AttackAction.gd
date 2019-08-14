extends Action

export var damage : int
export var breath_cost : int

var target
	
func init(t,d,b):
	target = t
	damage = d
	breath_cost = b
	
	$AttackArrow.visible = true
	$AttackArrow.curve.set_point_position(0,Vector2(0,0))
	$AttackArrow.curve.set_point_position(1,to_local(target.global_position))