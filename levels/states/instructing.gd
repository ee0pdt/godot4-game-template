extends State


func enter(_msg := {}) -> void:
	(owner as Level).current_action = (owner as Level).Actions.values()[randi_range(0, (owner as Level).Actions.size()-1)]
	
	match owner.current_action:
		(owner as Level).Actions.RAISE:
			%DialogRaiseIt.play()
		(owner as Level).Actions.WAVE:
			%DialogWaveIt.play()
		(owner as Level).Actions.DIP:
			%DialogDipIt.play()
		(owner as Level).Actions.BLESS:
			%DialogBlessIt.play()


func update(delta: float) -> void:
	state_machine.transition_to((owner as Level).States.keys()[(owner as Level).States.ACTION])
