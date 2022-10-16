extends State


var loop_ending: bool


func enter(_msg := {}) -> void:
	loop_ending = false
	owner.countdown = owner.idle_wait_time
	if %MusicLoop.is_playing() == false:
		%MusicLoop.play()


func update(delta: float) -> void:
	var time = owner.get_loop_time()
	print("Time is: ", time)
	
	if loop_ending:
		if time < 1:
			owner.loop_index += 1
			print("loop_index: ", owner.loop_index)
			state_machine.transition_to(owner.States.keys()[owner.States.INSTRUCTING])
	elif time > 2:
		loop_ending = true
