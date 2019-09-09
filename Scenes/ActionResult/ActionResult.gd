extends Node2D

class_name ActionResult

#describes the RESULT of an action.

#the adjudicator takes units and associated actions and returns
#units and associated actionresults

#action results can be "resolved", updating the scene.

export var priority = 0

func resolve():
	pass