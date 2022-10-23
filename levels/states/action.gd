extends State


var loop_ending: bool
var success: bool


func enter(_msg := {}) -> void:
	loop_ending = false
	success = false


func update(delta: float) -> void:
	var time = (owner as Level).get_loop_time()
	
#	print("Time: ", time)
	
	if loop_ending:
		if time < 0.5:
			if success:
				(owner as Level).points += 1
				if (owner as Level).points % 4 == 0:
					(owner as Level).time_scale += 0.1
					Engine.time_scale *= (owner as Level).time_scale
					(%MusicLoop as AudioStreamPlayer).pitch_scale = owner.time_scale
				
				state_machine.transition_to((owner as Level).States.keys()[(owner as Level).States.IDLE])
			else:
				state_machine.transition_to((owner as Level).States.keys()[(owner as Level).States.OVER])
	elif time >= (owner as Level).LOOP_LENGTH:
		loop_ending = true 
	
	if not success:
		_check_for_right_action()


func _check_for_right_action():
	match owner.current_action:
		(owner as Level).Actions.RAISE:
			if Input.is_action_just_released("raise"):
				%Player.raise_it()
				success = true
			else:
				_check_for_wrong_action()
		(owner as Level).Actions.WAVE:
			if Input.is_action_just_released("wave"):
				%Player.wave_it()
				success = true
			else:
				_check_for_wrong_action()
		(owner as Level).Actions.DIP:
			if Input.is_action_just_released("dip"):
				%Player.dip_it()
				success = true
			else:
				_check_for_wrong_action()
		(owner as Level).Actions.BLESS:
			if Input.is_action_just_released("bless"):
				%Player.bless_it()
				success = true
			else:
				_check_for_wrong_action()


# If we are here we can assume that the player did not press the appropriate button
func _check_for_wrong_action():
	if Input.is_action_just_released("raise") or \
		Input.is_action_just_released("wave") or \
		Input.is_action_just_released("dip") or \
		Input.is_action_just_released("bless"):
			state_machine.transition_to((owner as Level).States.keys()[(owner as Level).States.OVER])
