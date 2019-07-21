extends Timer

#adds actioncards to the ActionCardContainer after a short delay
signal addactionmaker(actionmaker)

var actionmakers = []

func init(new_actionmakers):
	actionmakers = new_actionmakers
	start()

func _on_ActionAddTimer_timeout():
	if (actionmakers.empty()): stop()
	else: 
		emit_signal("addactionmaker",actionmakers.pop_front())
