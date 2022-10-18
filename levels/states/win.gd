extends State


func enter(_msg := {}) -> void:
	%MusicLoop.stop()
	%DialogVeryGood.play()
	await %DialogVeryGood.finished
	%DialogCongratulations.play()
	await %DialogCongratulations.finished
	%DialogPleaseReturnToTheFoyer.play()
