extends State


func enter(_msg := {}) -> void:
	owner.countdown = owner.idle_wait_time


func update(delta: float) -> void:
	owner.countdown -= delta
	if owner.countdown <= 0:
		state_machine.transition_to(owner.States.keys()[owner.States.INSTRUCTING])
