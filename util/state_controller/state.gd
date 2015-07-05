# DEFAULT PARENT SCRIPT FOR STATES IN STATE_CONTROLLER

extends Node

# CONTROL'ed node
var CONTROL

func _ready():
	pass

func enter_state():
	pass

func exit_state():
	pass

func process_state(delta):
	pass

func change_state(state_name):
	get_parent().change_state(state_name)
