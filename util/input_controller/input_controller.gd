
extends Node

const JUST_PRESSED = 0
const PRESSED = 1
const JUST_RELEASED = 2
const RELEASED = 3

var actions = {}

func _ready():
	set_process_input(true)
	set_fixed_process(true)
	
	for c in get_children():
		actions[c.get_name()] = InputInfo.new(c.get_name())

func _fixed_process(delta):
	for c in get_children():
		if actions.has(c.get_name()):
			actions[c.get_name()].update()

# HACK! WORKAROUND GODOT ISSUE MOUSE ACTION FIXED PROCESS LAG
func _input(event):
	for c in get_children():
		if event.is_action(c.get_name()):
			if actions.has(c.get_name()):
				if event.is_action_pressed(c.get_name()):
					Input.action_press(c.get_name())
				else:
					Input.action_release(c.get_name())

func just_pressed(input_name):
	return not actions[input_name].previous_state and actions[input_name].current_state

func pressed(input_name):
	return actions[input_name].previous_state and actions[input_name].current_state

func just_released(input_name):
	return actions[input_name].previous_state and not actions[input_name].current_state

func released(input_name):
	return not actions[input_name].previous_state and not actions[input_name].current_state

class InputInfo:
	
	var action_name
	var previous_state
	var current_state
	
	func _init(action):
		action_name = action
		previous_state = false
		current_state = false
	
	func update():
		previous_state = current_state
		current_state = Input.is_action_pressed(action_name)
	
	func input_pressed(pressed):
		previous_state = current_state
		current_state = pressed