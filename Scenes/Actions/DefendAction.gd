extends Action

var target

var phase = PhaseType.DEFEND

func init(u):
	target = u
	$DefendVisual.switch_on(u)