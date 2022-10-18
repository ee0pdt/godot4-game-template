extends State


func enter(_msg := {}) -> void:
	%MusicLoop.stop()
	%DialogNoThatIsIncorrect.play()
	await %DialogNoThatIsIncorrect.finished
	%DialogYouHaveFailed.play()
