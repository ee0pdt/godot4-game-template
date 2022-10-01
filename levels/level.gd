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
			current_state = States.PLAYING
		States.PLAYING:
			countdown_secs = 10
		_:
			pass


func _on_next_level_pressed():
	GameEvents.next_level.emit()


func _process(delta):
	if current_state == States.PLAYING:
		countdown_secs -= delta
		total_time += delta
		_update_hud()


func _update_hud():
	var seconds_text: String = str(ceil(countdown_secs))
	%Countdown.text = seconds_text
