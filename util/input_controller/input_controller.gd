
extends Node

var input_states = preload("input_states.gd")

func _ready():
	set_fixed_process(true)
	
	for c in get_children():
		var input_info = input_states.new(c.get_name())
		c.set_meta("input_info",input_info)

func _fixed_process(delta):
	update()

func update():
	for c in get_children():
		c.get_meta("input_info").update()

func state(input_name):
	if get_node(input_name) == null:
		print("ERROR: The node '",input_name,"' does not exist")
		return
	return get_node(input_name).get_meta("input_info").state()

func released(input_name):
	return self.state(input_name) == input_states.RELEASED

func just_released(input_name):
	return self.state(input_name) == input_states.JUST_RELEASED

func pressed(input_name):
	return self.state(input_name) == input_states.PRESSED

func just_pressed(input_name):
	return self.state(input_name) == input_states.JUST_PRESSED