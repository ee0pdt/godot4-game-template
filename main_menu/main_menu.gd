extends Node2D


@export var game: PackedScene


func _on_start_game_pressed() -> void:
	AppEvents.start_game.emit()


func _on_quit_pressed() -> void:
	AppEvents.quit.emit()


func _on_settings_button_pressed() -> void:
	AppEvents.settings.emit()
