extends State


func enter(_msg := {}) -> void:
	owner.countdown = owner.action_wait_time


func update(delta: float) -> void:
	owner.countdown -= delta
	if owner.countdown <= 0:
		state_machine.transition_to(owner.States.keys()[owner.States.OVER])
	else:
		_check_for_right_action()


func _check_for_right_action():
	match owner.current_action:
		(owner as Level).Actions.RAISE:
			if Input.is_action_just_released("raise"):
				state_machine.transition_to(owner.States.keys()[owner.States.IDLE])
			else:
				_check_for_wrong_action()
		(owner as Level).Actions.WAVE:
			if Input.is_action_just_released("wave"):
				state_machine.transition_to(owner.States.keys()[owner.States.IDLE])
			else:
				_check_for_wrong_action()
		(owner as Level).Actions.DIP:
			if Input.is_action_just_released("dip"):
				state_machine.transition_to(owner.States.keys()[owner.States.IDLE])
			else:
				_check_for_wrong_action()
		(owner as Level).Actions.BLESS:
			if Input.is_action_just_released("bless"):
				state_machine.transition_to(owner.States.keys()[owner.States.IDLE])
			else:
				_check_for_wrong_action()


# If we are here we can assume that the player did not press the appropriate button
func _check_for_wrong_action():
	if Input.is_action_just_released("raise") or \
		Input.is_action_just_released("wave") or \
		Input.is_action_just_released("dip") or \
		Input.is_action_just_released("bless"):
			state_machine.transition_to(owner.States.keys()[owner.States.OVER])