extends State


func enter(_msg := {}) -> void:
	pass


func update(delta: float) -> void:
	state_machine.transition_to(owner.States.keys()[owner.States.IDLE])
