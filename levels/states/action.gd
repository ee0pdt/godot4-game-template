extends State


func enter(_msg := {}) -> void:
	owner.countdown = owner.action_wait_time


func update(delta: float) -> void:
	owner.countdown -= delta
	if owner.countdown <= 0:
		state_machine.transition_to(owner.States.keys()[owner.States.OVER])
	else:
		_check_actions()


func _check_actions():
	match owner.current_action:
		(owner as Level).Actions.RAISE:
			if Input.is_action_just_pressed("raise"):
				state_machine.transition_to(owner.States.keys()[owner.States.INSTRUCTING])
