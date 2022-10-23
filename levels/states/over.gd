extends State


func enter(_msg := {}) -> void:
	%MusicLoop.stop()
	%MusicChords.stop()
	%DialogNoThatIsIncorrect.play()
	await %DialogNoThatIsIncorrect.finished
	%DialogYouHaveFailed.play()
	await %DialogYouHaveFailed.finished
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	AppEvents.main_menu.emit()
