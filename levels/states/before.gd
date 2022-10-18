extends State


func enter(_msg := {}) -> void:
	%MusicAtmosphere.play()
	%DialogAnotherNewRecruit.play()
	await %DialogAnotherNewRecruit.finished
	%DialogDoNotBeNervous.play()
	await %DialogDoNotBeNervous.finished
	%DialogWhenYouAreReady.play()
	await %DialogWhenYouAreReady.finished


func update(delta: float) -> void:
	if (owner as Level).has_hammer:
		state_machine.transition_to((owner as Level).States.keys()[(owner as Level).States.IDLE])


func handle_input(_event):
	pass


func exit():
	%MusicAtmosphere.stop()
	%DialogAnotherNewRecruit.stop()
	%DialogDoNotBeNervous.stop()
	%DialogWhenYouAreReady.stop()
