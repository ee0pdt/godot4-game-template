extends Node2D


@export var game: PackedScene


func _ready() -> void:
	_toggle_sound()


func _on_done_button_pressed() -> void:
	AppEvents.main_menu.emit()
	get_tree().paused = false


func _toggle_sound() -> void:
	if %MusicTestSound.playing:
		%MusicTestSound.stop()
		%SoundEffectsTestSound.stop()
		%DialogTestSound.stop()
	else:
		%MusicTestSound.play()
		%SoundEffectsTestSound.play()
		%DialogTestSound.play()



func _on_test_audio_toggle_toggled(button_pressed: bool) -> void:
	_toggle_sound()
