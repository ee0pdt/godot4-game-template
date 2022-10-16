extends State


func enter(_msg := {}) -> void:
	owner.current_action = owner.Actions.values()[randi_range(0, owner.Actions.size()-1)]


func update(delta: float) -> void:
	state_machine.transition_to(owner.States.keys()[owner.States.ACTION])
