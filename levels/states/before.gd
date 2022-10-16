extends State


func enter(_msg := {}) -> void:
	pass


func update(delta: float) -> void:
	state_machine.transition_to((owner as Level).States.keys()[(owner as Level).States.IDLE])
