extends Node2D


@export var game: PackedScene



func _on_start_game_pressed():
	AppEvents.start_game.emit()


func _on_quit_pressed():
	AppEvents.quit.emit()


func _on_settings_button_pressed():
	AppEvents.settings.emit()
