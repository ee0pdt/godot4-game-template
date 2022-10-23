extends State


func enter(_msg := {}) -> void:
	%MusicLoop.stop()
	%MusicChords.stop()
	%DialogVeryGood.play()
	await %DialogVeryGood.finished
	%DialogCongratulations.play()
	await %DialogCongratulations.finished
	%DialogPleaseReturnToTheFoyer.play()
	await %DialogPleaseReturnToTheFoyer.finished
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	AppEvents.main_menu.emit()
