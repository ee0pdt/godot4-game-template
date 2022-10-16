extends State


func enter(_msg := {}) -> void:
	owner.current_action = owner.Actions.values()[randi_range(0, owner.Actions.size()-1)]
	
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
	state_machine.transition_to(owner.States.keys()[owner.States.ACTION])
