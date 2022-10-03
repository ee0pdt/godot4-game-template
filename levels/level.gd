extends Node3D


enum States {
	BEFORE,
	PLAYING,
	OVER
}

var countdown_secs: float = 10
var current_state = States.BEFORE
var total_time: float = 0
var button_hit: bool = false


func _ready():
	GameEvents.button_pressed.connect(self._handle_button_pressed)
	$SoundFirstInstruction.play()


func _handle_button_pressed():
	match current_state:
		States.BEFORE:
			$SoundMusic.play()
			current_state = States.PLAYING
			%Button/AnimationPlayer.play("ButtonRise")
			$"3DWorld/AnimationPlayer".play("Moves")
#			$"3DWorld/AnimationPlayer".advance(100)
		States.PLAYING:
			button_hit = true
		States.OVER:
			pass


func _on_next_level_pressed():
	GameEvents.next_level.emit()


func _process(delta):
	match current_state:
		States.PLAYING:
			countdown_secs -= delta
			if countdown_secs <= 0:
				if button_hit:
					countdown_secs = 10
					%Button/AnimationPlayer.play("ButtonRise")
					button_hit = false
				else:
					countdown_secs = 0
					current_state = States.OVER
					GameEvents.next_level.emit()
			
			total_time += delta
			_update_hud()
		_:
			pass


func _update_hud():
	%Countdown.text = _time_to_str(countdown_secs)
	%Countup.text = _time_to_str(total_time)


func _time_to_str(time):
	return str(ceil(time))


func _on_animation_player_animation_finished(anim_name):
	AppEvents.main_menu.emit() # Replace with function body.
