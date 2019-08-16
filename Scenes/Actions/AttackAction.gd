extends Action

export var damage : int
export var breath_cost : int

var target

var phase = PhaseType.ATTACK
	
func init(t,d,b):
	target = t
	damage = d
	breath_cost = b
	
	$AttackArrow.switch_on(t)