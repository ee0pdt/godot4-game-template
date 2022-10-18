extends State


var loop_ending: bool


func enter(_msg := {}) -> void:
	loop_ending = false
	
	if %MusicLoop.is_playing() == false:
		%MusicLoop.play()
	
	if (owner as Level).points > (owner as Level).points_target:
		state_machine.transition_to((owner as Level).States.keys()[(owner as Level).States.WIN])


func update(delta: float) -> void:
	var time = (owner as Level).get_loop_time()
	
	if loop_ending:
		if time < 0.5:
			(owner as Level).loop_index += 1
			print("loop_index: ", (owner as Level).loop_index)
			state_machine.transition_to((owner as Level).States.keys()[(owner as Level).States.INSTRUCTING])
	elif time > (owner as Level).LOOP_LENGTH:
		loop_ending = true
