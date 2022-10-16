extends State


var loop_ending: bool
var success: bool


func enter(_msg := {}) -> void:
	loop_ending = false
	success = false
	print("Action")


func update(delta: float) -> void:
	var time = (owner as Level).get_loop_time()
	
#	print("Time: ", time)
	
	if loop_ending:
		if time < 0.5:
			if success:
				state_machine.transition_to((owner as Level).States.keys()[(owner as Level).States.IDLE])
			else:
				state_machine.transition_to((owner as Level).States.keys()[(owner as Level).States.OVER])
	elif time >= (owner as Level).LOOP_LENGTH:
		loop_ending = true 
	
	_check_for_right_action()


func _check_for_right_action():
	match owner.current_action:
		(owner as Level).Actions.RAISE:
			if Input.is_action_just_released("raise"):
				success = true
			else:
				_check_for_wrong_action()
		(owner as Level).Actions.WAVE:
			if Input.is_action_just_released("wave"):
				success = true
			else:
				_check_for_wrong_action()
		(owner as Level).Actions.DIP:
			if Input.is_action_just_released("dip"):
				success = true
			else:
				_check_for_wrong_action()
		(owner as Level).Actions.BLESS:
			if Input.is_action_just_released("bless"):
				success = true
			else:
				_check_for_wrong_action()


# If we are here we can assume that the player did not press the appropriate button
func _check_for_wrong_action():
	if Input.is_action_just_released("raise") or \
		Input.is_action_just_released("wave") or \
		Input.is_action_just_released("dip") or \
		Input.is_action_just_released("bless"):
			state_machine.transition_to((owner as Level).States.keys()[(owner as Level).States.OVER])
