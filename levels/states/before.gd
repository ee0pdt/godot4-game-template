extends State


func enter(_msg := {}) -> void:
	%DialogAnotherNewRecruit.play()
	await %DialogAnotherNewRecruit.finished
	%DialogDoNotBeNervous.play()
	await %DialogDoNotBeNervous.finished


func update(delta: float) -> void:
	if Input.is_action_just_released("raise"):
		state_machine.transition_to((owner as Level).States.keys()[(owner as Level).States.IDLE])
