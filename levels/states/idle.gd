extends State


func enter(_msg := {}) -> void:
	owner.countdown = owner.idle_wait_time
	%MusicLoop.play()


func update(delta: float) -> void:
	var time = %MusicLoop.get_playback_position() + AudioServer.get_time_since_last_mix()
	# Compensate for output latency.
	time -= AudioServer.get_output_latency()
	print("Time is: ", time)
	
	if time >= 2:
		state_machine.transition_to(owner.States.keys()[owner.States.INSTRUCTING])
