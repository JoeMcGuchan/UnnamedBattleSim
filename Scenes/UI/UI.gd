extends Control

var action_card_scene = preload("./ActionCard.tscn")

#UI that presents a series of action cards for a given unit

signal add_action_makers(action_makers)
signal next_unit()

func clear():
	for card in $Margins/ActionCardContainer.get_children():
		card.queue_free()

#adds each of the actions after a short time delay
func add_action_maker(action_maker):
	var action_card = action_card_scene.instance()
	
	#add relevant info before card is rendered
	action_card.card_text = action_maker.card_text
	action_card.card_colour = action_maker.card_colour
	action_card.overlay_title = action_maker.overlay_title
	action_card.overlay_description = action_maker.overlay_description
	action_card.overlay_colour = action_maker.overlay_colour
	action_card.connect("update_overlay",$Margins/ActionInfoDisplay,"activate")
	action_card.connect("card_selected",$Margins,"activate")
	action_card.connect("card_selected",$Margins/ActionCardContainer,"deactivate")
	action_card.connect("card_selected",action_maker,"switch_on")
	action_card.connect("card_released",$Margins/ActionInfoDisplay,"deactivate")
	action_card.connect("card_released",$Margins,"deactivate")
	action_card.connect("card_released",$Margins/ActionCardContainer,"activate")
	action_card.connect("card_released",action_maker,"switch_off")
	action_card.connect("card_released",self,"next_unit")
	
	$Margins/ActionCardContainer.add_child(action_card)
	
	#TODO Figure out a way to get the card to start on a unit
	#p is the vector2 describing where the unit is on the screen
	#var p = action_maker.get_global_transform_with_canvas().xform(Vector2(0,0))
	#p = action_card.get_global_transform_with_canvas().xform_inv(p)
	#action_card.set_card_pos(p)
	
func add_unit(unit):
	emit_signal("add_action_makers",unit.get_action_makers())
	
func next_unit():
	clear()
	emit_signal("next_unit")