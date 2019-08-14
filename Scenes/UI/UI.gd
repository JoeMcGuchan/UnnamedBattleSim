extends Control

var action_card_anchor_scene = preload("./ActionCardAnchor.tscn")
var action_card_button_scene = preload("../GraphicalItems/ActionCardButton.tscn")

#UI that presents a series of action cards for a given unit

var action_cards = []
var action_card_anchors = []

signal add_action_makers(action_makers)
signal next_unit()
signal on_AdjudicateButton_pressed()
signal add_to_control(button)

func clear():
	while not action_cards.empty():
		action_cards.pop_front().queue_free()
	while not action_card_anchors.empty():
		action_card_anchors.pop_front().queue_free()

#adds each of the actions after a short time delay
func add_action_maker(action_maker):
	var card_anchor = action_card_anchor_scene.instance()
	
	$Margins/ActionCardContainer.add_child(card_anchor)
	
	var action_card = action_card_button_scene.instance()
	
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
	action_card.connect("deactivate_overlay",$Margins/ActionInfoDisplay,"deactivate")
	action_card.connect("deactivate_overlay",$Margins,"deactivate")
	action_card.connect("deactivate_overlay",$Margins/ActionCardContainer,"activate")
	action_card.connect("deactivate_overlay",action_maker,"switch_off_safely")
	action_card.connect("card_released",action_maker,"switch_off")
	action_card.connect("card_released",self,"next_unit")
	
	emit_signal("add_to_control",action_card)
	
	action_card.position = action_maker.get_global_transform_with_canvas().xform(Vector2(0,0))
	
	action_card.set_following(card_anchor.get_middle_point())
	
	action_cards.append(action_card)
	action_card_anchors.append(card_anchor)
	
func add_unit(unit):
	emit_signal("add_action_makers",unit.get_possible_action_makers())
	
func next_unit():
	clear()
	emit_signal("next_unit")

func _on_AdjudicateButton_pressed():
	emit_signal("on_AdjudicateButton_pressed")
