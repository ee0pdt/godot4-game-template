extends Node3D


var countdown_secs: float = 10


func _on_next_level_pressed():
	GameEvents.next_level.emit()


func _process(delta):
	countdown_secs -= delta
	_update_hud()


func _update_hud():
	var seconds_text: String = str(floor(countdown_secs))
	%Countdown.text = seconds_text
