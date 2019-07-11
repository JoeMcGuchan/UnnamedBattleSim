extends Button

#base class for all buttons that when pressed create an action, and then continually updates that action until the button is released

class_name HoldAndReleaseButton

var action

var button_held = false

signal button_pressed(a)
signal button_released

#overwritten by child
func create_action():
	pass

#overwritten by child
func update_action(action):
	pass
	
func _process(delta):
	if button_held:
		update_action(action)

func _on_HoldAndReleaseButton_button_up():
	button_held = false
	emit_signal("button_released")


func _on_HoldAndReleaseButton_button_down():
	button_held = true
	action = create_action()
	emit_signal("button_pressed",action)
