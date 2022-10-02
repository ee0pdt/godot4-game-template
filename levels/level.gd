extends Node3D


enum States {
	BEFORE,
	PLAYING,
	OVER
}

var countdown_secs: float = 10
var current_state = States.BEFORE
var total_time: float = 0


func _ready():
	GameEvents.button_pressed.connect(self._handle_button_pressed)


func _handle_button_pressed():
	match current_state:
		States.BEFORE:
			$SoundMusic.play()
			current_state = States.PLAYING
		States.PLAYING:
			countdown_secs = 10
		States.OVER:
			pass


func _on_next_level_pressed():
	GameEvents.next_level.emit()


func _process(delta):
	match current_state:
		States.PLAYING:
			countdown_secs -= delta
			if countdown_secs <= 0:
				countdown_secs = 0
				current_state = States.OVER
				GameEvents.next_level.emit()
			else:
				total_time += delta
			
			_update_hud()
		_:
			pass


func _update_hud():
	%Countdown.text = _time_to_str(countdown_secs)
	%Countup.text = _time_to_str(total_time)


func _time_to_str(time):
	return str(ceil(time))
