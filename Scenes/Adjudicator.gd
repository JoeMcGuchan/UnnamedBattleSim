extends Node

#can be called to make all the moves in a 
var units
export var adjudication_method : Resource

func _adjudicate():
	units = get_tree().get_nodes_in_group("unit")
	adjudication_method.adjudicate(units)