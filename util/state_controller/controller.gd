
extends Node

export(bool) var enabled = true
export(NodePath) var current_state = NodePath("idle") setget set_state
export(NodePath) var control = NodePath("..") setget set_control

# This is the current state of the object
var STATE = null
# This is the object we're controlling
var CONTROL = null

func set_state(s):
	current_state = s
	STATE = get_node(s)

func set_control(c):
	control = c
	CONTROL = get_node(c)

func _ready():
	set_fixed_process(true)
	self.current_state = current_state
	self.control = control
	
	for c in get_children():
		c.set("CONTROL", CONTROL)
	
	if STATE != null:
		STATE.enter_state()

func _fixed_process(delta):
	process_state(delta)

func process_state(delta):
	if enabled:
		STATE.process_state(delta)

func change_state(state_name):
	var new_state = get_node(state_name)
	if STATE != new_state:
		STATE.exit_state()
		STATE = new_state
		STATE.enter_state()

func get_state_name():
	return STATE.get_name()

func is_state(name):
	return STATE.get_name() == name