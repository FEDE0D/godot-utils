### class for input handling. Returns 4 button states

var input_name
var prev_state
var current_state
var input

var output_state
var state_old

const RELEASED = 0
const JUST_PRESSED = 1
const PRESSED = 2
const JUST_RELEASED = 3

### Get the input name and store it
func _init(var input_name):
	self.input_name = input_name
	
### check the input and compare it with previous states
func update():
	input = Input.is_action_pressed(self.input_name)
	prev_state = current_state
	current_state = input
	
	state_old = output_state
	
	if not prev_state and not current_state:
		output_state = RELEASED ### Released
	if not prev_state and current_state:
		output_state = JUST_PRESSED ### Just Pressed
	if prev_state and current_state:
		output_state = PRESSED ### Pressed
	if prev_state and not current_state:
		output_state = JUST_RELEASED ### Just Released
	
	return output_state
	
func state():
	return output_state
